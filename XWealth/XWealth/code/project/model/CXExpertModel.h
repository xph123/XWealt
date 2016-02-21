//
//  CXExpertModel.h
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
//名家专栏
@interface CXExpertModel : NSObject
@property (assign, nonatomic) long Id;
@property (strong, nonatomic) NSString *name;           // 名称
@property (strong, nonatomic) NSString *image;           // 头像URl
@property (strong, nonatomic) NSString *signature;           // 介绍
@property (strong, nonatomic) NSString *dateline;        // 创建时间
@property (strong, nonatomic) NSString *remark;           // 备注


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
