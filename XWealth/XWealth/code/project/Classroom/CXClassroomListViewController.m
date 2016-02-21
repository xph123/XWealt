//
//  CXClassroomListViewController.m
//  XWealth
//
//  Created by gsycf on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomListViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXSearchClassroomViewController.h"

@interface CXClassroomListViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end
@implementation CXClassroomListViewController

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
        _leftIndex=1;
        _rightIndex=0;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor=kGrayTextColor;
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY+kButtonHeight+0.5;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight +kButtonHeight-0.5  : kButtonHeight-2;
    
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
//    _collectionView.collectionfootView = _loadMoreView;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _sourceDatas = [[NSMutableArray alloc] init];
    _leftBtnData=[[NSMutableArray alloc]init];
    _rightBtnData=[[NSMutableArray alloc] init];
    
    
    self.navigationItem.title=@"课程";
    [self initRightBarButton];
    
    [self setmeueView];
    [self loadLeftBtnData];
    [self loadRightBtnData:_leftIndex];
    
    self.curPage = BASE_PAGE;

    [self loadInformationWithCategoryFromServer:_leftIndex andIndex:_rightIndex andPage:self.curPage];
    
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

-(void)setmeueView
{

    _MeueView=[[CXLeftRightMeueView alloc]initWithFrame:CGRectMake(0, kViewBeginOriginY, self.view.frame.size.width, kButtonHeight)];
    _MeueView.delegate=self;
    [self.view addSubview:_MeueView];
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
-(void) loadLeftBtnData
{
    if (_leftBtnData && _leftBtnData.count > 0)
    {
        [self.leftBtnData removeAllObjects];
    }
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_LISTMODULES result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            _leftCategoryArray=(NSMutableArray *)mainPlate.anyModels;
            
            if (_leftCategoryArray&& _leftCategoryArray.count > 0)
            {
                
                for (int i = 0; i < _leftCategoryArray.count; i++)
                {
                    CXCategoryModel *ListInvestCategory = [_leftCategoryArray objectAtIndex:i];
                    
                    [_leftBtnData addObject:ListInvestCategory.name];
                }
            }
             [self.MeueView getLeftData:_leftBtnData];
            [self.MeueView.leftBtn setButtonTitle:_leftBtnData[_leftIndex-1]];
            
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }

    }];

}
-(void) loadRightBtnData:(NSInteger)Index
{
    
    NSString *strUrl=GET_COURSE_LISTCATEGRORY;
    if (_rightBtnData && _rightBtnData.count > 0)
    {
        [self.rightBtnData removeAllObjects];
    }
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    NSString *strIndex=[NSString stringWithFormat:@"%ld",Index];
    [parametersUtil appendParameterWithName:@"module" andStringValue:strIndex];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:strUrl result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            _rightCategoryArray=(NSMutableArray *)mainPlate.anyModels;
            
            if (_rightCategoryArray&& _rightCategoryArray.count > 0)
            {
                
                for (int i = 0; i < _rightCategoryArray.count; i++)
                {
                    CXCategoryModel *ListInvestCategory = [_rightCategoryArray objectAtIndex:i];
                    
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
    [parametersUtil appendParameterWithName:@"module" andIntValue:(int)category];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    [parametersUtil appendParameterWithName:@"category" andLongValue:_rightCategoryModel.categoryId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_LIST result:^(CXMainPlate *mainPlate, NSError *err) {
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
        [self loadInformationWithCategoryFromServer:_leftIndex andIndex:_rightCategoryModel.categoryId andPage:self.curPage];
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
            [self loadInformationWithCategoryFromServer:_leftIndex andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadInformationWithCategoryFromServer:_leftIndex andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
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
    [self loadInformationWithCategoryFromServer:_leftIndex andIndex:_rightCategoryModel.categoryId andPage:self.curPage];
    [self.collectionView.collectionView reloadData];
}

#pragma mark - CXClassroomListCollectionViewDelegate
-(void)didSelectLeftAtIndex:(NSInteger)index
{
    if (self.leftBtnData && self.leftBtnData.count > 0)
    {
        self.leftCategoryModel = [_leftCategoryArray objectAtIndex:index];
        _leftIndex=self.leftCategoryModel.categoryId;
        _rightCategoryModel = [_rightCategoryArray objectAtIndex:0];
        [self changeCategory];
    }
    [self loadRightBtnData:index+1];
    
}
-(void)didSelectRightAtIndex:(NSInteger)index
{
    if (self.rightBtnData && self.rightBtnData.count > 0)
    {
        _rightCategoryModel = [_rightCategoryArray objectAtIndex:index];
        [self changeCategory];
    }
}
#pragma mark - buttonCick
- (void)search:(UIButton *)button
{
    CXSearchClassroomViewController *searchViewControl = [[CXSearchClassroomViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewControl animated:YES];
}


@end
