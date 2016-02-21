//
//  CXAppDelegate.h
//  Xfun
//
//  Created by yi.chen on 14-9-23.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import "Reachability.h"
//#import <AliyunOpenServiceSDK/Reachability.h>
#import "AGViewDelegate.h"
#import "ZWIntroductionViewController.h"
#import "CXFoundViewController.h"

@interface CXAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    NSTimer *_timer;
}

// 用户本地路径
// /Users/apple/Library/Developer/CoreSimulator/Devices/C63A8998-F071-4A6D-9A96-F346C5D6CEFB/data/Applications/1903BA29-EE72-4F6C-97C8-86832E92462F/Documents/User
// 根目录/Documents/User
@property (strong, nonatomic) NSString *userFolder;    // 存放用户信息的文件夹
// 根目录/Documents/User/user.plist   记录用户名、密码
@property (strong, nonatomic) NSString *userPlistFileName;  // 存放登录的用户plist
// 根目录/Documents/User/xxxxxxxx
@property (strong, nonatomic) NSString *currentUserFolder;    //存放用户上传语音，图片的文件夹
// 根目录/Documents/User/xxxxxxxx/xxxxxxxx.plist     (xxxxxxxx = userName)
@property (strong, nonatomic) NSString *currentUserInfoFileName;  //当前登录用户信息
// 根目录/Documents/User/xxxxxxxx/xxxxxxxx.db
@property (strong, nonatomic) NSString *currentUserDBFileName;  //当前登录用户DB

@property (strong, nonatomic) CXUserModel *currentUserModel; // 当前登录的用户信息

// 图片缓存的位置
// 根目录/Documents/Image
@property (strong, nonatomic) NSString *imageFolder;

// 网络是否可用, 0 不可用，1 为wifi 2 为3g
@property (assign, nonatomic) NSInteger networkState;
//@property (strong, nonatomic) Reachability *reachablity;
@property (strong, nonatomic) AFNetworkReachabilityManager *reachablity;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navLogin;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (assign, nonatomic) int currentTabIndex; //跟踪当前被选中的tab页
@property (strong, nonatomic) NSMutableArray *viewControllers; // 五个主菜单导航控制器
@property (nonatomic, strong) ZWIntroductionViewController *introductionView; //引导页

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@property (nonatomic,readonly) AGViewDelegate *viewDelegate;

@property (nonatomic, strong) NSString *sessionId;

@property (nonatomic, assign) NSInteger productCategoryClick;// 首页中点了哪个分类，临时做法

@property (nonatomic, assign) BOOL hasLogined;               //判断是否登录，no为没登录
@property (nonatomic, strong) NSMutableArray *productCategoryList;
@property (nonatomic, strong) NSMutableArray *informationCategoryList;
@property (nonatomic, strong) NSMutableArray *productMoneyIntoList;   //资金投向
@property (nonatomic, strong) NSMutableArray *productPayTypeList;   //付息方式

@property (nonatomic, strong) NSString *startImageUrl;  //启动图片url
@property (nonatomic, assign) BOOL isPopActivity;

@property (nonatomic, assign)int applicationState;//app状态：0为未启动，1前台，2后台
@property (nonatomic, strong)NSDictionary *notificationNews;//通知消息
+ (CXAppDelegate *) sharedInstance;
// 初始化视图控制器
- (void)initViewControllers;
// 进入主界面
- (void) EnterMainView;
// 进入登录界面，退出时用到
- (void) EnterLoginView;
// 退出时，进入主界面，显示第四页
- (void) LogoutEnterMainView;
//app登录时调用重置密码
- (void) EnterResePassword;
//获取启动图
-(void)getStartImage;
////版本更新
//-(void)systemUpdate:(NSString *)versionNum;
//获取用户数据传给极光推送
-(void)getUserData:(BOOL)hasLogined;
@end
