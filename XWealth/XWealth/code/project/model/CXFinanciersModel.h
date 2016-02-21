//
//  CXFinanciersModel.h
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXFinanciersModel : NSObject
//理财师
@property (assign, nonatomic)long userId;
@property (assign, nonatomic) int state;           // 状态
@property (strong, nonatomic) NSString *certificate;           // 证书
@property (strong, nonatomic) NSString *position;           // 职位
@property (strong, nonatomic) NSString *record;             // 履历
@property (strong, nonatomic) NSString *special;            // 专长
@property (assign, nonatomic)int orderCount;                // 打款笔数
@property (assign, nonatomic)int clientCount;               // 服务人数
@property (assign, nonatomic)int moneyCount;                // 打款金额
@property (assign, nonatomic)int points;                    // 积分
@property (assign, nonatomic)int level;                     // 等级
@property (strong, nonatomic) NSString *identity;           // 区别 0：专属理财师 1：金牌理财师
@property (strong, nonatomic) NSString *institution;        // 机构
@property (strong, nonatomic) NSString *name;               // 名称
@property (strong, nonatomic) NSString *headImg;               // 头像



- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
