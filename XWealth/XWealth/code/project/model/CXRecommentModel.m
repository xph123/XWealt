//
//  CXRecommentModel.m
//  XWealth
//
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXRecommentModel.h"

@implementation CXRecommentModel

- (id)init
{
    if (self = [super init]) {
        _recommentId = 0;
        _userId = 0;
        _code = @"";
        _name = @"";
        _phone = @"";
        _dateline = @"";
        _state = 0;
        _type = 0;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _recommentId = [[dictionary objectForKey:@"id"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _code = [CXModelHelper stringValue: dictionary objectForKey:@"code"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _phone = [CXModelHelper stringValue: dictionary objectForKey:@"phone"];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
    }
    return self;
}

@end
