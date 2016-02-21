//
//  CXXintuobaoViewController.m
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXintuobaoViewController.h"
#import "CXXintuobaoDetailViewController.h"

@interface CXXintuobaoViewController ()

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) BOOL isShowMore;
@end

@implementation CXXintuobaoViewController
{
    BOOL _loadXintuoBaosFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
- (void)loadView
{
    [super loadView];
    
    self.isShowMore = NO;
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY;
    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight : 0 ;
    
    _tableView = [[CXXintuobaoView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
//    //上拉加载更多
//    self.UploadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
//    _UploadMoreView.delegate = self;
//    _UploadMoreView.state = LoadMoreStateIsLoading;
//    _UploadMoreView.noData = NSLocalizedString(@"该分类下没有产品!", nil);
//    self.tableView.tableView.tableFooterView = _UploadMoreView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"信托宝";
    _loadXintuoBaosFromServerBool=YES;
    self.curPage = BASE_PAGE;
    _hotSaleDatas = [[NSMutableArray alloc] init];
    _earlyDatas = [[NSMutableArray alloc] init];
    [self initRightBarButton];
    [self loadXintuoBaosFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initRightBarButton
{
    UIButton *sendTradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendTradeBtn.frame = CGRectMake(0, 0, 60, 30);
    sendTradeBtn.titleLabel.font = kMiddleTextFontBold;
    [sendTradeBtn setTitle:@"常见问题" forState:UIControlStateNormal];
    [sendTradeBtn addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}
- (void)settingClick:(UIButton *)button
{
    // 常见问题
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.hidesBottomBarWhenPushed = YES;
    NSString *aboutUrl=@"/util/commonQuestion.action";
    self.problemUrl=[kBaseURLString stringByAppendingString:aboutUrl];
    webControl.url = self.problemUrl;
    webControl.titleName=@"常见问题";
    [self.navigationController pushViewController:webControl animated:YES];
    
}
#pragma mark -  network data

- (void) loadXintuoBaosFromServer
{
    if (self.hotSaleDatas && self.hotSaleDatas.count > 0)
    {
        [self.hotSaleDatas removeAllObjects];
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"flag" andIntValue:1];
    [parametersUtil appendParameterWithName:@"page" andLongValue:1];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_XINTUOBAO_PRODUCTLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadXintuoBaosFromServer success");
            [_DownLoadMoreView endRefreshing];
            [_hotSaleDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configData:_hotSaleDatas];
            _loadXintuoBaosFromServerBool=YES;
        }
        else
        {
            XLog(@"loadXintuoBaosFromServer fail");
            [_DownLoadMoreView endRefreshing];
            _loadXintuoBaosFromServerBool=YES;
        }
    }];
}

- (void) loadEarlyDatasFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.earlyDatas && self.earlyDatas.count > 0)
        {
            [self.earlyDatas removeAllObjects];
        }
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"flag" andIntValue:3];
    [parametersUtil appendParameterWithName:@"page" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_XINTUOBAO_PRODUCTLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadXintuoBaosFromServer success");
            
            [_earlyDatas addObjectsFromArray:mainPlate.anyModels];
            //                [self.tableView configData:_sourceDatas];
            
            [_DownLoadMoreView endRefreshing];
            [_UploadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                         totalLoadCount:_earlyDatas.count
                                               pageSize:@"10"];
            _loadXintuoBaosFromServerBool=YES;
        }
        else
        {
            [_DownLoadMoreView endRefreshing];
            [self.tableView.tableView reloadData];
            _UploadMoreView.state = LoadMoreStateFail;
            XLog(@"loadXintuoBaosFromServer fail");
            _loadXintuoBaosFromServerBool=YES;
        }
    }];
}

#pragma mark - CXProductTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSString *midStr=[NSString stringWithFormat:@"%@",kAppDelegate.currentUserModel.mid];
        NSIndexPath *indexPath = (NSIndexPath*)data;
        CXXintuoBaoModel *model;
        if (indexPath.section == 0)
        {
            model = [_hotSaleDatas objectAtIndex:indexPath.row];
        }
        else
        {
            model = [_earlyDatas objectAtIndex:indexPath.row];
        }
        
        CXXintuobaoDetailViewController * detailController=[[CXXintuobaoDetailViewController alloc] init];
        detailController.hidesBottomBarWhenPushed = YES;
        detailController.xintuobaoModel = model;
        [ self.navigationController pushViewController:detailController animated:YES];

}


- (void) showEarlyDatas
{
    
    if (self.isShowMore == NO && self.UploadMoreView == nil)
    {
        self.isShowMore = YES;
        //上拉加载更多
        self.UploadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
        _UploadMoreView.delegate = self;
        _UploadMoreView.state = LoadMoreStateIsLoading;
        _UploadMoreView.noData = NSLocalizedString(@"该分类下没有产品!", nil);
        self.tableView.tableView.tableFooterView = _UploadMoreView;
        self.tableView.Arrow=YES;
        [self loadEarlyDatasFromServer:self.curPage];
    }
    else if (self.isShowMore == YES)
    {
        self.isShowMore = NO;
        self.tableView.Arrow=NO;
        self.tableView.tableView.tableFooterView = nil;
        [self.tableView configEarlyData:nil];
    }
    else  if (self.isShowMore == NO)
    {

        self.isShowMore = YES;
        self.tableView.Arrow=YES;
        self.tableView.tableView.tableFooterView = _UploadMoreView;
        [self.tableView configEarlyData:self.earlyDatas];
//        [self.tableView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_UploadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
//        self.curPage = BASE_PAGE;
       
        if (_loadXintuoBaosFromServerBool==YES) {
             [self loadXintuoBaosFromServer];
            _loadXintuoBaosFromServerBool=NO;
        }
    }
}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_UploadMoreView.state != LoadMoreStateComplete) {
        _UploadMoreView.state = LoadMoreStateIsLoading;
        
        if (_earlyDatas && _earlyDatas.count)
        {
            self.curPage++;
            [self loadEarlyDatasFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadEarlyDatasFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configEarlyData:_earlyDatas];
}



@end
