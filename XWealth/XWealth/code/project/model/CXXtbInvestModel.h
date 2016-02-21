//
//  CXXtbInvestModel.h
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXtbInvestModel : NSObject

@property (nonatomic, assign) NSInteger investId;//投资ID
@property (nonatomic, strong) NSString *prodType;//产品类型
@property (nonatomic, assign) NSInteger prodId;//产品ID
@property (nonatomic, strong) NSString *prodName;//产品名称
@property (nonatomic, strong) NSString *prodTerm;//产品期限（天）
@property (nonatomic, assign) NSInteger prodStatus;//产品状态
@property (nonatomic, strong) NSString *prodUrl;// 产品详情页
@property (nonatomic, assign) float intstRate;//年化收益率
@property (nonatomic, assign) float invAmt;//投资金额（元）
@property (nonatomic, assign) float intst;//预计收益（元）
@property (nonatomic, strong) NSString *investTime;//投资时间
@property (nonatomic, strong) NSString *inTime;//预定回款时间

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
