//
//  CXAppDelegate.m
//  Xfun
//
//  Created by yi.chen on 14-9-23.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXAppDelegate.h"
#import "Constants.h"
#import "CXMeViewController.h"
#import "CXTeamViewController.h"
#import "CXLoginViewController.h"
#import "CXHomePageViewController.h"
#import "CXInformationViewController.h"
#import "CXMainProductViewController.h"
#import "iflyMSC/iflySetting.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "IFlyFlowerCollector.h"
#import "CXClassroomViewController.h"
#import "UDCustomNavigation.h"
#import "CXActivityViewController.h"
#import "CXOnlyResetPasswordViewController.h"
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
// shareSDK
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"






// ----

@interface CXAppDelegate ()

@property (nonatomic, strong) UIImageView *winImageView;
@end



@implementation CXAppDelegate

+ (CXAppDelegate *) sharedInstance
{
    return (CXAppDelegate *) [UIApplication sharedApplication].delegate;
}

@synthesize viewDelegate = _viewDelegate;

- (id)init
{
    if(self = [super init])
    {
        _viewDelegate = [[AGViewDelegate alloc] init];
    }
    return self;
}

#pragma mark - ifly
//- (void)initFlySetting
//{
//    //设置log等级，此处log为默认在app沙盒目录下的msc.log文件
//    [IFlySetting setLogFile:LVL_ALL];
//    
//    //输出在console的log开关
//    [IFlySetting showLogcat:YES];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [paths objectAtIndex:0];
//    //设置msc.log的保存路径
//    [IFlySetting setLogFilePath:cachePath];
//    
//    //创建语音配置,appid必须要传入，仅执行一次则可
//    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID_VALUE,TIMEOUT_VALUE];
//    
//    //所有服务启动前，需要确保执行createUtility
//    [IFlySpeechUtility createUtility:initString];
//}
//
//- (void) IFlyFlowerSetting
//{
//    //讯飞数据统计分析的设置，详细内容请参考：
//    //http://open.voicecloud.cn/index.php/services/analysis/mobileapp
//    [IFlyFlowerCollector SetDebugMode:YES];
//    [IFlyFlowerCollector SetCaptureUncaughtException:YES];
//    [IFlyFlowerCollector SetAppid:APPID_VALUE];
//    [IFlyFlowerCollector SetAutoLocation:YES];
//
//}

#pragma mark - app circle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 初始化语音输入
//    [self initFlySetting];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    UIViewController *ViewController=[[UIViewController alloc]init];
    self.window.rootViewController=ViewController;
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    NSString *defaultImageName = @"Default-640_1136.png";
    if (screenFrame.size.width == 320)
    {
        if (screenFrame.size.height == 480)
        {
            defaultImageName = @"Default-640_960.png";
        }
    }
    else if (screenFrame.size.width == 375)
    {
        defaultImageName = @"Default-750_1334.png";
    }
    else if (screenFrame.size.width == 621)
    {
        defaultImageName = @"Default-1242_2208.png";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = IMAGE(defaultImageName);
    [ViewController.view addSubview:imageView];
    [self getStartImage];
    [self performSelector:@selector(mainTheard) withObject:nil afterDelay:1.0f];
    //推送
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    [APService setupWithOption:launchOptions];
    self.notificationNews = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    self.applicationState=2;
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
    NSString *userName = @"";
    NSString *password = @"";
    if (self.userPlistFileName.length > 0)
    {
        XFileValue *xfile = [[XFileValue alloc] initWithFileName:self.userPlistFileName];
        userName = [xfile valueForKey:kParameterUserName];
        password = [xfile valueForKey:kParameterPassword];
    }
    
    // 如果有网络，登录
    if (self.networkState > 0)
    {
        if ([userName length] > 0 && [password length] > 0)
        {
            [self checkUserInfoFolder:userName];
            
            //直接进行登录
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            [loginViewController loginWithUserName:userName andPassword:password andIsEntryForeground:true andAutoLogin:YES];
        }
        else
        {
            //[self EnterLoginView];
           // [self EnterMainView];
        }
    }
    
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    self.applicationState=1;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //取消角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //修改红点
     [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_OFFLINE_NEW_PROMPT object:nil];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)mainTheard
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    NSString *defaultImageName = @"Default-568h@2x.png";
    if (screenFrame.size.width == 320)
    {
        if (screenFrame.size.height == 480)
        {
            defaultImageName = @"Default.png";
        }
    }
    else if (screenFrame.size.width == 375)
    {
        defaultImageName = @"LaunchImage-800-667h@2x-1.png";
    }
    else if (screenFrame.size.width == 621)
    {
        defaultImageName = @"LaunchImage-800-Portrait-736h@3x-1.png";
    }
    
    // 启动时，要进行登录，会导致有一段时间白屏，所以在启动时，window上加上启动图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = IMAGE(defaultImageName);
    //    imageView.image = IMAGE(@"LaunchImage-800-Portrait-736h@3x.png");
    
    
    
    if (![_startImageUrl isEqualToString:@""]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:_startImageUrl]];
    }
    [self.window addSubview:imageView];
    _winImageView = imageView;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    
    [self setNavigationBar];
    
    
    // 判断和创建系统和缓存文件路径
    [self checkUserFolder];
    [self checkImageCacheDirectory];
    

    // 判断有无网络，如果没有网络，启动联网监听
    UIViewController *controller=[[UIViewController alloc]init];
    self.window.rootViewController=controller;
    
    [self checkNetworkEnable];
    
    //参数为ShareSDK官网中添加应用后得到的AppKey
    [ShareSDK registerApp:@"8ca2aaacb559"];
    [self initializeShareSDK];
    
//    //百度地图定位
//    BMKMapManager *mapManager=[[BMKMapManager alloc]init];
//    [mapManager start:@"474EUeisHrv1FNAU7qVzrnOC" generalDelegate:nil];
    
    
    self.productCategoryClick = 1;
    self.productCategoryList = [[NSMutableArray alloc] init];
    self.informationCategoryList = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"firstStart"]) {
        
        XLog(@"第一次启动");
        NSArray *coverImageNames = @[@"guide_Text1", @"guide_Text2", @"guide_Text3"];
        NSArray *backgroundImageNames = @[@"guide_Image1", @"guide_Image2", @"guide_Image3"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        self.window.rootViewController=self.introductionView;
        
        
        __weak CXAppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [defaults setBool:YES forKey:@"firstStart"];
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            //[weakSelf performSelector:@selector(login) withObject:nil afterDelay:0];
            [weakSelf performSelector:@selector(login)];
        };
        
    }
    else {
        XLog(@"不是第一次启动");
        /*
         由于检测网络有一定的延迟，所以如果启动app立即去检测调用[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus 有可能得到的是status == AFNetworkReachabilityStatusUnknown;但是此时明明是有网的，建议在收到监听网络状态回调以后再取[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus。
         */
        
        
        
        [self performSelector:@selector(login) withObject:nil afterDelay:2.0f];
        
    }
}
#pragma mark - main tabbar ui

// 5 我
- (void) initMeTabBarItem
{
    UIViewController *viewController;
    viewController = [[CXMeViewController alloc] init];

    viewController.title = NSLocalizedString(@"我的", nil);
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我的", nil) image:IMAGE(@"me_normal") tag:4];
    tabBarItem.selectedImage = [IMAGE(@"me_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    viewController.tabBarItem = tabBarItem;
    
    // 生成对应的导航控制器
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UDCustomNavigation *customNavigation=[[UDCustomNavigation alloc]initWithRootViewController:viewController];
    // 将导航控件器添加到控制器数组中
    [_viewControllers addObject:customNavigation];
}
// 4 发现
- (void) initFoundTabBarItem
{
    UIViewController *viewController = [[CXFoundViewController alloc] init];
    viewController.title = NSLocalizedString(@"发现", nil);
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"发现", nil) image:IMAGE(@"team_normal") tag:3];
    tabBarItem.selectedImage = [IMAGE(@"team_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    viewController.tabBarItem = tabBarItem;
    
    // 生成对应的导航控制器
    UDCustomNavigation *navigationController = [[UDCustomNavigation alloc] initWithRootViewController:viewController];
    
    // 将导航控件器添加到控制器数组中
    [_viewControllers addObject:navigationController];
}

//// 4 资讯
//- (void) initTeamTabBarItem
//{
//    UIViewController *viewController = [[CXInformationViewController alloc] init];
//    viewController.title = NSLocalizedString(@"资讯", nil);
//    
//    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"资讯", nil) image:IMAGE(@"team_normal") tag:3];
//    tabBarItem.selectedImage = [IMAGE(@"team_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
//    
//    viewController.tabBarItem = tabBarItem;
//    
//    // 生成对应的导航控制器
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//    
//    // 将导航控件器添加到控制器数组中
//    [_viewControllers addObject:navigationController];
//}

// 3 精选产品
- (void) initCooperateTabBarItem
{
//    UIViewController *viewController = [[CXCooperateViewController alloc] init];
//    viewController.title = NSLocalizedString(@"协作", nil);
    UIViewController *viewController = [[CXMainProductViewController alloc] init];
    viewController.title = NSLocalizedString(@"产品中心", nil);

    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"产品中心", nil) image:IMAGE(@"cooperate_normal") tag:2];
    tabBarItem.selectedImage = [IMAGE(@"cooperate_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];

    viewController.tabBarItem = tabBarItem;
    
    // 生成对应的导航控制器
    UDCustomNavigation *navigationController = [[UDCustomNavigation alloc] initWithRootViewController:viewController];
    
    // 将导航控件器添加到控制器数组中
    [_viewControllers addObject:navigationController];
}
//// 2 理财学堂
//- (void) initClassroomTabBarItem
//{
//    UIViewController *viewController = [[CXClassroomViewController alloc] init];
//    viewController.title = NSLocalizedString(@"理财学堂", nil);
//    
//    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"理财学堂", nil) image:IMAGE(@"classroom_normal") tag:3];
//    tabBarItem.selectedImage = [IMAGE(@"classroom_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
//    
//    viewController.tabBarItem = tabBarItem;
//    
//    // 生成对应的导航控制器
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//    
//    // 将导航控件器添加到控制器数组中
//    [_viewControllers addObject:navigationController];
//}

// 1 首页
- (void) initTaskTabBarItem
{
//    UIViewController *viewController = [[CXMainTaskViewController alloc] init];
//    viewController.title = NSLocalizedString(@"任务", nil);
    UIViewController *viewController = [[CXHomePageViewController alloc] init];
    viewController.title = NSLocalizedString(@"首页", nil);
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainStyleColor};
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页", nil) image:IMAGE(@"task_normal") tag:1];
    tabBarItem.selectedImage = [IMAGE(@"task_selected") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    viewController.tabBarItem = tabBarItem;
    
    // 生成对应的导航控制器
    UDCustomNavigation *navigationController = [[UDCustomNavigation alloc] initWithRootViewController:viewController];
    // 将导航控件器添加到控制器数组中
    [_viewControllers addObject:navigationController];
}

// 初始化视图控制器
- (void)initViewControllers
{
    if (_viewControllers && [_viewControllers count] > 0)
    {
        [_viewControllers removeAllObjects];
    }
    else
    {
        _viewControllers = [NSMutableArray array];
    }
    

    
    [self initTaskTabBarItem];
    [self initCooperateTabBarItem];
//    [self initTeamTabBarItem];
    [self initFoundTabBarItem];
    [self initMeTabBarItem];
    
    
    
    // 初始化tab页控制器
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = [NSArray arrayWithArray:_viewControllers];
    _tabBarController.delegate = self;
    _currentTabIndex = 0;
    _tabBarController.selectedIndex = _currentTabIndex;
    

    //打开app调用通知跳转
    if ( self.notificationNews !=nil) {
        self.applicationState=0;
         [self notificationClick:self.notificationNews];
    }


}

- (void)notificationCoopaterBeovered:(NSNotification *)notification
{
    NSString *str=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        str = notification.object;
    }
    
    if ([str isEqualToString:@"0"])
    {
        str = nil;
    }
    

}

- (void) setNavigationBar
{
    
//    UIImage *image = [kNavigationBarColor translateIntoImage];
//    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:1 topCapHeight:5];
    
    if (kIsIOS7OrLater)
    {
//        [[UINavigationBar appearance] setBackgroundImage:stretchedImage forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setBarTintColor:kNavigationBarColor]; // 导航栏的颜色
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; // 图片的颜色
    }else{
//        [[UINavigationBar appearance] setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:kNavigationBarColor];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (kIsIOS7OrLater && !kIsIOS7Dot2Before)
    {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    // 设置返回按键的图片
    //[[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    //[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           nil, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue1" size:34.0], NSFontAttributeName, nil]];
}

- (void) login
{
    self.hasLogined = NO;
    NSString *userName = @"";
    NSString *password = @"";
    if (self.userPlistFileName.length > 0)
    {
        XFileValue *xfile = [[XFileValue alloc] initWithFileName:self.userPlistFileName];
        userName = [xfile valueForKey:kParameterUserName];
        password = [xfile valueForKey:kParameterPassword];
    }
    
    // 如果有网络，登录
    if (self.networkState > 0)
    {
        if ([userName length] > 0 && [password length] > 0)
        {
            self.hasLogined = YES;
            
            [self checkUserInfoFolder:userName];
            
            //直接进行登录
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            [loginViewController loginWithUserName:userName andPassword:password andAutoLogin:YES];
        }
        else
        {
            [self EnterMainView];
            
        }
    }
    // 无网络，登录过的用户可以直接进去
    else
    {
        if ([userName length] > 0 && [password length] > 0)
        {
            [self checkUserInfoFolder:userName];
            
            //直接进行登录
            [self EnterMainView];
        }
        else
        {
            [self EnterMainView];
        }
    }
}

//app进入时的登录方法
- (void) EnterMainView
{
    if (self.hasLogined==NO) {
        self.currentUserDBFileName=nil;
        self.currentUserInfoFileName=nil;
        self.currentUserFolder=nil;

    }
    
    [[CXDBHelper sharedDBHelper] createDB:self.currentUserDBFileName];

    // 在这里重新读一次，是因为在没有网络的情况下，不走login，直接进主界面
    NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:self.currentUserInfoFileName];
    CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
    self.currentUserModel = model;
    
    // 初始化视图控制器
    [self initViewControllers];
    self.window.rootViewController = self.tabBarController;
    
    // 应用启动进入主界面后，把背影图去掉，不然用到window时，都会有个背影图
    _winImageView.hidden = YES;
    
    
    // 读数据库，看有没新好好友，在团队中显示红点
    //    NSMutableArray *addFriendList = [[[CXDBHelper sharedDBHelper] getAddFriendDao] queryApplyFriends];
    //
    //    if (addFriendList.count > 0)
    //    {
    //        NSString *str = [NSString stringWithFormat:@"%lu", (unsigned long)addFriendList.count];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADD_FRIEND object:str];
    //    }
}
//app登录时调用重置密码
- (void) EnterResePassword
{
    if (self.hasLogined==NO) {
        self.currentUserDBFileName=nil;
        self.currentUserInfoFileName=nil;
        self.currentUserFolder=nil;
        
    }
    [[CXDBHelper sharedDBHelper] createDB:self.currentUserDBFileName];
    NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:self.currentUserInfoFileName];
    CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
    self.currentUserModel = model;
    
    CXOnlyResetPasswordViewController *onlyResrtPasswordView=[[CXOnlyResetPasswordViewController alloc]init];
    UINavigationController *navViewController=[[UINavigationController alloc]initWithRootViewController:onlyResrtPasswordView];
    self.window.rootViewController = navViewController;
    _winImageView.hidden = YES;
    
}

//app里面进行登录的方法
- (void) RefreshLoginView
{
    [[CXDBHelper sharedDBHelper] createDB:self.currentUserDBFileName];
    
    // 在这里重新读一次，是因为在没有网络的情况下，不走login，直接进主界面
    NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:self.currentUserInfoFileName];
    CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
    self.currentUserModel = model;
    
    // 初始化视图控制器
    [self initViewControllers];
    self.window.rootViewController = self.tabBarController;
    
    // 应用启动进入主界面后，把背影图去掉，不然用到window时，都会有个背影图
    _winImageView.hidden = YES;
    
    
    
    
}

- (void) EnterLoginView
{
    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = navigationController;
}


- (void) LogoutEnterMainView
{
   
    // 初始化视图控制器
    [self initViewControllers];
    self.window.rootViewController = self.tabBarController;
    
    // 应用启动进入主界面后，把背影图去掉，不然用到window时，都会有个背影图
    _winImageView.hidden = YES;
    
    [self.tabBarController setSelectedIndex:4];
}

#pragma mark - notification methods
//推送连接成功
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    NSLog(@"%@",[APService registrationID]);
    [APService registerDeviceToken:deviceToken];
    
}
//推送连接失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif



- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
    [self notificationClick:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

//获取用户数据传给极光推送
-(void)getUserData:(BOOL)hasLogined
{
    if (hasLogined) {
        [APService setTags:[NSSet setWithObject:@"userId"] alias:[NSString stringWithFormat:@"%ld",self.currentUserModel.userId] callbackSelector:nil object:nil];
    }
    else
    {
         [APService setTags:[NSSet setWithObject:@"userId"] alias:@"" callbackSelector:nil object:nil];
    }
}

- (void)notificationAddFriends:(NSNotification *)notification
{
    NSString *str=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        str = notification.object;
    }
    
    UIViewController *teamViewController = [self.tabBarController.viewControllers objectAtIndex:2];
    [teamViewController.tabBarItem setBadgeValue:str];
}
//推送跳转
-(void)notificationClick:(NSDictionary *)userInfo
{


   
    NSDictionary *arrCamp = [userInfo objectForKey:@"aps"];
    CXNotificationModel *notificationModel=[[CXNotificationModel alloc]initWithDictionary:userInfo];
    notificationModel.content=[arrCamp objectForKey:@"alert"];
    //保存到数据库(除了资讯)
    if (notificationModel.type==2||notificationModel.type==3||notificationModel.type==4||notificationModel.type==5) {
    if (self.hasLogined) {
        [CXReceiveMessages creatFile:self.currentUserModel.userName];
        [CXReceiveMessages createInformationTable:userInfo andFileName:self.currentUserModel.userName];
    }
    else
    {
        [CXReceiveMessages creatFile:@"publicFile"];
        [CXReceiveMessages createInformationTable:userInfo andFileName:@"publicFile"];
    }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_OFFLINE_NEW_PROMPT object:nil];
   //跳转
    switch (self.applicationState) {
        case 0:
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_ONFLINE_NEW object:notificationModel userInfo:nil];
            self.applicationState=1;

        }
            break;
        case 1:
            //前台
        {
            
        }
            break;
        case 2:
            //后台进入前台
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_ONFLINE_NEW object:notificationModel userInfo:nil];
        }
            
            break;
        default:
            break;
            
    }

}
//推送测试
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
//- (void)notificationAddFriendAction
//{
//    NSString *str = nil;
//    // 读数据库，看有没新好好友，在团队中显示红点
//    NSMutableArray *addFriendList = [[[CXDBHelper sharedDBHelper] getAddFriendDao] queryApplyFriends];
//    
//    if (addFriendList.count > 0)
//    {
//        str = [NSString stringWithFormat:@"%lu", (unsigned long)addFriendList.count];
//    }
//    
//    UIViewController *teamViewController = [self.tabBarController.viewControllers objectAtIndex:2];
//    [teamViewController.tabBarItem setBadgeValue:str];
//}


#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"clicked item's tag is %lu",(unsigned long)tabBarController.selectedIndex);
    
}

#pragma mark - private methods

// 加入本地缓存
-(void )checkImageCacheDirectory
{
//    NSHomeDirectory()
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    NSString *imageFolder = [cachePath stringByAppendingPathComponent:kDirectoryOfImage];
    self.imageFolder = imageFolder;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:imageFolder])
    {
        [fileManager createDirectoryAtPath:imageFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


- (void)checkUserFolder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *userFolder = [paths[0] stringByAppendingPathComponent:kDirectoryOfUser];
    self.userFolder = userFolder;

    // 若不存在userFolder，则建立该文件夹
    if (![fileManager fileExistsAtPath:userFolder])
    {
        [fileManager createDirectoryAtPath:userFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 获得登录的用户信息文件
    NSArray *files = [fileManager contentsOfDirectoryAtPath:self.userFolder error:nil];
    for (NSString *fileName in files) {
        if ([fileName isEqualToString:@"user.plist"])
        {
            NSString *userFolder = [self.userFolder stringByAppendingPathComponent:fileName];
            self.userPlistFileName = userFolder;
            break;
        }
    }
}

- (void) checkUserInfoFolder:(NSString*)userName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *userInfoFolder = [self.userFolder stringByAppendingPathComponent:userName];
    self.currentUserFolder = userInfoFolder;
    
    // 若不存在，则建立该文件夹
    if (![fileManager fileExistsAtPath:userInfoFolder])
    {
        [fileManager createDirectoryAtPath:userInfoFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *userInfoFileName = [NSString stringWithFormat:@"%@.plist", userName];
    self.currentUserInfoFileName = [self.currentUserFolder stringByAppendingPathComponent:userInfoFileName];
    NSString *userDBFileName = [NSString stringWithFormat:@"%@.db", userName];
    self.currentUserDBFileName = [self.currentUserFolder stringByAppendingPathComponent:userDBFileName];
    
}

- (void) checkNetworkEnable
{
    self.reachablity = [AFNetworkReachabilityManager sharedManager];
    [self.reachablity startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                self.networkState = 0;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                self.networkState = 1;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                self.networkState = 2;
                break;
            }
            default:
                break;
        }
        
    }];
}

//- (void)reachabilityStatusChanged:(NSNotification *)n
//{
//    XLog(@"reachabilityStatusChanged");
//    self.networkState = [self.reachablity currentReachabilityStatus];
//    
//    if (self.networkState)
//    {
//        XLog(@"监听到网络，加入处理");
//    }
//}

//更换启动图
-(void)getStartImage
{
    _startImageUrl=@"";
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BANNER_LISTSTARTUPTPIC result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            //imageArr = (NSMutableArray * )mainPlate.anyModels
            
           
            XLog(@"getStartImage success");
            NSMutableArray *imaArr;
            imaArr=(NSMutableArray *)mainPlate.anyModels;
            if(imaArr!=nil&&imaArr.count!=0)
            {
                CXBannerModel *model = imaArr[0];
                _startImageUrl=model.imageUrl;
            }


            
        }
        else
        {
             _startImageUrl=@"";
            XLog(@"getStartImage fail");
           
        }
    }];
    
}


#pragma mark - shareSDK
- (void)initializeShareSDK
{
//    App Key：4094270929
//    App Secret：8fb59802ba6e21f46698fb878dd5a658
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectSinaWeiboWithAppKey:@"4094270929"
//                               appSecret:@"8fb59802ba6e21f46698fb878dd5a658"
//                             redirectUri:@"http://www.sharesdk.cn"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入WeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
//    [ShareSDK connectTencentWeiboWithAppKey:@"1104692565"
//                                  appSecret:@"Dg1ntZxk0c5sN7sh"
//                                redirectUri:@"http://www.sharesdk.cn"
//                                   wbApiCls:[WeiboSDK class]];
    
    
    //连接短信分享
    [ShareSDK connectSMS];
    
    //    APP ID:101058672
    //    APP KEY:f7e5c7afb42a0e7154da36b2c23ca5d4
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"1104692565"
                           appSecret:@"Dg1ntZxk0c5sN7sh"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    //    [ShareSDK connectWeChatWithAppId:@"wx1fe183737547a062" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wx603cc65cad3f491c"   //微信APPID
                           appSecret:@"57b6deeb85b08062dfaeb60327faaa50"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
//    APP ID:1104690311
//    APP KEY:DOW33YlJXRClbvzx
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"1104692565"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
}

- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

@end
