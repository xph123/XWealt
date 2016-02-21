//
//  NSObject+Additions.m
//  Link
//
//  Created by yi.chen on 14-6-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

- (BOOL)isEmpty
{
    BOOL isEmpty = YES;
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if(self && self != nil)
    {
        if([self isKindOfClass:[NSString class]])
        {
            if (self == nil || self == NULL) {
                return YES;
            }
            if(![@"" isEqualToString:[(NSString *)self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
            {
                isEmpty = NO;
            }
        }
        else if([self isKindOfClass:[NSArray class]])
        {
            if([(NSArray *)self count] > 0)
            {
                isEmpty = NO;
            }
        }
        else if([self isKindOfClass:[NSDictionary class]])
        {
            if([[(NSDictionary *)self allKeys] count] > 0)
            {
                isEmpty = NO;
            }
        }
        else isEmpty = NO;
    }
    return isEmpty;
}

+ (BOOL)isEmpty1:(id)object
{
    BOOL isEmpty = YES;
    if(object && object!=nil)
    {
        if([object isKindOfClass:[NSString class]])
        {
            if(![@"" isEqualToString:[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
            {
                isEmpty = NO;
            }
        }
        else if([object isKindOfClass:[NSArray class]])
        {
            if([object count]>0)
            {
                isEmpty = NO;
            }
        }
        else if([object isKindOfClass:[NSDictionary class]])
        {
            if([[object allKeys] count]>0)
            {
                isEmpty = NO;
            }
        }
        else isEmpty = NO;
    }
    
    return isEmpty;
}

@end
