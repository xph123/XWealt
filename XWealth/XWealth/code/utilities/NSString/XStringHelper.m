//
//  XStringHelper.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XStringHelper.h"

@implementation XStringHelper

#pragma mark - 用正则表达式验证邮箱
+ (BOOL) isValidateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - 用正则表达式验证手机号码
+ (BOOL)isValidateTelePhone:(NSString *)strPhone
{
    if ([strPhone length] == 0)
    {
        return NO;
    }
    
    NSString * MOBILE = @"^1([0-9])\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    BOOL res1 = [regextestmobile evaluateWithObject:strPhone];
    
    if (res1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 整形判断
+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
