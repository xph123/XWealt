//
//  CXMySubscribeViewController.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMySubscribeViewController.h"
#import "CXSubscribeViewController.h"
#import "CXProductDetailWebViewController.h"

@interface CXMySubscribeViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMySubscribeViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kDefaultMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kDefaultMargin*2 + kButtomBarHeight;
    
    _tableView = [[CXSubscribeTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"您还未预约产品，请到产品详情里按[我要预约]预约产品!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
    [self subscribeView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringMySubscribe;
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    [self loadMySubscribeFromServer:self.curPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) subscribeView
{
    CGRect frame = self.view.frame;
    frame.size.height -=  kViewEndSizeHeight + kButtomBarHeight + kDefaultMargin;
    CGRect rect = CGRectMake(0, frame.size.height + kDefaultMargin, kScreenWidth, kButtomBarHeight);
    UIView *buttomView = [[UIView alloc] initWithFrame:rect];
    buttomView.backgroundColor = kColorWhite;

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    lineView.backgroundColor = kLineColor;
    [buttomView addSubview:lineView];

    UIButton *subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, kSmallMargin, kScreenWidth - 40, kButtomBarHeight - 2 * kSmallMargin)];
    [subscribeBtn setBackgroundColor:kMainStyleColor];
    subscribeBtn.layer.masksToBounds = YES;
    subscribeBtn.layer.cornerRadius = kRadius;
    subscribeBtn.layer.borderColor = kLineColor.CGColor;
    subscribeBtn.layer.borderWidth = 1;
    [subscribeBtn setTitle: @"我要预约" forState: UIControlStateNormal];
    subscribeBtn.titleLabel.font = kLargeTextFont;
    [subscribeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
//    [subscribeBtn setImage:[UIImage imageNamed:@"mySubscribe"] forState:UIControlStateNormal];
//    [subscribeBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
//    subscribeBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview: subscribeBtn];

    [self.view addSubview:buttomView];
}

#pragma mark - private mothed

- (void) subscribeBtnClick:(UIButton*)btn
{
    CXSubscribeViewController * subscribeController=[[CXSubscribeViewController alloc] init];
    subscribeController.fromMySubscribe = ^()
    {
        self.curPage = BASE_PAGE;
        [self loadMySubscribeFromServer:self.curPage];
    };
    [ self.navigationController pushViewController:subscribeController animated:YES];
}


#pragma mark -  network data


- (void) loadMySubscribeFromServer:(NSInteger)page
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

    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTMYSUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {

        if(!err)
        {
            XLog(@"get subscribe list success");
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];

            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get banner list fail");
        }
    }];
}
//删除
- (void) delSubscribeFromServer:(NSInteger)index
{
    CXSubscribeModel *model = _sourceDatas[index];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"subscribeId" andLongValue:model.subscribeId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_DELSUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"delSubscribeFromServer success");
            
            [self.sourceDatas removeObjectAtIndex:index];
            [self.tableView configData:self.sourceDatas];
        }
        else
        {
            XLog(@"delSubscribeFromServer fail");
            [self ShowProgressHUB:(NSString *)err];
        }
    }];
}



#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXSubscribeModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
//    CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//    detailController.hidesBottomBarWhenPushed = YES;
//    detailController.productId = model.productId;
//    [ self.navigationController pushViewController:detailController animated:YES];
    
    CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
    productDetailWebViewController.hidesBottomBarWhenPushed = YES;
    productDetailWebViewController.productId = model.productId;
    productDetailWebViewController.titleName=@"产品详情";
    productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
    [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
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
        [self delSubscribeFromServer:self.delIndex];
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
            [self loadMySubscribeFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadMySubscribeFromServer:self.curPage];
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
