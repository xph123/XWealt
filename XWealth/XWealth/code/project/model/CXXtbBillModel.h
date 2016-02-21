//
//  CXXtbBillModel.h
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXtbBillModel : NSObject

@property (nonatomic, assign) NSInteger billId;//资金流水ID
@property (nonatomic, assign) NSInteger type;// 1投资，2回款本金，3充值，4提现，5回款利息，7：转账（活动收益）
@property (nonatomic, assign) NSInteger childType;// 子类型
@property (nonatomic, strong) NSString *desc;//本条信息描述
@property (nonatomic, strong) NSString *amount;//金额
@property (nonatomic, strong) NSString *balance;//本轮操作后可用余额
@property (nonatomic, strong) NSString *beType;//操作对象类型
@property (nonatomic, assign) NSInteger parmid;//操作对象ID
@property (nonatomic, strong) NSString *name;//操作对象名称
@property (nonatomic, strong) NSString *payTime;//操作时间
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
