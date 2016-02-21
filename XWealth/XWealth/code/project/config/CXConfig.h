//
//  CSConfig.h
//  xProject
//
//  Created by yi.chen on 14-4-27.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCofigFixedFile.h"
#import "CXCofigNotification.h"
#import "CXCofigPromptInfo.h"
#import "CXCofigUIFrame.h"
#import "CXConfigUIColor.h"
#import "CXConfigFont.h"
#import "CXParameterConstants.h"
#import "CXConfigDao.h"

#pragma mark -
#pragma mark 文件保存地址
//图片保存地址
#define IMAGESAVEADDRESS [NSTemporaryDirectory() stringByAppendingString:@"AFImageRequestOperationDownloadingImagesFolder"]

#pragma mark -
#pragma mark 登录 使用固定的token和projectId ??

//#define ProjectId [CSUserSingleton sharedSingleton].projectId //30 //
//#define TOKEN [CSUserSingleton sharedSingleton].token         //@"QzIPrT0fGBpG" //


#define kPageSize                   20
#define kSignatureMaxTextLength     30
#define kTaskMaxTextLength          300
#define kInputTextLimit             300
#define kSmallInputTextLimit        8 // 分类，团队名称等的限制字数

#define kDirectoryOfUser            @"User"  // 用户信息的存放位置

typedef NS_ENUM(NSInteger, ModifyUserInfoType) {
    TypeNickName  = 0,
    TypePhone,
    TypeMail,
    TypeSex,
    TypeSignaute,
    TypeAddress,
    TypeOccupation,
};

typedef enum Product_category
{
    PRODUCT_ALL = 1,
    PRODUCT_CHOICE,
    PRODUCT_TRUST,
    PRODUCT_FUND,
    PRODUCT_SHIBOSAI,
    PRODUCT_OTHER
}ProductCategory;


// 积分类型
#define EXP_SUBSCRIBE    12  // 定购
#define EXP_RECOMMENT    13  // 推荐
// 积分
#define EXP_POINT_SUBSCRIBE    100  // 定购
#define EXP_POINT_RECOMMENT    10  // 推荐


#define BASE_PAGE         1   // 分页从 1 开始


// 讯飞语音
#define APPID_VALUE     @"5486cf63"
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
