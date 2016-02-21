//
//  CXHomePageViewController.m
//  XWealth
//
//  Created by chx on 15-3-2.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXHomePageViewController.h"
#import "CXFunctionsButtonBar.h"
#import "CXBannerViewController.h"
#import "CXInformationDetailViewController.h"
#import "CXTrustViewController.h"
#import "CXFundViewController.h"
#import "CXShibosaiViewController.h"
#import "CXMainProductViewController.h"
#import "CXProductReleaseViewController.h"
#import "CXLoginViewController.h"
#import "CXReleaseViewController.h"
#import "CXXintuobaoViewController.h"
#import "CXPopActivityView.h"
#import "CXActivityViewController.h"
#import "CXTrustTransferCenterViewController.h"
#import "CXBuybackTrustCenterViewController.h"
#import "CXTrustTransferCenterDetailViewController.h"
#import "CXBuybackTrustCenterDetailViewController.h"
#import "CXInformationViewController.h"
#import "CXClassroomViewController.h"
#import "CXSecondhandMarketViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXXintuobaoDetailViewController.h"
#import "CXPopularActivityViewController.h"
#import "CXShareIndexView.h"

@interface CXHomePageViewController ()

@property (nonatomic, strong) CXFunctionsButtonBar *selectBtnsView;
@property (nonatomic, strong) CXPopActivityView *popView;
@property (nonatomic, strong) CXPopActivityModel *activityModel;

@end

@implementation CXHomePageViewController
{
    BOOL _loadInformationRecommendFromServerBool;
}
#pragma mark - view circle
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}
//- (void)setNeedsStatusBarAppearanceUpdate
//{
//    
//}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(notificationInformationView:)
                       name:NOTIFICATION_INFORMATION_VIEW
                     object:nil];
        [center addObserver:self
                   selector:@selector(appWillEnterForegroundNotification)
                       name:NOTIFICATION_ENTRY_FOREGROUND
                     object:nil];
        [center addObserver:self selector:@selector(offFileNotificationClick:) name:NOTIFION_ONFLINE_NEW object:nil];
         [center addObserver:self selector:@selector(nofictionFotClick) name:NOTIFICATION_ME_RECOMMENT_FOT object:nil];
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    


    
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight + kTabBarHeight  : kTabBarHeight;
//    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    _collectionView=[[CXHomePageCollectionView alloc]initWithFrame:tableVFrame];
    _collectionView.delegate=self;
    _collectionView.navigationController=self.navigationController;
    //_collectionView.isHaveSection=true;
    [self.view addSubview:_collectionView];
    
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.collectionView.collectionView];
    _DownLoadMoreView.delegate=self;
    
    
    
    //电话
    UIImageView *iphoneView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-kIconMiddleWidth-kMessageLeftMargin, kViewBeginOriginY+kScreenHeight-kIconMiddleWidth-kMessageLeftMargin-kTabBarHeight-kButtomBarHeight-kStatusBarHeight, 45, 45)];
    iphoneView.image=[UIImage imageNamed:@"home_iphone"];
    UITapGestureRecognizer *iphoneViewtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iphoneClick)];
    [iphoneView addGestureRecognizer:iphoneViewtap];
    iphoneView.userInteractionEnabled=YES;
    [self.view addSubview:iphoneView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringAppName;
    
//    //获取版本号
//        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
//        float softVerson =[[infoDict objectForKey:@"CFBundleShortVersionString"] floatValue];
//        NSLog(@"%f",softVerson);
//        [self systemUpdate:[NSString stringWithFormat:@"%f",softVerson]];
    
    _loadInformationRecommendFromServerBool=YES;
    _sourceDatas = [[NSMutableArray alloc] init];
    _bannerList = [[NSMutableArray alloc] init];
    _SSEIndexDaatas=[[NSMutableArray alloc]init];
    [self initLeftBarButton];
    [self initRightBarButton];
    
    if (kAppDelegate.networkState > 0)
    {
        [self loadBannerFromServer];
        [self loadInformationShareIndexFromServer];
        [self loadInformationRecommendFromServer];
        [self loadProduceCategoryFromServer];
        [self loadInformationCategoryFromServer];
        [self loadProductMoneyIntoListFromServer];
    
        // 弹出活动
        [self loadActivity];
    }
    else
    {
        [self ShowProgressHUB:PromptNoNetWork];
    }
    
    
    [self initCollectionHeader];
    [self initCollectionOneSection];
    [self initCollectionTwoSection];
    [self initCollectionThreeSection];
    [self initCollectionFourSection];
    [self initCollectionFireSection];

//    [self baiduMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) loadActivity
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:0 forKey:@"LoadActivityCount"];
    NSString *rootPath = NSHomeDirectory();
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    //判断是否参加过
    if (![defaults boolForKey:@"isLoadedActivity"]&& kAppDelegate.isPopActivity == NO) {
       
        
        [self getPopActivityFromServer];

    }
    
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

    CGRect frame = CGRectMake(0.0, 0.0, 80, self.navigationController.navigationBar.bounds.size.height);
    
    CXDropProjectBtn *menu = [[CXDropProjectBtn alloc] initWithFrame:frame title:StringWindRelease];
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:menu];
    menu.delegate=self;
    NSArray *arr=@[StringReleaseProduct,StringTrustTransfer,StringBuyback];
    NSArray *arrIcon=@[@"home_release",@"home_transfer",@"home_buyback"];
    menu.icons=arrIcon;
    menu.items=arr;
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void) initCollectionHeader
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = kControlBgColor;
    
    CXBannerViewController *scrollImageView;
    CGFloat selectBtnY = 0;
    
    if (self.bannerList && self.bannerList.count > 0)
    {
        scrollImageView = [[CXBannerViewController alloc] initWithBanners:self.bannerList];
        scrollImageView.navigationController = self.navigationController;
        [headView addSubview:scrollImageView.view];
        
        selectBtnY = kBannerHeight;
    }
    
    //tableView
    _selectBtnsView = [[CXFunctionsButtonBar alloc] initWithFrame:CGRectMake(0, selectBtnY, kScreenWidth, kFunctionsBtnBarHeight-kDefaultMargin)];
    [headView addSubview:_selectBtnsView];
    
    UIView *centerLine=[[UIView alloc]initWithFrame:CGRectMake(0, selectBtnY+kFunctionsBtnBarHeight-kDefaultMargin-0.5, kScreenWidth, 0.5)];
    centerLine.backgroundColor=kLineColor;
    [headView addSubview:centerLine];
    
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, selectBtnY+kFunctionsBtnBarHeight-kDefaultMargin, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    [headView addSubview:sectionView];
    
   
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_one"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-15, 1, 60, kLabelHeight)];
    titleLable.text = @"今日分享";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0xff8049);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
   
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    UIImageView *bannerIma=[[UIImageView alloc]initWithFrame:CGRectMake(0, sectionView.frame.origin.y+sectionView.frame.size.height, kScreenWidth, kScreenWidth/4)];
    bannerIma.image=[UIImage imageNamed:@"home_head_news"];
    UITapGestureRecognizer *TapGestureRecoginzer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(informationBannerClick)];
    [bannerIma addGestureRecognizer:TapGestureRecoginzer];
    bannerIma.userInteractionEnabled=YES;
    [headView addSubview:bannerIma];
    
    headView.frame = CGRectMake(0, 0, kScreenWidth, selectBtnY + kFunctionsBtnBarHeight+32+kScreenWidth/4-kDefaultMargin);
    
    self.collectionView.collectionHeaderView = headView;
    
    __unsafe_unretained CXHomePageViewController *weak_self = self;
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
//    _selectBtnsView.fiveBtnBlk = ^{
//        [weak_self fiveFunButtonClick];
//    };
//    _selectBtnsView.sixBtnBlk = ^{
//        [weak_self sixFunButtonClick];
//    };
//    _selectBtnsView.sevenBtnBlk = ^{
//        [weak_self sevenFunButtonClick];
//    };
//    _selectBtnsView.eightBtnBlk = ^{
//        [weak_self eightFunButtonClick];
//    };
}
- (void) initCollectionOneSection
{
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_two"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-15, 1, 60, kLabelHeight)];
    titleLable.text = @"火爆专区";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0xff5756);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    
    self.collectionView.collectionOneSectionView = sectionView;

}
- (void) initCollectionfootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];

    
    CGFloat selectBtnHight = 0;
    
    if (self.SSEIndexDaatas && self.SSEIndexDaatas.count > 0)
    {
        CXShareIndexView *shareIndexView=[[CXShareIndexView alloc]initSourceDatas:self.SSEIndexDaatas];
        CGFloat shareIndexViewHeight =kshareIndexHeight;
        footView =shareIndexView;
        selectBtnHight=shareIndexViewHeight;
    }
    footView.frame = CGRectMake(0, 0, kScreenWidth, selectBtnHight);
  
    
    self.collectionView.collectionfootView = footView;
    
}

- (void) initCollectionTwoSection
{
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_three"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-15, 1, 60, kLabelHeight)];
    titleLable.text = @"热卖专区";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0xeab102);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    
    self.collectionView.collectionTwoSectionView = sectionView;

}
- (void) initCollectionThreeSection
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = kControlBgColor;

    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    [headView addSubview:sectionView];
    
    
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_four"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-15, 1, 60, kLabelHeight)];
    titleLable.text = @"理财学堂";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0x56cc14);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    UIImageView *bannerIma=[[UIImageView alloc]initWithFrame:CGRectMake(0, sectionView.frame.origin.y+sectionView.frame.size.height, kScreenWidth, kScreenWidth/4)];
    bannerIma.image=[UIImage imageNamed:@"home_head_classroom"];
    UITapGestureRecognizer *TapGestureRecoginzer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(classroomBannerClick)];
    [bannerIma addGestureRecognizer:TapGestureRecoginzer];
    bannerIma.userInteractionEnabled=YES;
    [headView addSubview:bannerIma];
    
    headView.frame = CGRectMake(0, 0, kScreenWidth, 32+kScreenWidth/4);
    
    self.collectionView.collectionThreeSectionView = headView;
}
- (void) initCollectionFourSection
{
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_five"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-15, 1, 60, kLabelHeight)];
    titleLable.text = @"二手信托";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0xff8400);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    self.collectionView.collectionFourSectionView = sectionView;

}
- (void) initCollectionFireSection
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = kControlBgColor;
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    sectionView.backgroundColor=kControlBgColor;
    [headView addSubview:sectionView];
    
    
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    leftView.backgroundColor =kLineColor2;
    [sectionView addSubview:leftView];
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-32, 6, 20, 20)];
    leftIma.image=[UIImage imageNamed:@"home_six"];
    [sectionView addSubview:leftIma];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-7, 1, 60, kLabelHeight)];
    titleLable.text = @"信托宝";
    titleLable.font = kMiddleTextFontBold;
    titleLable.textColor = UIColorFromRGB(0xf4593d);
    titleLable.numberOfLines = 1;
    [sectionView addSubview:titleLable];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake( kScreenWidth/2+43+kMinSmallMargin, sectionView.frame.size.height/2, kScreenWidth/2-42-kDefaultMargin-kMinSmallMargin, 0.5)];
    rightView.backgroundColor = kLineColor2;
    [sectionView addSubview:rightView];
    
    UIImageView *bannerIma=[[UIImageView alloc]initWithFrame:CGRectMake(0, sectionView.frame.origin.y+sectionView.frame.size.height, kScreenWidth, kScreenWidth/3)];
    bannerIma.image=[UIImage imageNamed:@"home_head_xintuobao"];
    UITapGestureRecognizer *TapGestureRecoginzer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xintuobaoBannerClick)];
    [bannerIma addGestureRecognizer:TapGestureRecoginzer];
    bannerIma.userInteractionEnabled=YES;
    [headView addSubview:bannerIma];
    
    headView.frame = CGRectMake(0, 0, kScreenWidth, 32+kScreenWidth/3+kDefaultMargin);
    
    self.collectionView.collectionFiveSectionView = headView;
}
#pragma mark - notification
- (void) notificationInformationView:(NSNotification *)notification
{
    if (self.sourceDatas && self.sourceDatas.count > 0)
    {
        CXInformationModel *userInfo = notification.userInfo[@"informationModel"];
        
        for (CXInformationModel *model in _sourceDatas[0])
        {
            if (model.informationId == userInfo.informationId)
            {
                model.comments = userInfo.comments;
                model.goods = userInfo.goods;
                break;
            }
        }
        
        [self.collectionView configData:_sourceDatas];
    }
}

- (void) appWillEnterForegroundNotification{
    NSLog(@"trigger event when will enter foreground.");
    
    // 如果有网络，取同步数据
    if (kAppDelegate.networkState > 0)
    {
        [self loadBannerFromServer];
        [self loadInformationShareIndexFromServer];
        [self loadInformationRecommendFromServer];
        [self loadProduceCategoryFromServer];
        [self loadInformationCategoryFromServer];
        [self loadProductMoneyIntoListFromServer];
    }
}

#pragma mark -  network data

- (void) loadBannerFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BANNERS result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _bannerList = (NSMutableArray * )mainPlate.anyModels;
            [self initCollectionHeader];
            [_DownLoadMoreView endRefreshing];
 
        }
        else
        {
            XLog(@"get banner list fail");
            //[self.tableView.tableView reloadData];
             [_DownLoadMoreView endRefreshing];
        }
    }];
}
//首页所有显示数据
- (void) loadInformationRecommendFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_RECOMMENDS result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
             [_DownLoadMoreView endRefreshing];
            [self.collectionView configData:_sourceDatas];
            _loadInformationRecommendFromServerBool=YES;

            
        }
        else
        {
            XLog(@"get banner list fail");
            //[self.tableView.tableView reloadData];
            [_DownLoadMoreView endRefreshing];
            [self.collectionView configData:_sourceDatas];
            _loadInformationRecommendFromServerBool=YES;
        }
    }];
}
//首页上证指数，深证指数数据
- (void) loadInformationShareIndexFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_FINDSHARELIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get SSE Index data success");
            _SSEIndexDaatas=(NSMutableArray *)mainPlate.anyModels;
            [self initCollectionfootView];
            
        }
        else
        {
            XLog(@"get SSE Index data fail");

        }
    }];
}

- (void) loadInformationCategoryFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_LISTCATEGORY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get information category list success");
            
            kAppDelegate.informationCategoryList = (NSMutableArray * )mainPlate.anyModels;

        }
        else
        {
            XLog(@"get information category list fail");
        }
    }];
}

- (void) loadProduceCategoryFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTCATEGORY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get product category list success");
            
            kAppDelegate.productCategoryList = (NSMutableArray * )mainPlate.anyModels;

        }
        else
        {
            XLog(@"get product category list fail");
        }
    }];
}
- (void) loadProductMoneyIntoListFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTINVESTCATEGORY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            kAppDelegate.productMoneyIntoList=(NSMutableArray *)mainPlate.anyModels;
            kAppDelegate.productPayTypeList=(NSMutableArray *)mainPlate.additionalModels;
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }
    }];
}


- (void) getPopActivityFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"platform" andIntValue:1];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_POPACTIVITY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"getPopActivityFromServer success");
              CXPopActivityModel *activityModel = (CXPopActivityModel * )mainPlate.anyModels[0];
            

          
            if (activityModel != nil)
            {
                //activityModel.url = @"http://192.168.0.167:8080/recommentactive.jsp";
                self.activityModel = activityModel;
                
                //获取成功
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSInteger localActivityId=[defaults integerForKey:@"LocalActivityId"];
                //如果是不是同一个活动设置计数为0
                if (localActivityId!=activityModel.activityId )
                {
                    [defaults setInteger:0 forKey:@"LoadActivityCount"];
                    [defaults setInteger:activityModel.activityId forKey:@"LocalActivityId"];
                }
                NSInteger count = [defaults integerForKey:@"LoadActivityCount"];
                if (count < 3)
                {
                    [defaults setInteger:(count + 1) forKey:@"LoadActivityCount"];
                    // 有效
                    if (activityModel.state > 0)
                    {
                        // 参加过
                        if (activityModel.joined > 0)
                        {
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setBool:YES forKey:@"isLoadedActivity"];
                        }
                        else
                        {
                            // ios的活动
                            if (activityModel.platform == 1)
                            {
                                kAppDelegate.isPopActivity = YES;
                                CXPopActivityView *popView =[[CXPopActivityView alloc] initWithActivityModel:activityModel];
                                [popView show];
                                self.popView = popView;
                                
                                __unsafe_unretained CXHomePageViewController *weak_self = self;
                                popView.actionBlk = ^{
                                    [weak_self.popView dismiss];
                                    CXActivityViewController *activityViewController = [[CXActivityViewController alloc] init];
                                    activityViewController.titleName=StringPopularActivity;
                                    activityViewController.url = weak_self.activityModel.url;
                                    activityViewController.nameUrl = weak_self.activityModel.name;
                                    activityViewController.imageUrl =weak_self.activityModel.imageUrl;
                                    activityViewController.infoId = weak_self.activityModel.infoId;
                                    activityViewController.shareUrl = weak_self.activityModel.shareUrl;
                                    activityViewController.hidesBottomBarWhenPushed = YES;
                                    [self.navigationController pushViewController:activityViewController animated:YES];
                                };
                                
                            }
                        }
                        
                    }
                }

            }
        }
        else
        {
            XLog(@"getPopActivityFromServer fail");
        }
    }];
}


#pragma mark - private methods
-(void)iphoneClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
}


// 大额理财
- (void)oneFunButtonClick
{
//    kAppDelegate.productCategoryClick = PRODUCT_TRUST;
    [self.tabBarController setSelectedIndex:1];
    
//    NSString *strCategory = [NSString stringWithFormat:@"%d", PRODUCT_TRUST];
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:NOTIFICATION_HOMEPAGE_PRODUCT object:strCategory userInfo:nil];
    
    //    CXTrustViewController* trustController=[[CXTrustViewController alloc] init];
    //    //    beoveredController.hidesBottomBarWhenPushed = YES;
    //    [ self.navigationController pushViewController:trustController animated:YES];


}


// 跳蚤市场
- (void)twoFunButtonClick
{
    CXSecondhandMarketViewController* secondhandMarketViewController=[[CXSecondhandMarketViewController alloc] init];
    secondhandMarketViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:secondhandMarketViewController animated:YES];
}

// 资讯
- (void)threeFunButtonClick
{
    CXInformationViewController* InformationViewController=[[CXInformationViewController alloc] init];
    InformationViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:InformationViewController animated:YES];
}

// 理财学堂
- (void)fourFunButtonClick
{
    CXClassroomViewController* ClassroomViewController=[[CXClassroomViewController alloc] init];
    ClassroomViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:ClassroomViewController animated:YES];}
// 信托宝
//- (void)fiveFunButtonClick
//{
//    if (kAppDelegate.hasLogined == NO)
//    {
//        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//        loginViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginViewController animated:YES];
//        return;
//    }
//    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gaosouyi.com/xintuobao/index.html"]];
//    CXXintuobaoViewController* trustController=[[CXXintuobaoViewController alloc] init];
//    trustController.hidesBottomBarWhenPushed = YES;
//    [ self.navigationController pushViewController:trustController animated:YES];
//}
//// 信托转让
//- (void)sixFunButtonClick
//{
//
//    CXTrustTransferCenterViewController* TrustTransferCenterController=[[CXTrustTransferCenterViewController alloc] init];
//    TrustTransferCenterController.hidesBottomBarWhenPushed = YES;
//    [ self.navigationController pushViewController:TrustTransferCenterController animated:YES];
//}
//// 受让信托
//- (void)sevenFunButtonClick
//{
//
//    CXBuybackTrustCenterViewController* BuybackTrustCenterController=[[CXBuybackTrustCenterViewController alloc] init];
//    BuybackTrustCenterController.hidesBottomBarWhenPushed = YES;
//    [ self.navigationController pushViewController:BuybackTrustCenterController animated:YES];
//}
//// fot
//- (void)eightFunButtonClick
//{
//    kAppDelegate.productCategoryClick = PRODUCT_SHIBOSAI;
//    [self.tabBarController setSelectedIndex:2];
//    
//    NSString *strCategory = [NSString stringWithFormat:@"%d", PRODUCT_SHIBOSAI];
//    NSString *strCategoryRight = [NSString stringWithFormat:@"7"];
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:NOTIFICATION_HOMEPAGE_PRODUCTTWO object:@{@"leftId":strCategory,@"rightId":strCategoryRight} userInfo:nil];
//}
-(void)informationBannerClick
{
    CXInformationViewController* InformationViewController=[[CXInformationViewController alloc] init];
    InformationViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:InformationViewController animated:YES];
}
-(void)classroomBannerClick
{
    CXClassroomViewController* ClassroomViewController=[[CXClassroomViewController alloc] init];
    ClassroomViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:ClassroomViewController animated:YES];

}
-(void)xintuobaoBannerClick
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    CXXintuobaoViewController* trustController=[[CXXintuobaoViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:trustController animated:YES];
}
// fot
- (void)nofictionFotClick
{
    kAppDelegate.productCategoryClick = PRODUCT_SHIBOSAI;
    [self.tabBarController setSelectedIndex:1];
    
    NSString *strCategory = [NSString stringWithFormat:@"%d", PRODUCT_SHIBOSAI];
    NSString *strCategoryRight = [NSString stringWithFormat:@"7"];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NOTIFICATION_HOMEPAGE_PRODUCTTWO object:@{@"leftId":strCategory,@"rightId":strCategoryRight} userInfo:nil];
}

#pragma mark - CXDropProjectBtnDelegate
-(void)didNavMenSelectTableAtIndex:(NSInteger)index
{
    if (index==0) {
        if (kAppDelegate.hasLogined == NO)
        {
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            loginViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        CXProductReleaseViewController *productReleaseView=[[CXProductReleaseViewController alloc]init];
        productReleaseView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:productReleaseView  animated:YES];


    }
    if (index==1) {
        if (kAppDelegate.hasLogined == NO)
        {
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            loginViewController.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        CXProductTransferViewController *ProductBenefitView=[[CXProductTransferViewController alloc]init];
        ProductBenefitView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:ProductBenefitView  animated:YES];

        
    }
    if (index==2) {
        if (kAppDelegate.hasLogined == NO)
        {
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            loginViewController.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        CXProductBuyBackViewController *productBuyBackView=[[CXProductBuyBackViewController alloc]init];
        productBuyBackView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:productBuyBackView  animated:YES];

        
        
    }
}
//-(void)onFileNotificationClick:(NSNotification *)no
//{
//    [self.tabBarController setSelectedIndex:0];
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    CXNotificationModel *model=no.object;
//    CXActivityViewController *activityViewController = [[CXActivityViewController alloc] init];
//    activityViewController.titleName=StringPopularActivity;
//    activityViewController.url = model.url;
//    activityViewController.nameUrl = model.name;
//    activityViewController.imageUrl = model.image;
//    activityViewController.shareUrl = model.url;
//    activityViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:activityViewController animated:YES];
//}
-(void)offFileNotificationClick:(NSNotification *)no
{
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:NO];
     CXNotificationModel *model=no.object;
    
    //修改状态
    if (kAppDelegate.hasLogined) {
        [CXReceiveMessages updateFriendState:3 withMessageId:model.id andfileName:kAppDelegate.currentUserModel.userName];
    }
    else
    {
        
        [CXReceiveMessages updateFriendState:3 withMessageId:model.id andfileName:@"publicFile"];
    }
    

    
    if (model.type==10) {
        if (model.eventId!=0) {
        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
        detailController.informationId = model.eventId;
        detailController.hidesBottomBarWhenPushed = YES;
        
        [ self.navigationController pushViewController:detailController animated:YES];
        }
    }
    else if (model.type==3)
    {
        UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"版本升级提示" message:model.content delegate:self cancelButtonTitle:@"遗憾错过" otherButtonTitles:@"立即更新", nil];
        [aler show];
    }

    else if (model.type==4)
    {
        //热门活动
        CXPopularActivityViewController *popularActivityControl = [[CXPopularActivityViewController alloc] init];
        popularActivityControl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:popularActivityControl animated:YES];
    }

    else if (model.type==5)
    {
        if (model.eventId!=0) {
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = model.eventId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.eventId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
        }
    }

}

#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
    NSIndexPath *indexPath = (NSIndexPath*)data;
    switch (indexPath.section) {
        case 0:
        {
                CXInformationModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                
                CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
                detailController.informationId = model.informationId;
                detailController.hidesBottomBarWhenPushed = YES;
                
                [ self.navigationController pushViewController:detailController animated:YES];
  
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            if (kAppDelegate.hasLogined == NO)
            {
                CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
                loginViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginViewController animated:YES];
                return;
            }

            CXProductSimplyModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            
            CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
            productDetailWebViewController.hidesBottomBarWhenPushed = YES;
            productDetailWebViewController.productId = model.productId;
            productDetailWebViewController.titleName=@"产品详情";
            productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
            [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
            
        }
            break;
        case 3:
        {
            CXCourseModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
            detailController.courseId = model.classId;
            detailController.hidesBottomBarWhenPushed = YES;
            
            [ self.navigationController pushViewController:detailController animated:YES];
        }
            break;
        case 4:
        {
            CXBenefitModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXTrustTransferCenterDetailViewController *trustTransferCenterDetailController=[[CXTrustTransferCenterDetailViewController alloc]init];
            trustTransferCenterDetailController.hidesBottomBarWhenPushed = YES;
            trustTransferCenterDetailController.benefitId=model.releaseId;
            trustTransferCenterDetailController.productId=model.productId;
            [self.navigationController pushViewController:trustTransferCenterDetailController animated:YES];

            
        }
            break;
        case 5:
        {
            CXBuyBackModel  *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXBuybackTrustCenterDetailViewController *buybackTrustCenterDetailViewController=[[CXBuybackTrustCenterDetailViewController alloc]init];
            buybackTrustCenterDetailViewController.hidesBottomBarWhenPushed = YES;
            buybackTrustCenterDetailViewController.buyBackModel=model;
            [self.navigationController pushViewController:buybackTrustCenterDetailViewController animated:YES];
            
            
        }
            break;
        case 6:
        {
            
            CXXintuoBaoModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
            CXXintuobaoDetailViewController * detailController=[[CXXintuobaoDetailViewController alloc] init];
            detailController.hidesBottomBarWhenPushed = YES;
            detailController.xintuobaoModel = model;
            [ self.navigationController pushViewController:detailController animated:YES];
            
        }
            break;
            default:
                break;
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
            
            [self loadProduceCategoryFromServer];
            [self loadInformationCategoryFromServer];
            [self loadProductMoneyIntoListFromServer];
            
        }
        if (_loadInformationRecommendFromServerBool==YES) {
            [_sourceDatas removeAllObjects];
           [self loadInformationShareIndexFromServer];
            [self loadInformationRecommendFromServer];
            _loadInformationRecommendFromServerBool=NO;
        }

        
    }
}


////百度地图
//#pragma mark - baduMap
//-(void)baiduMap
//{
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
//}
////实现相关delegate 处理位置信息更新
////处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    //NSLog(@"heading is %@",userLocation.heading);
//}
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [_locService stopUserLocationService];
//}
////版本更新
//-(void)systemUpdate:(NSString *)versionNum
//{
//        XHttpParameters *parametersUtil = [XHttpParameters parameters];
//        //判断是否ios
//        [parametersUtil appendParameterWithName:@"platform" andStringValue:@"2"];
//        //版本号
//        [parametersUtil appendParameterWithName:@"versionCode" andStringValue:@"2"];
//        [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SYSTEM_UPDATE result:^(CXMainPlate *mainPlate, NSError *err) {
//    
//            if(!err)
//            {
//                XLog(@"systemUpdate success");
//                UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"版本升级提示" message:@"app更新提示" delegate:self cancelButtonTitle:@"遗憾错过" otherButtonTitles:@"立即更新", nil];
//                [aler show];
//            }
//            else
//            {
//                XLog(@"systemUpdate fail");
//            }
//        }];
//    
//}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/zhang-fu-bao/id1018214306?mt=8"]];
            break;
        default:
            break;
    }
}
@end
