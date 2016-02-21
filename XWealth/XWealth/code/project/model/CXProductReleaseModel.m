//
//  CXProductReleaseModel.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductReleaseModel.h"

@implementation CXProductReleaseModel

- (id)init
{
    if (self = [super init]) {
        _releaseId = 0;
        _productId = 0;
        _userId = 0;
        _name=@"";
        _profit=0;
        _moneyInto=0;
        _intro = @"";
        _category = 0;
        _scale = @"";
        _deadline = @"";
        _dateline = @"";
        _state = 0;
    }

    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _releaseId = [[dictionary objectForKey:@"id"] longValue];
        _productId = [[dictionary objectForKey:@"productId"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _intro = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _profit = [[dictionary objectForKey:@"moneyInto"] doubleValue];;
        _moneyInto = [[dictionary objectForKey:@"moneyInto"] intValue];
        _category = [[dictionary objectForKey:@"category"] intValue];
        _scale = [CXModelHelper stringValue: dictionary objectForKey:@"scale"];
        _deadline = [CXModelHelper stringValue: dictionary objectForKey:@"deadline"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
    }
    return self;
}

@end
