//
//  CXMainProductViewController.m
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMainProductViewController.h"
#import "CXProductDetailViewController.h"
#import "CXSearchProductViewController.h"
#import "CXProjectBtnView.h"

@interface CXMainProductViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMainProductViewController
{
    BOOL _loadProductsFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(instancetype)init
{
    self = [super init];
    if (self) {
         self.showType=0;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(reloadProductsWithCategory:)
                       name:NOTIFICATION_HOMEPAGE_PRODUCT
                     object:nil];
        [center addObserver:self
                   selector:@selector(reloadProductsTwoWithCategory:)
                       name:NOTIFICATION_HOMEPAGE_PRODUCTTWO
                     object:nil];
       
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += 1 + kViewBeginOriginY+kButtonHeight;
    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kButtomBarHeight+kButtonHeight : kButtomBarHeight+kButtonHeight ;
    
    _tableView = [[CXProductTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
    //上拉加载更多
    self.UploadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _UploadMoreView.delegate = self;
    _UploadMoreView.state = LoadMoreStateIsLoading;
    _UploadMoreView.noData = NSLocalizedString(@"该分类下没有产品!", nil);
    self.tableView.tableView.tableFooterView = _UploadMoreView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = kControlBgColor;
    self.title = StringProductAll;
    _loadProductsFromServerBool=YES;
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    _leftBtnData=[[NSMutableArray alloc]init];
    _rightBtnData=[[NSMutableArray alloc]init];
    [self initLeftBarButton];
    [self initRightBarButton];
    
    [self setmeueView];
    [self loadLeftBtnData];
    
    
    if (self.showType==0) {
        [self loadRightBtnData:1 andloadRightId:0];
        [self loadProductsFromServer:self.curPage];
    }
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI mark

- (void) initLeftBarButton
{
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(0, 0, 20, 20);
    [logoImage setImage:IMAGE(@"nav_logo")];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:logoImage];
    [self.navigationItem setLeftBarButtonItems:@[leftBar]];
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

#pragma mark -  network data
-(void) loadLeftBtnData
{
    if (kAppDelegate.productCategoryList&&kAppDelegate.productCategoryList.count>0) {
        if (_leftBtnData && _leftBtnData.count > 0)
        {
            [self.leftBtnData removeAllObjects];
        }
    for (_leftCategoryModel in kAppDelegate.productCategoryList) {
        [_leftBtnData addObject:_leftCategoryModel.name];
    }
    [self.MeueView getLeftData:_leftBtnData];
    self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:kAppDelegate.productCategoryClick - 1];
         self.MeueView.leftBtn.classroomButton.title.text=self.leftCategoryModel.name;
    }
}
-(void) loadRightBtnData:(NSInteger)Index andloadRightId:(NSInteger)rightNum;
{
    
    NSString *strUrl;
    if (Index==2) {
        strUrl=GET_PRODUCT_LISTTRUSTCATEGORY;
    }
    else if (Index==3)
    {
        strUrl=GET_PRODUCT_LISTFUNDCATEGORY;
    }
    else if (Index==4)
    {
        strUrl=GET_PRODUCT_LISTSHIBOSAICATEGORY;
    }
    else
    {
        strUrl=GET_PRODUCT_LISTTRUSTCATEGORY;
    }
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
            if (rightNum!=0) {
                [self didSelectRightAtIndex:rightNum];
            
                self.MeueView.rightBtn.classroomButton.title.text=self.rightCategoryModel.name;
            }
            
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }
    }];
}
- (void) loadProductsFromServer:(NSInteger)page
{
    [self loadCategoryProductsFromServer:page];
}
- (void) loadCategoryProductsFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"category" andLongValue:_leftCategoryModel.categoryId];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    [parametersUtil appendParameterWithName:@"investId" andLongValue:_rightCategoryModel.Id];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadCategoryProductsFromServer success");
            
//            if (_leftCategoryModel.categoryId == 1)
//            {
//                NSMutableArray *baseArray = (NSMutableArray * )mainPlate.anyModels;
//                 NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
//                
//                for (CXProductModel *model in baseArray)
//                {
//                        [tmpArray addObject:model];
//                }
//                
//                [_sourceDatas addObjectsFromArray:tmpArray];
//            }
//            else
            {
                [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            }
            [_DownLoadMoreView endRefreshing];
            [_UploadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            _loadProductsFromServerBool=YES;
        }
        else
        {
            [_DownLoadMoreView endRefreshing];
            [self.tableView.tableView reloadData];
            _UploadMoreView.state = LoadMoreStateFail;
            XLog(@"loadCategoryProductsFromServer fail");
            _loadProductsFromServerBool=YES;
        }
    }];
}

- (void) loadChoiceProductsFromServer:(NSInteger)page
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
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTCHOICE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
            [self.tableView configData:_sourceDatas];
            
            [_UploadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            
        }
        else
        {
            _UploadMoreView.state = LoadMoreStateFail;
            XLog(@"get banner list fail");
        }
    }];
}

#pragma mark - notification
- (void)reloadProductsWithCategory:(NSNotification *)notification
{
    self.showType=1;
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    if (kAppDelegate.productCategoryList&&kAppDelegate.productCategoryList.count>0) {
        NSInteger category = [name integerValue];
        [self didSelectLeftAtIndex:category-1];
        self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:category-1];
        self.MeueView.leftBtn.classroomButton.title.text=self.leftCategoryModel.name;
    }


}
- (void)reloadProductsTwoWithCategory:(NSNotification *)notification
{
    self.showType=1;
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    if (kAppDelegate.productCategoryList&&kAppDelegate.productCategoryList.count>0) {
        NSDictionary *dic=notification.object;
        
        NSInteger leftCategory = [dic[@"leftId"] integerValue];
        NSInteger RightCategory = [dic[@"rightId"] integerValue];
//        [self didSelectLeftAtIndex:leftCategory-1];
        //[self didSelectRightAtIndex:RightCategory-1];
        [self loadRightBtnData:leftCategory-1 andloadRightId:RightCategory-1];
        self.MeueView.rightBtn.classroomButton.title.text=StringClassify;
        if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 0)
        {
            self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:leftCategory-1];
            self.rightCategoryModel=nil;
        }

        self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:leftCategory-1];
        self.MeueView.leftBtn.classroomButton.title.text=self.leftCategoryModel.name;
    }
    
    
}

#pragma mark - CXProductTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }

    if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
//        NSIndexPath *indexPath = (NSIndexPath*)data;
//        CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
//        
//        CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//        detailController.hidesBottomBarWhenPushed = YES;
//        detailController.productId = model.productId;
//        [ self.navigationController pushViewController:detailController animated:YES];
        
        NSIndexPath *indexPath = (NSIndexPath*)data;
        CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = model.productId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
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
        self.curPage = BASE_PAGE;
        if ((_leftBtnData&&_leftBtnData.count==0)||(_rightBtnData&&_rightBtnData.count==0)) {
             [self setmeueView];
            [self loadLeftBtnData];
            [self loadRightBtnData:1 andloadRightId:0];
        }
        if (_loadProductsFromServerBool==YES) {
            [self loadProductsFromServer:self.curPage];
            _loadProductsFromServerBool=NO;
        }

    }
}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_UploadMoreView.state != LoadMoreStateComplete) {
        _UploadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count)
        {
            self.curPage++;
            [self loadProductsFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadProductsFromServer:self.curPage];
        }
    }

}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}


#pragma mark - private methods

- (void)search:(UIButton *)button
{
    CXSearchProductViewController *searchViewControl = [[CXSearchProductViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewControl animated:YES];
}

//#pragma mark category
//
//- (void) initTitleView
//{
//    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 0)
//    {
//        _curCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:kAppDelegate.productCategoryClick - 1];
//        
//        if (self.navigationItem)
//        {
//            CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
//            
//            
//            CXProjectBtnView *menu = [[CXProjectBtnView alloc] initWithFrame:frame title: self.curCategoryModel.name];
//            menu.items = kAppDelegate.productCategoryList;
//            menu.delegate = self;
//            self.navigationItem.titleView = menu;
//            //        XNavigationMenuView *menu = [[XNavigationMenuView alloc] initWithFrame:frame title: self.curCategoryModel.name];
//            //        [menu displayMenuInView:self.view];
//            //        menu.items = kAppDelegate.productCategoryList;
//            //        menu.delegate = self;
//            //        self.navigationItem.titleView = menu;
//        }
//    }
//}

- (void)changeCategory
{
    
    self.curPage = BASE_PAGE;
    [self loadProductsFromServer:self.curPage];
    [self.tableView.tableView reloadData];
}

//- (void)didNavMenuSelectItemAtIndex:(NSUInteger)index
//{
//    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 0)
//    {
//        self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:index];
//        [self changeCategory];
//    }
//}
#pragma mark - CXClassroomBtnViewDelegate
-(void)didSelectLeftAtIndex:(NSInteger)index
{
    [self loadRightBtnData:index andloadRightId:0];
    self.MeueView.rightBtn.classroomButton.title.text=StringClassify;
    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 0)
    {
        self.leftCategoryModel = [kAppDelegate.productCategoryList objectAtIndex:index];
        self.rightCategoryModel=nil;
        [self changeCategory];
    }
    
}
-(void)didSelectRightAtIndex:(NSInteger)index
{
    if (_rightCategoryArray &&_rightCategoryArray.count>0) {
        self.rightCategoryModel=[_rightCategoryArray objectAtIndex:index];
        if (index==0) {
            self.rightCategoryModel.Id=0;
        }
        [self changeCategory];
    }
}
@end