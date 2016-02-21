//
//  CXBuybackRecordModel.h
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBuybackRecordModel : NSObject
// 信托受让，认购记录

@property (assign, nonatomic) long Id;
@property (assign, nonatomic)long userId;                 // 购买的用户
@property (strong, nonatomic) NSString *intro;           // 更多，补充说明
@property (strong, nonatomic) NSString *dateline;        // 创建时间
@property (assign, nonatomic) int state;    // 状态，0 客服未处理，1 客服已处理。 2.  购买成功  3.  未购买 4 已删除
@property (assign, nonatomic)long buybackId;                 // 受让信托ID
@property (assign, nonatomic)long benefitId;                 // 转让的ID，目前预约受让都需要先发布转让
@property (assign, nonatomic)int money;                 // 金额

@property (strong, nonatomic) NSString *userName;        //用户名字
@property (strong, nonatomic) NSString *userHead;        //用户头像
@property (strong, nonatomic) NSString *phone;          // 电话号码

@property (strong, nonatomic) NSString *productName;          // 产品名称

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
