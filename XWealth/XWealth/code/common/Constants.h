//
//  Constants.h
//
//
//  Created by yi.chen on 14-9-23.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

/* 项目（代码）说明：
 1. UIImageView+AFNetworking 没有做本地缓存，所以项目中加入了本地图片缓存。
 2. 本地图片缓存的代码在file/cache中
 3. UIImageView+AFNetworking，会使用cache中的代码。（这点要注意）

*/

#ifndef Constants_h
#define Constants_h

//#define DEBUG_ENABLE
//#ifdef DEBUG_ENABLE
//    #define XLog(fmt, ...)      NSLog(fmt, ##__VA_ARGS__)
//#else
//    #define XLog(fmt, ...)      ((void)0)
//#endif
#define XLog(fmt, ...)      NSLog(fmt, ##__VA_ARGS__)
#define DEBUG_LOCALSERVER // 本地服务器上测试

//#define PUSH_ENABLE


#pragma mark -
#pragma mark 设备信息
#define DeviceIPad              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsIOS7OrLater          ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
#define kIsIOS7Dot2Before       ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.2)
#define kIsIOS8OrLater          ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
#define kIsIOS9OrLater          ([[[UIDevice currentDevice]systemVersion]floatValue] <= 9.0)

#pragma mark -
#pragma mark 系统UI Frame
//屏幕宽度、高度
#define kScreenBound  [[UIScreen mainScreen] bounds]
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kApplicationFrame  [[UIScreen mainScreen] applicationFrame]
#define kApplicationWidth  APPLICATIONFRMAE.size.width
#define kApplicationHeight APPLICATIONFRMAE.size.height


#define kStatusBarHeight        (20.0f)
#define kNavigationBarHeight    (44.0f)
#define kTabBarHeight           (49.0f)
#define kButtomBarHeight        (44.0f)
#define kNavAndStatusBarHeight  (kIsIOS7OrLater ? kStatusBarHeight + kNavigationBarHeight : kNavigationBarHeight )

#define kTableViewHeight        (kScreenHeight - kNavAndStatusBarHeight)
#define kKeyboardHeight         (256.0f)  //键盘高度为216

#define kViewBeginOriginY       (kIsIOS7OrLater && kIsIOS7Dot2Before ? kNavAndStatusBarHeight : 0)
#define kViewEndSizeHeight      (kIsIOS7OrLater && kIsIOS7Dot2Before ? 0 : kNavAndStatusBarHeight)

#pragma mark -
#pragma mark 系统变量
#define IMAGE(image)            [UIImage imageNamed:image]

#define kAppDelegate            ((CXAppDelegate *)([UIApplication sharedApplication].delegate))
#define kCurrentKeyWindow       [UIApplication sharedApplication].keyWindow

// 文字颜色
#pragma mark -
#pragma mark 颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColorClear            [UIColor clearColor]
#define kColorBlue             [UIColor blueColor]
#define kColorRed              [UIColor redColor]
#define kColorBlack            [UIColor blackColor]
#define kColorBrown            [UIColor brownColor]
#define kColorWhite            [UIColor whiteColor]
#define kColorGreen            [UIColor greenColor]
#define kColorOrange           [UIColor orangeColor]
#define kColorYellow           [UIColor yellowColor]
#define kColorMagenta          [UIColor magentaColor]
#define kColorCyan             [UIColor cyanColor]
#define kColorPurple           [UIColor purpleColor]
#define kColorGrayLight        [UIColor lightGrayColor]
#define kColorGrayDark         [UIColor darkGrayColor]

#define kAction                                        @"Action"

// CELL中的按钮等事件的点击回调函数块定义
typedef void (^ActionClickBlk)(void);
typedef void (^ActionClickParameterBlk)(NSInteger);


typedef NS_ENUM(NSUInteger, LoadMoreState) {
    LoadMoreStateNormal = 0,  //正常状态----"加载更多"
    LoadMoreStateIsLoading,   //加载状态----"正在加载. . . "
    LoadMoreStateComplete,    //加载完成----"加载完成"
    LoadMoreStateFail,        //加载失败----"加载失败"
    LoadMoreStateNoData       //没有数据----"没有数据"
};

typedef NS_ENUM(NSInteger, RequestSuccessType) {
    LoadMoreSuccess = 0,
    ReloadSuccess = 1
};


#endif
