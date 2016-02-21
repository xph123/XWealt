//
//  CXExpertViewLIstController.m
//  XWealth
//
//  Created by gsycf on 15/12/11.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXExpertViewLIstController.h"
#import "CXClassroomDatailViewController.h"
#import "CXSearchClassroomViewController.h"
@interface CXExpertViewLIstController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXExpertViewLIstController

- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor=kGrayTextColor;
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY+0.5;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight -0.5  : -2;
    
    _collectionView=[[CXClassroomListCollectionView alloc]initWithFrame:tableVFrame];
    _collectionView.delegate=self;
    //_collectionView.isHaveSection=true;
    [self.view addSubview:_collectionView];
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.collectionView.collectionView];
    _DownLoadMoreView.delegate=self;
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"该分类下没有资讯!", nil);
    _collectionView.collectionfootView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _sourceDatas = [[NSMutableArray alloc] init];
    [self initRightBarButton];
    
    self.navigationItem.title=@"课程";

    
    self.curPage = BASE_PAGE;
    
    [self loadSpecailistFromServer:self.curPage];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationInformationView:)
                   name:NOTIFICATION_COURSE_VIEW
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
#pragma mark - notification
- (void) notificationInformationView:(NSNotification *)notification
{
    if (self.sourceDatas && self.sourceDatas.count > 0)
    {
        CXLawModel *userInfo = notification.userInfo[@"lawModel"];
        
        for (CXLawModel *model in _sourceDatas)
        {
            if (model.classId == userInfo.classId)
            {
                model.comments = userInfo.comments;
                model.goods = userInfo.goods;
                break;
            }
        }
        
        [self.collectionView configData:_sourceDatas];
    }
}




#pragma mark -  network data

- (void) loadSpecailistFromServer:(NSInteger)page
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
    [parametersUtil appendParameterWithName:@"specailistId" andLongValue:self.specailistId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_LISTCOURSE result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get banner list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.collectionView configData:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            [_DownLoadMoreView endRefreshing];
            [self.collectionView.collectionView reloadData];
        }
        else
        {
            [self.collectionView.collectionView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            [_DownLoadMoreView endRefreshing];
            XLog(@"get banner list fail");
            
        }
    }];
}


#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXLawModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
    CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
    detailController.courseId = model.classId;
    detailController.hidesBottomBarWhenPushed = YES;
    
    [ self.navigationController pushViewController:detailController animated:YES];
}


#pragma mark - UIScrollViewDelegate
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        self.curPage = BASE_PAGE;
        [self loadSpecailistFromServer:self.curPage];
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
            [self loadSpecailistFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadSpecailistFromServer:self.curPage];
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
    [self loadSpecailistFromServer:self.curPage];
    [self.collectionView.collectionView reloadData];
}

#pragma mark - buttonCick
- (void)search:(UIButton *)button
{
    CXSearchClassroomViewController *searchViewControl = [[CXSearchClassroomViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewControl animated:YES];
}

@end
