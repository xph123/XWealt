//
//  CXProductReleaseModel.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductReleaseModel : NSObject
//我的发布
@property (nonatomic, assign) long releaseId;
@property (nonatomic, assign) long userId;
@property (nonatomic, assign) long productId;
@property (nonatomic, strong) NSString *name;  //产品名称
@property (nonatomic, assign) double profit;   // 最低收益（%）
@property (nonatomic, assign) int moneyInto;   // 投向（下拉）* 地产、基建、企业贷款、证券、新三板、其它
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, assign) int  category;
@property (nonatomic, strong) NSString *scale;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, assign) int state; // 发布状态，0 等待审核，1 审核通过，2 审核不通过

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
