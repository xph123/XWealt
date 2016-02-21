//
//  XStringHelper.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XStringHelper : NSObject

#pragma mark - 用正则表达式验证邮箱
+ (BOOL) isValidateEmail: (NSString *) candidate;
#pragma mark - 用正则表达式验证手机号码
+ (BOOL)isValidateTelePhone:(NSString *)strPhone;
#pragma mark - 整形判断
+ (BOOL)isPureInt:(NSString *)string;
#pragma mark - 浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string;

@end
