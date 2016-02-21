//
//  CXProductSimplyModel.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductSimplyModel : NSObject

@property (nonatomic, assign) long productId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int category;
@property (nonatomic, strong) NSString *moneyInto;
@property (nonatomic, assign) int scale;

@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *fullDeadline;//新增产品期限（字段）

@property (nonatomic, strong) NSString *profit;
@property (nonatomic, strong) NSString *fullProfit;//新增预期收益（字段）


@property (nonatomic, strong) NSString *subscribe;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *comment; // 点评
@property (nonatomic, assign) int state; //1，删除；2，停售，3在售，5预热，8热卖
                                        // 原来状态，5：已删除；6：停售；7：在售；8：热卖 9：未上架
@property (nonatomic, assign) int choice;//1.精选，2普通
@property (nonatomic, strong) NSString *dateline;

@property (nonatomic, strong) NSString *assign; // 分配方式
@property (nonatomic, strong) NSString *proportion; // 配   比
@property (nonatomic, assign) int purchase; // 已抢购
@property (nonatomic, assign) int receipts; // 已进款



- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;


@end
