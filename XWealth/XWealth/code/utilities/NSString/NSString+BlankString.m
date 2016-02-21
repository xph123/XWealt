//
//  NSString+BlankString.m
//  Link
//
//  Created by yi.chen on 14-7-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "NSString+BlankString.h"

@implementation NSString (BlankString)

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
