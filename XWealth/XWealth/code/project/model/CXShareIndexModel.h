//
//  CXShareIndexModel.h
//  XWealth
//
//  Created by gsycf on 16/1/14.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXShareIndexModel : NSObject
//分享有礼数据
@property (assign, nonatomic) long Id;
@property (strong, nonatomic) NSString *sharesName;             //股票名称
@property (strong, nonatomic) NSString *curr_price;             //当前价格
@property (strong, nonatomic) NSString *yes_price;              // 昨日收盘价
@property (strong, nonatomic) NSString *price;                  //涨跌幅度
@property (strong, nonatomic) NSString *percent_price;          //涨跌百分比

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
