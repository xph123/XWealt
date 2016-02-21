//
//  CXInformationViewController.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationViewController.h"
#import "CXInformationDetailViewController.h"
#import "CXSearchInformationViewController.h"

@interface CXInformationViewController ()

@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXInformationViewController
{
    BOOL _loadInformationWithCategoryFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)loadView
{
    [super loadView];

    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY+kButtonHeight+0.5;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight +kButtonHeight  : kButtonHeight;
    
    _tableView = [[CXInformationTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"该分类下没有资讯!", nil);
    //self.tableView.tableView.tableFooterView = _loadMoreView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    _loadInformationWithCategoryFromServerBool=YES;
    _sourceDatas = [[NSMutableArray alloc] init];
    _leftBtnData=[[NSMutableArray alloc]init];
    _rightBtnData=[[NSMutableArray alloc] init];
    [self initRightBarButton];
    
    self.navigationItem.title=@"资讯";
    //[self initTitleView];
    [self setmeueView];
    [self loadLeftBtnData];
    [self loadRightBtnData:0];
    self.curPage = BASE_PAGE;
        [self loadInformationWithCategoryFromServer:self.leftCategoryModel.categoryId andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationInformationView:)
                   name:NOTIFICATION_INFORMATION_VIEW
                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initRightBarButton
{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 30, 30);
    [searchBtn setImage:IMAGE(@"search_normal") forState:UIControlStateNormal];
    [searchBtn setImage:IMAGE(@"search_pressed") forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}
-(void)setmeueView
{
    _MeueView=[[CXLeftRightMeueView alloc]initWithFrame:CGRectMake(0, kViewBeginOriginY, self.view.frame.size.width, kButtonHeight)];
    _MeueView.delegate=self;
    [self.view addSubview:_MeueView];
}
#pragma mark - notification
- (void) notificationInformationView:(NSNotification *)notification
{
    if (self.sourceDatas && self.sourceDatas.count > 0)
    {
        CXInformationModel *userInfo = notification.userInfo[@"informationModel"];
        
        for (CXInformationModel *model in _sourceDatas)
        {
            if (model.informationId == userInfo.informationId)
            {
                model.comments = userInfo.comments;
                model.goods = userInfo.goods;
                break;
            }
        }
        
        [self.tableView configDataHaveHeaderView:_sourceDatas];
    }
}


#pragma mark -private methods

- (void)search:(UIButton *)button
{
    CXSearchInformationViewController *searchViewControl = [[CXSearchInformationViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewControl animated:YES];
}

#pragma mark -  network data
-(void) loadLeftBtnData
{
    if (kAppDelegate.informationCategoryList&&kAppDelegate.informationCategoryList.count>0) {
    if (_leftBtnData && _leftBtnData.count > 0)
    {
        [self.leftBtnData removeAllObjects];
    }
    for (_leftCategoryModel in kAppDelegate.informationCategoryList) {

        [_leftBtnData addObject:_leftCategoryModel.name];
    }
    [self.MeueView getLeftData:_leftBtnData];
    }
    
}
-(void) loadRightBtnData:(NSInteger)Index
{
    
    NSString *strUrl=GET_INFORMATION_LISTCONDITIONCATEGORY;
     if (_rightBtnData && _rightBtnData.count > 0)
    {
        [self.rightBtnData removeAllObjects];
    }
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:strUrl result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            _rightCategoryArray=(NSMutableArray *)mainPlate.anyModels;
            
            if (_rightCategoryArray&& _rightCategoryArray.count > 0)
            {
                
                for (int i = 0; i < _rightCategoryArray.count; i++)
                {
                    CXCourseModel *ListInvestCategory = [_rightCategoryArray objectAtIndex:i];
                    
                    [_rightBtnData addObject:ListInvestCategory.name];
                }
            }
            [self.MeueView getRightData:_rightBtnData];
             self.MeueView.rightBtn.classroomButton.title.text=_rightBtnData[0];
            
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }
    }];
}

- (void) loadInformationWithCategoryFromServer:(NSInteger)category  andIndex:(NSInteger)index andPage:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"category" andIntValue:(int)category];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
     [parametersUtil appendParameterWithName:@"condId" andLongValue:index];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATIONS result:^(CXMainPlate *mainPlate, NSError *err) {
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
        CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        
        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
        detailController.informationId = model.informationId;
        detailController.hidesBottomBarWhenPushed = YES;
        
        [ self.navigationController pushViewController:detailController animated:YES];
    }

}


#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        self.curPage = BASE_PAGE;
        if ((_leftBtnData&&_leftBtnData.count==0)||(_rightBtnData&&_rightBtnData.count==0)) {
            [self setmeueView];
            [self loadLeftBtnData];
            [self loadRightBtnData:0];
        }
        if (_loadInformationWithCategoryFromServerBool==YES) {
            [self loadInformationWithCategoryFromServer:self.leftCategoryModel.categoryId andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
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
            [self loadInformationWithCategoryFromServer:self.leftCategoryModel.categoryId andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadInformationWithCategoryFromServer:self.leftCategoryModel.categoryId andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
        }
    }
}
- (void)updateDelegateView
{
    
}





- (void)changeCategory
{
   
    self.curPage = BASE_PAGE;
    _loadMoreView.state =  LoadMoreStateNormal;
   [self loadInformationWithCategoryFromServer:self.leftCategoryModel.categoryId andIndex:_rightCategoryModel.categoryId andPage:self.curPage];
    [self.tableView.tableView reloadData];
}

#pragma mark - CXClassroomBtnViewDelegate
-(void)didSelectLeftAtIndex:(NSInteger)index
{
    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 0)
    {
        self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:index];
        _rightCategoryModel = [_rightCategoryArray objectAtIndex:0];
        [self changeCategory];
    }
    [self loadRightBtnData:index];
   
}
-(void)didSelectRightAtIndex:(NSInteger)index
{
    if (self.rightBtnData && self.rightBtnData.count > 0)
    {
        _rightCategoryModel = [_rightCategoryArray objectAtIndex:index];
        [self changeCategory];
    }
}


@end
