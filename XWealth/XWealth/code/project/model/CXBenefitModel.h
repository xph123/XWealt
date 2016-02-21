//
//  CXBenefitModel.h
//  XWealth
//
//  Created by gsycf on 15/8/17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
//信托转让
@interface CXBenefitModel : NSObject
@property (assign, nonatomic) long releaseId;
@property (assign, nonatomic)long userId;                 // 购买的用户
@property (strong, nonatomic) NSString *userName;        //用户名字
@property (strong, nonatomic)  NSString *phone;          // 电话号码
@property (strong, nonatomic)  NSString *name;           // 信托名称
@property (assign, nonatomic) int deadline;        // 期限（月）
@property (assign, nonatomic) double money;           // 购买金额
@property (strong, nonatomic)  NSString *establishDate;  //成立时间
@property (assign, nonatomic) double profit;              // 收益

@property (assign, nonatomic) int days;                   // 剩余天数
@property (assign, nonatomic) double preProfit;              // 预计收益
@property (strong, nonatomic) NSString *acceptDisCount;         // 折扣
@property (strong, nonatomic) NSString *preTransDate;           // 预计转让日期
@property (assign, nonatomic) int payType;               // 付息方式
@property (assign, nonatomic) int recLevel;               // 推荐等级： 0 普通，3 新品上架， 6 独家推荐
@property (strong, nonatomic) NSString *comment;           // 专家点评

@property (strong, nonatomic) NSString *intro;           // 更多，补充说明
@property (strong, nonatomic) NSString *dateline;        // 创建时间
@property (assign, nonatomic)  long productId;               // 转让关联平台中产品的ID
@property (assign, nonatomic)  long categoryId;               // 产品类型 3信托、4资管、5私募、6其它
@property (assign, nonatomic)  long investTypeId;               // 投向ID
@property (assign, nonatomic) int state;    // 状态，0 正在审核，1 已上架。 2.  购买成功  3.  购买失败 4 已删除
@property (nonatomic, assign) int records; //认购数

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
