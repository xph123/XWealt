//
//  CXUserModel.h
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUserModel : NSObject

// 接口数据
@property (nonatomic, assign) long userId;  // 用户ID
@property (nonatomic, strong) NSString *userName; // 用户名
@property (nonatomic, strong) NSString *nickName; // 姓名
@property (nonatomic, strong) NSString *headImg; // 头像
@property (nonatomic, strong) NSString *signature; // 签名
@property (nonatomic, strong) NSString *telePhone; // 手机
@property (nonatomic, strong) NSString *mail; // 邮箱
@property (nonatomic, strong) NSString *address; // 所在地
@property (nonatomic, strong) NSString *occupation; // 职业
@property (nonatomic, assign) int sex; //性别 (0:男， 1：女)
@property (nonatomic, assign) int grade; // 等级，
@property (nonatomic, assign) int integral; // 积分
@property (nonatomic, assign) long recomment; // 我的推荐人
@property (nonatomic, strong) NSString *statusBg; // 个人形象（我里面的背影图片）
@property (nonatomic, strong) NSString *mid; // 我的高手码
@property (nonatomic, assign) int pwdupdstate; // 来判断是否需要强制修改密码

// 好友中用到这两个字段
@property (nonatomic, strong) NSString *remarksName;
@property (nonatomic, strong) NSString *remarksEmail;


// 本地变量
//@property (nonatomic, assign) int isFriend; // 是否是好友，1为好友，0为非好友，2为拒绝加好友

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
- (NSString *) getDisplayName; // 得到用来显示的名字
- (NSDictionary *) saveToNSDictionary; // 保存成NSDictionary 格式

@end
