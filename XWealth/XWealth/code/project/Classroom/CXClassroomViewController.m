//
//  CXClassroomViewController.m
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomViewController.h"
#import "CXClassroomFunctionsButtonBar.h"
#import "CXBannerViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXTrustViewController.h"
#import "CXFundViewController.h"
#import "CXShibosaiViewController.h"
#import "CXMainProductViewController.h"
#import "CXProductReleaseViewController.h"
#import "CXLoginViewController.h"
#import "CXReleaseViewController.h"
#import "CXXintuobaoViewController.h"
#import "CXSearchClassroomViewController.h"
#import "CXClassroomListViewController.h"
#import "CXExpertViewController.h"
#import "CXExpertViewLIstController.h"

@interface CXClassroomViewController ()
@property (nonatomic, strong) CXClassroomFunctionsButtonBar *selectBtnsView;
@end

@implementation CXClassroomViewController
{
    BOOL _loadInformationRecommendFromServerBool;
}
#pragma mark - view circle

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
    tableVFrame.origin.y += kViewBeginOriginY;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight   : 0;
    _collectionView=[[CXClassroomCollectionView alloc]initWithFrame:tableVFrame];
    _collectionView.delegate=self;
    //_collectionView.isHaveSection=true;
    [self.view addSubview:_collectionView];

    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.collectionView.collectionView];
    _DownLoadMoreView.delegate=self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loadInformationRecommendFromServerBool=YES;
    self.view.backgroundColor = kControlBgColor;
    self.title = StringClassroom;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    _bannerList = [[NSMutableArray alloc] init];
    
    [self initRightBarButton];
    
    if (kAppDelegate.networkState > 0)
    {
        [self classroomFunctionsButtonBarFromServer];
        [self loadBannerFromServer];
        [self loadClassroomFromServer];
    }
    else
    {
        [self ShowProgressHUB:PromptNoNetWork];
    }
    
    [self initTableViewHeader];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationInformationView:)
                   name:NOTIFICATION_COURSE_VIEW
                 object:nil];

}


- (void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark - UI mark



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

- (void) initTableViewHeader
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = [UIColor whiteColor];
    
    CXBannerViewController *scrollImageView;
    CGFloat selectBtnY = 0;
    
    if (self.bannerList && self.bannerList.count > 0 &&self.buttonBarDatas&&self.buttonBarDatas.count>0)
    {
        scrollImageView = [[CXBannerViewController alloc] initWithBanners:self.bannerList];
        scrollImageView.navigationController = self.navigationController;
        [headView addSubview:scrollImageView.view];
        
        
        
        _selectBtnsView = [[CXClassroomFunctionsButtonBar alloc] initWithFrame:CGRectMake(0, kBannerHeight, kScreenWidth,  kFClassroomFunctionsBtnHeight*2+kDefaultMargin*2)];
        [_selectBtnsView getData:_buttonBarDatas];
        [headView addSubview:_selectBtnsView];
        
        selectBtnY = kBannerHeight+kFClassroomFunctionsBtnHeight*2+kDefaultMargin*2;
    }
    

    
    
    int customViewHeight=selectBtnY;
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, customViewHeight, kScreenWidth, kFunctionBarHeight)];
    customView.userInteractionEnabled=YES;
    customView.backgroundColor = [UIColor whiteColor];
    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
    flagView.userInteractionEnabled=YES;
    flagView.backgroundColor = [UIColor whiteColor];
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 18, 3, kIconSmallHeight-2)];
    leftView.backgroundColor = [UIColor redColor];
    [flagView addSubview:leftView];
    
    //加框
    CGFloat x = kDefaultMargin;
    CGFloat y = 5;
    CGFloat width = kScreenWidth;
    CGFloat height = kFunctionBarHeight - 1;
    CGRect rect = CGRectMake(x, y, width, height);
    flagView.frame = rect;
    [customView addSubview:flagView];
    
    


    if (_sourceDatas!=nil&&[_sourceDatas count]>0) {
        if (_sourceDatas[0]==nil||[_sourceDatas[0] count]==0) {
            rect.origin.x=kDefaultMargin;
            rect.size.width=kLabelWidth;
            UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
            titleLable.text = @"推荐课程";
            titleLable.font = kMiddleTextFontBold;
            titleLable.textColor = [UIColor grayColor];
            titleLable.textAlignment=NSTextAlignmentLeft;
            titleLable.numberOfLines = 1;
            [flagView addSubview:titleLable];

    
        }
        else
        {
            rect.origin.x=kDefaultMargin;
            rect.size.width=kLabelWidth;
            UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
            titleLable.text = @"精选专栏";
            titleLable.font = kMiddleTextFontBold;
            titleLable.textColor = [UIColor grayColor];
            titleLable.textAlignment=NSTextAlignmentLeft;
            titleLable.numberOfLines = 1;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreClick)];
            [titleLable addGestureRecognizer:tap];
            titleLable.userInteractionEnabled=YES;
            [flagView addSubview:titleLable];

            rect.size.width=kLabelWidth;
            rect.origin.x=kScreenWidth-kLabelWidth-kDefaultMargin*2;
            UILabel *moreLable=[[UILabel alloc]initWithFrame:rect];
            moreLable.text=@"更多>";
            moreLable.textColor=kAssistTextColor;
            moreLable.textAlignment=NSTextAlignmentRight;
            moreLable.font=kSmallTextFont;
            UITapGestureRecognizer *moreTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreClick)];
            [moreLable addGestureRecognizer:moreTap];
            moreLable.userInteractionEnabled=YES;
            [flagView addSubview:moreLable];
        }
    }
   


    
    UIView* downView = [[UIView alloc] initWithFrame:CGRectMake(0, kFunctionBarHeight, kScreenWidth, 0.5)];
    downView.backgroundColor = kGrayTextColor;
    [flagView addSubview:downView];
    
    
    [customView addSubview:flagView];
    [headView addSubview:customView];
    
    headView.frame = CGRectMake(0, 0, kScreenWidth, customViewHeight+kFunctionBarHeight+2);

    self.collectionView.collectionHeaderView=headView;
    if (self.bannerList && self.bannerList.count > 0 &&self.buttonBarDatas&&self.buttonBarDatas.count>0)
    {
        [self.collectionView.collectionView reloadData];
    }
    __unsafe_unretained CXClassroomViewController *weak_self = self;
    _selectBtnsView.firstBtnBlk = ^{
        [weak_self oneFunButtonClick];
    };
    _selectBtnsView.secondBtnBlk = ^{
        [weak_self twoFunButtonClick];
    };
    _selectBtnsView.thirdBtnBlk = ^{
        [weak_self threeFunButtonClick];
    };
    _selectBtnsView.fourBtnBlk = ^{
        [weak_self fourFunButtonClick];
    };
}

#pragma mark - notification
- (void) notificationInformationView:(NSNotification *)notification
{
    if (self.sourceDatas && self.sourceDatas.count > 0)
    {

        CXLawModel *userInfo = notification.userInfo[@"lawModel"];
        
        for (CXLawModel *model in _sourceDatas[1])
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
//4个按钮
- (void) classroomFunctionsButtonBarFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_LISTMODULES result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _buttonBarDatas = (NSMutableArray * )mainPlate.anyModels;
             [self initTableViewHeader];
             [_DownLoadMoreView endRefreshing];
        }
        else
        {
            XLog(@"get banner list fail");
            [self initTableViewHeader];
             [_DownLoadMoreView endRefreshing];
        }
    }];
}
//轮播图
- (void) loadBannerFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BANNER_LISTCOURSE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _bannerList = (NSMutableArray * )mainPlate.anyModels;
            [self initTableViewHeader];
            [_DownLoadMoreView endRefreshing];
           
        }
        else
        {
            XLog(@"get banner list fail");
            [self initTableViewHeader];
            [_DownLoadMoreView endRefreshing];
        }
    }];
}

- (void) loadClassroomFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_LISTRECOMMENT result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
            [_DownLoadMoreView endRefreshing];
            [self initTableViewHeader];
            [self.collectionView configData:_sourceDatas];
            [self.collectionView.collectionView reloadData];
            _loadInformationRecommendFromServerBool=YES;
            
        }
        else
        {
            XLog(@"get banner list fail");
            [self.collectionView.collectionView reloadData];
            [_DownLoadMoreView endRefreshing];
            [self.collectionView configData:_sourceDatas];
            _loadInformationRecommendFromServerBool=YES;
        }
    }];
}



#pragma mark - private methods

// 政策按钮
- (void)oneFunButtonClick
{
    CXClassroomListViewController* trustController=[[CXClassroomListViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    CXCategoryModel *categoryModel=_buttonBarDatas[0];
    trustController.leftIndex=categoryModel.categoryId;
    [self.navigationController pushViewController:trustController animated:YES];
}


// 法律按钮
- (void)twoFunButtonClick
{
    CXClassroomListViewController* trustController=[[CXClassroomListViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    CXCategoryModel *categoryModel=_buttonBarDatas[1];
    trustController.leftIndex=categoryModel.categoryId;
    [self.navigationController pushViewController:trustController animated:YES];
}

// 行业按钮
- (void)threeFunButtonClick
{
    CXClassroomListViewController* trustController=[[CXClassroomListViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    CXCategoryModel *categoryModel=_buttonBarDatas[2];
    trustController.leftIndex=categoryModel.categoryId;
    [self.navigationController pushViewController:trustController animated:YES];
}

// 趣味按钮
- (void)fourFunButtonClick
{
    CXClassroomListViewController* trustController=[[CXClassroomListViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    CXCategoryModel *categoryModel=_buttonBarDatas[3];
    trustController.leftIndex=categoryModel.categoryId;
    [self.navigationController pushViewController:trustController animated:YES];
}
//更多
- (void)moreClick
{
    CXExpertViewController* trustController=[[CXExpertViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:trustController animated:YES];
}
#pragma mark - CXCollectionViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    if ([_sourceDatas[indexPath.section] count]>0&&_sourceDatas[indexPath.section]!=nil) {
   
        if (indexPath.section==0) {
            CXExpertModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXExpertViewLIstController* expertViewController=[[CXExpertViewLIstController alloc] init];
            expertViewController.specailistId = model.Id;
            expertViewController.hidesBottomBarWhenPushed = YES;
            
            [ self.navigationController pushViewController:expertViewController animated:YES];
        }
        else if (indexPath.section==1)
        {
            CXCourseModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
            detailController.courseId = model.classId;
            detailController.hidesBottomBarWhenPushed = YES;
            
            [ self.navigationController pushViewController:detailController animated:YES];
        }
    

    }
}
-(void)collectionViewDidScroll:(UIScrollView *)scrollView
{
    
}
//刷新
#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        if (_bannerList.count==0) {
            [_bannerList removeAllObjects];
            [self loadBannerFromServer];
            [self classroomFunctionsButtonBarFromServer];
             [self initTableViewHeader];
        }
        if (_loadInformationRecommendFromServerBool==YES) {
            [_sourceDatas removeAllObjects];
            [self loadClassroomFromServer];
            _loadInformationRecommendFromServerBool=NO;
        }

        
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
