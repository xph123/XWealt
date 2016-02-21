//
//  CXBuybackTrustCenterViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterViewController.h"
#import "CXProductBuyBackViewController.h"
#import "CXBuybackTrustCenterDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "CXPopWindowViewController.h"
@interface CXBuybackTrustCenterViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end

@implementation CXBuybackTrustCenterViewController
{
    BOOL _loadMyReleaseFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kMinimumThread+kViewBeginOriginY+kDefaultMargin;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight + kMinimumThread+kDefaultMargin: kMinimumThread+kDefaultMargin;
    
    _tableView = [[CXBuybackTrustCenterTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"二手信托即将开始!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=StringBuybackCenter;
    [self initRightBarButton];
    _loadMyReleaseFromServerBool=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    //    [self loadMyReleaseFromServer:self.curPage];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"firstStartBuyBack"]) {
        [defaults setBool:YES forKey:@"firstStartBuyBack"];
        CXPopWindowViewController *detailViewController = [[CXPopWindowViewController alloc]initWithImageName:@"buyBackTrust_introduces"];
        [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationSlideRightLeft];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
        if (_loadMyReleaseFromServerBool==YES) {
            self.curPage=BASE_PAGE;
            [self loadMyReleaseFromServer:self.curPage];
        }

}
#pragma mark - UI mark
- (void) initRightBarButton
{
    UIButton *sendTradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendTradeBtn.frame=CGRectMake(0, 0, 60, 30);
    sendTradeBtn.titleLabel.font=kMiddleTextFontBold;
    [sendTradeBtn setTitle:StringWindRelease forState:UIControlStateNormal];
    sendTradeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sendTradeBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItem:rightBar];
    
}
#pragma mark - private methods

- (void) sendSubscribe
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    CXProductBuyBackViewController *ProductBuyBackController=[[CXProductBuyBackViewController alloc]init];
    [self.navigationController pushViewController:ProductBuyBackController animated:YES];
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
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BUYBACK_LISTBUYBACK result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get release list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            [_DownLoadMoreView endRefreshing];
            _loadMyReleaseFromServerBool=YES;
            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get release list fail");
            [_DownLoadMoreView endRefreshing];
            [self.tableView configData:_sourceDatas];
            _loadMyReleaseFromServerBool=YES;
        }
    }];
}



#pragma mark - CXTrustTransferCenterTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    if (_sourceDatas!=nil&&_sourceDatas.count>0)
    {
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXBuyBackModel  *model = [_sourceDatas objectAtIndex:indexPath.row];
    CXBuybackTrustCenterDetailViewController *buybackTrustCenterDetailViewController=[[CXBuybackTrustCenterDetailViewController alloc]init];
    buybackTrustCenterDetailViewController.buyBackModel=model;
    [self.navigationController pushViewController:buybackTrustCenterDetailViewController animated:YES];
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
//刷新
#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        if (_loadMyReleaseFromServerBool==YES) {
            //[_sourceDatas removeAllObjects];
            self.curPage=BASE_PAGE;
            [self loadMyReleaseFromServer:self.curPage];
            _loadMyReleaseFromServerBool=NO;
        }
        
        
    }
}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}
@end