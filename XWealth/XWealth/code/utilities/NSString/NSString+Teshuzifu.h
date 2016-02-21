//
//  NSString+Teshuzifu.h
//  Link
//
//  Created by yi.chen on 14-6-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, IMTimeType) {
    IMTimeTypeMessageUI  = 0,
    IMTimeTypeChatUI  = 1
};

@interface NSString (Additions)

- (NSString *)tihuanTeshuzifu;

- (NSString *)getDeviceTokenString;

- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)size;

- (NSString *)telephoneWithReformat;

+ (NSString *)timeIntervalSince1970;
- (NSString *)translateToStandardTime;
- (NSString *)translateToIMTimeWithType:(IMTimeType)type;

+ (NSString*)deviceString;
+ (NSString *)getUniqueStrByUUID;

- (NSString *)getFormateString;

@end
