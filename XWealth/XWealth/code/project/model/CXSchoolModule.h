//
//  CXSchoolModule.h
//  XWealth
//
//  Created by gsycf on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSchoolModule : NSObject
// 理财学堂模块名称表，如最新政策、法律法规 等
@property (assign, nonatomic) int Id;
@property (strong, nonatomic) NSString *name; //名称
@property (strong, nonatomic) NSString *logoUrl; // logo的url路径
@property (assign, nonatomic) NSInteger state;    // 发布状态，0 有效，1失效
@property (assign, nonatomic) NSInteger moduleId;    // 分类ID
@property (strong, nonatomic) NSString *dateline;  // 创建时间


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
