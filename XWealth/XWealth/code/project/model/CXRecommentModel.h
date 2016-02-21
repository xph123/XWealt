//
//  CXRecommentModel.h
//  XWealth
//
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXRecommentModel : NSObject

@property (nonatomic, assign) NSInteger recommentId; // id
@property (nonatomic, assign) NSInteger userId;  // 用户ID
@property (nonatomic, strong) NSString *code; // 备用
@property (nonatomic, strong) NSString *dateline; // 关注时间
@property (nonatomic, strong) NSString *phone; // 被推荐电话
@property (nonatomic, strong) NSString *name; // 被推荐人通讯录中的名字
@property (nonatomic, assign) int state; // 状态，0 表示未注册，1表示注册，2表示注册时填写邀请人

@property (nonatomic, assign) int type; // 本地数据，0 表示我的邀请，1表示邀请

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
