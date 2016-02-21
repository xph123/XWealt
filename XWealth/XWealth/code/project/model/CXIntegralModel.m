//
//  CXIntegralModel.m
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXIntegralModel.h"

@implementation CXIntegralModel

- (id)init
{
    if (self = [super init]) {
        _integralId = 0;
        _userId = 0;
        _varyPoint = 0;
        _remark = @"";
        _type = 0;
        _oldPoint = 0;
        _newPoint = 0;
        _eventName = @"";
        _dateline = @"";
        _eventId = 0;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _integralId = [[dictionary objectForKey:@"id"] longValue];
        _varyPoint = [[dictionary objectForKey:@"varyPoint"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _remark = [CXModelHelper stringValue: dictionary objectForKey:@"remark"];
        _type = [[dictionary objectForKey:@"type"] intValue];
        _oldPoint = [[dictionary objectForKey:@"oldPoint"] intValue];
        _eventId = [[dictionary objectForKey:@"eventId"] intValue];
        _eventName = [CXModelHelper stringValue: dictionary objectForKey:@"eventName"];
        _newPoint = [[dictionary objectForKey:@"newPoint"] intValue];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
    }
    return self;
}


@end
