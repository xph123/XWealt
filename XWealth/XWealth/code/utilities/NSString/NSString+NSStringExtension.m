//
//  NSString+NSStringExtension.m
//  Link
//
//  Created by yi.chen on 14-7-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//
#import "NSString+NSStringExtension.h"

@implementation NSString (NSStringExtension)

- (NSString *)localized
{
    return NSLocalizedString(self, nil);
}

- (BOOL)isPureInt
{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

- (BOOL)isPureFloat
{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
@end
