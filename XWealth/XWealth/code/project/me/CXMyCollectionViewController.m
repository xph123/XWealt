//
//  CXMyCollectionViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyCollectionViewController.h"
#import "CXInformationDetailViewController.h"
@interface CXMyCollectionViewController ()

@end

@implementation CXMyCollectionViewController

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)loadView
{
    [super loadView];
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y +=kSmallMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kSmallMargin;
    
    _tableView = [[CXMyCollectionTableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    

    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"你还没有收藏!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    
    self.navigationItem.title=@"我的收藏";
    
    self.curPage = BASE_PAGE;
     [self loadInformationWithCategoryFromPage:self.curPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -  network data
- (void) loadInformationWithCategoryFromPage:(NSInteger)page
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
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_FAVORITEINFOLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get banner list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
        }
        else
        {
            [self.tableView.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get banner list fail");
            
        }
    }];
}

- (void) delReleaseFromServer:(NSInteger)index
{
    CXInformationModel *model = [self.sourceDatas objectAtIndex:index];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"flag" andLongValue:0];
    
    [parametersUtil appendParameterWithName:@"informationId" andLongValue:model.informationId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_FAVORITEINFO result:^(CXMainPlate *mainPlate, NSError *err) {
        
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

#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
        NSIndexPath *indexPath = (NSIndexPath*)data;
        CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
        detailController.informationId = model.informationId;
        detailController.hidesBottomBarWhenPushed = YES;
    
        [ self.navigationController pushViewController:detailController animated:YES];
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
            self.curPage ++;
             [self loadInformationWithCategoryFromPage:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
             [self loadInformationWithCategoryFromPage:self.curPage];
        }
    }
}
- (void)updateDelegateView
{
    
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
@end
