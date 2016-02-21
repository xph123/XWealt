//
//  CXModelHelper.m
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXModelHelper.h"

@implementation CXModelHelper

+ (NSString*) stringValue:(NSDictionary *)dictionary objectForKey:(NSString*)key
{
    NSString *str = [dictionary objectForKey:key];
    
    if (!str)
    {
        str = @"";
    }
    
    return str;
}
@end
