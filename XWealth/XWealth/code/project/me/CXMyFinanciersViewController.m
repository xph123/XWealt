//
//  CXMyFinanciersViewController.m
//  XWealth
//
//  Created by gsycf on 15/11/30.
//  Copyright © 2015年 rasc. All rights reserved.
//
#define DOWNBACKVIEW_HIGHT     (90.0f)

#import "CXMyFinanciersViewController.h"
#import "CXProductDetailWebViewController.h"
#import "UDCustomNavigation.h"

@interface CXMyFinanciersViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMyFinanciersViewController
- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    //tableVFrame.size.height -=  kViewEndSizeHeight ;
    
    _tableView = [[CXProductTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    _tableView.isHaveSection = YES;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"理财师还没有更新", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
    CGRect headFrame = CGRectMake(0, 0, self.view.frame.size.width, kScreenWidth/1.17+DOWNBACKVIEW_HIGHT+kDefaultMargin*2);
    _headView = [[CXMyFinanciersHeaderView alloc] initWithFrame:headFrame];
    _headView.userModel = kAppDelegate.currentUserModel;
    _tableView.tableView.tableHeaderView = _headView;
    __unsafe_unretained CXMyFinanciersViewController *weak_self = self;
    _headView.praiseBlk = ^{
        // 修改背影图片
        [weak_self praiseBtnClick];
    };



}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"我的理财师";
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    //[self loadMyAttentionFromServer:self.curPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:YES andAnimation:NO];
    [nav.navigationBar setTranslucent:YES];
    [self loadMyFinanciersFromServer:self.curPage];
}
-(void)viewWillDisappear:(BOOL)animated
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:NO andAnimation:NO];
    [nav.navigationBar setTranslucent:NO];
}
#pragma mark -  network data
- (void) loadMyFinanciersData
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_MYFINANCIAL result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadMyFinanciersData success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"loadMyFinanciersData fail");
        }
    }];
}

- (void) loadMyFinanciersFromServer:(NSInteger)page
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
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTATTENTION result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadMyAttentionFromServer success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"loadMyAttentionFromServer fail");
        }
    }];
}

#pragma mark - TableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
    CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
    productDetailWebViewController.hidesBottomBarWhenPushed = YES;
    productDetailWebViewController.productId = model.productId;
    productDetailWebViewController.titleName=@"产品详情";
    productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
    [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    if (yOffset<0) {
        CGRect frame = self.headView.headBgImageView.frame;
        frame.origin.y = yOffset;
        frame.size.height =  -yOffset+kScreenWidth/1.17;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.headView.headBgImageView.frame = frame;
    }

}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_loadMoreView.state != LoadMoreStateComplete) {
        _loadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count > 0)
        {
            self.curPage ++;
            [self loadMyFinanciersFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadMyFinanciersFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
}
#pragma  mark - private methods
- (void) praiseBtnClick
{
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    

}



@end
