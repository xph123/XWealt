//
//  CXTrackModel.h
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTrackModel : NSObject
//理财轨迹
@property (assign, nonatomic) long releaseId;
@property (assign, nonatomic)long userId;                  // 购买的用户
@property (strong, nonatomic)  NSString *name;             // 产品名称
@property (assign, nonatomic)  int category;               // 产品类型 3信托、4资管、5私募、6其它
@property (assign, nonatomic)  int payType;               // 付息方式
@property (strong, nonatomic)  NSString *payDate;          //认购时间
@property (assign, nonatomic) double amount;               // 购买金额
@property (assign, nonatomic) int lockArea;                // 封闭期限
@property (assign, nonatomic) double profit;              // 收益
@property (strong, nonatomic) NSString *payer;              // 购买人
@property (strong, nonatomic) NSString *remark;              // 说明

@property (strong, nonatomic) NSString *dateline;        // 创建时间
@property (assign, nonatomic) int state;    // 状态，0 未到期，1 已到期。 2. 已删除


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
