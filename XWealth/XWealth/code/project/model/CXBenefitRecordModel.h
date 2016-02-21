//
//  CXBenefitRecordModel.h
//  XWealth
//
//  Created by gsycf on 15/10/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBenefitRecordModel : NSObject
//信托转让,认购记录

@property (assign, nonatomic) long Id;
@property (assign, nonatomic)long userId;                 // 购买的用户
@property (strong, nonatomic) NSString *userName;        //用户名字
@property (strong, nonatomic) NSString *userHead;        //用户头像
@property (strong, nonatomic)  NSString *phone;          // 电话号码
@property (strong, nonatomic) NSString *intro;           // 更多，补充说明

@property (strong, nonatomic) NSString *dateline;        // 创建时间
@property (assign, nonatomic) int state;    // 状态，0 客服未处理，1 客服已处理。 2.  购买成功  3.  未购买 4 已删除
@property (assign, nonatomic)long benefitId;                 // 转让的ID

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
