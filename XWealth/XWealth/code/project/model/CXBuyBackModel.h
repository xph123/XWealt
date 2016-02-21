//
//  CXBuyBackModel.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBuyBackModel : NSObject
//受让信托
@property (nonatomic, assign) long buyBackId;

@property (nonatomic, assign) long userId;// 购买的用户
@property (nonatomic, strong) NSString *userName;  //用户名字
@property (nonatomic, strong) NSString *phone;  //手机

@property (nonatomic, assign) int deadline;   // 投资期限（月）
@property (nonatomic, assign) int money;   // 投资金额（万）
@property (nonatomic, assign) double profit;   // 收益要求

@property (nonatomic, assign) int  categoryId;   // 分类(信托、资管等的ID)
@property (nonatomic, assign) int investTypeId;   // 投向（下拉）* 地产、基建、企业贷款、证券、新三板、其它
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *dateline; // 创建时间
@property (nonatomic, assign) int state; // 状态，0 客服未处理，1 客服已处理。 2.  购买完成  3.  未购买 4 已删除
@property (nonatomic, assign) int receipts;// 已进款;
@property (nonatomic, assign) int records; //认购数
@property (nonatomic, strong) NSString *comment; // 专家点评

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
