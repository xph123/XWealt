//
//  CXMyReleaseViewController.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyReleaseViewController.h"
#import "CXProductDetailWebViewController.h"
#import "UDCustomNavigation.h"
@interface CXMyReleaseViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end

@implementation CXMyReleaseViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kDefaultMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kDefaultMargin*2;
    
    //    tableVFrame.origin.x = kDefaultMargin;
    //    tableVFrame.size.width = kScreenWidth - 2 * kDefaultMargin;
    //    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin;
    //    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    
    _tableView = [[CXReleaseTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"您还未发布产品!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringMyRelease;
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    [self loadMyReleaseFromServer:self.curPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  network data


- (void) loadMyReleaseFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }

    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTMYRELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get release list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get release list fail");
        }
    }];
}

- (void) delReleaseFromServer:(NSInteger)index
{
    CXProductReleaseModel *model = [self.sourceDatas objectAtIndex:index];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"releaseId" andLongValue:model.releaseId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_DELRELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"delReleaseFromServer success");
            
            [self.sourceDatas removeObjectAtIndex:index];
            [self.tableView configData:self.sourceDatas];
        }
        else
        {
            XLog(@"delReleaseFromServer fail");
            [self ShowProgressHUB:(NSString *)err];
        }
    }];
}

#pragma mark - CXReleaseTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXProductReleaseModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    if (model.productId!=0&&model.productId) {
//        CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//        detailController.hidesBottomBarWhenPushed = YES;
//        detailController.productId = model.productId;
//        [ self.navigationController pushViewController:detailController animated:YES];
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = model.productId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"产品未上架";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

    }
   
    
    
}

- (void)deleteItemAtIndex:(NSInteger)index
{
    self.delIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"删除", nil) otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self delReleaseFromServer:self.delIndex];
    }
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_loadMoreView.state != LoadMoreStateComplete) {
        _loadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count > 0)
        {
            self.curPage++;
            [self loadMyReleaseFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadMyReleaseFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
