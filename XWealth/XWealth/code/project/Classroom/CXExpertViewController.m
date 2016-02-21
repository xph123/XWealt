//
//  CXExpertViewController.m
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXExpertViewController.h"
#import "CXInformationDetailViewController.h"
#import "CXSearchInformationViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXExpertViewLIstController.h"

@interface CXExpertViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXExpertViewController
{
    BOOL _loadInformationWithCategoryFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
}

- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY+0.5;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight   : 0;
    
    _tableView = [[CXExpertTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"暂无资料", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    _loadInformationWithCategoryFromServerBool=YES;
    _sourceDatas = [[NSMutableArray alloc] init];

    
    self.navigationItem.title=@"名家专栏";
    self.curPage = BASE_PAGE;
    [self loadExpertWithCategoryFromServer:self.curPage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -private methods


#pragma mark -  network data
- (void) loadExpertWithCategoryFromServer:(NSInteger)page
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
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SPECIALIST_LISTRECOMMENT result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get banner list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            [_DownLoadMoreView endRefreshing];
            _loadInformationWithCategoryFromServerBool=YES;
        }
        else
        {
            [self.tableView.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            [_DownLoadMoreView endRefreshing];
            XLog(@"get banner list fail");
            _loadInformationWithCategoryFromServerBool=YES;
        }
    }];
}


#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
        NSIndexPath *indexPath = (NSIndexPath*)data;
        CXExpertModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXExpertViewLIstController* expertViewController=[[CXExpertViewLIstController alloc] init];
        expertViewController.specailistId = model.Id;
        expertViewController.hidesBottomBarWhenPushed = YES;
        
        [ self.navigationController pushViewController:expertViewController animated:YES];
    }
    
}


#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        self.curPage = BASE_PAGE;
        if (_loadInformationWithCategoryFromServerBool==YES) {
            [self loadExpertWithCategoryFromServer:self.curPage];
            _loadInformationWithCategoryFromServerBool=NO;
        }
        
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
           [self loadExpertWithCategoryFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadExpertWithCategoryFromServer:self.curPage];
        }
    }
}
- (void)updateDelegateView
{
    
}



@end
