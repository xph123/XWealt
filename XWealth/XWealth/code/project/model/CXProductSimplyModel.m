//
//  CXProductSimplyModel.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductSimplyModel.h"

@implementation CXProductSimplyModel

- (id)init
{
    if (self = [super init]) {
        _productId = 0;
        _title = @"";
        _category = 0;
        _moneyInto = @"";
        _scale = 0;
        _deadline = @"";
        _fullDeadline = @"";
        _profit = @"";
        _fullProfit = @"";
        _subscribe = @"";
        _bank = @"";
        _state = 0;
        _choice = 0;
        _comment = @"";
        _dateline = @"";
        _assign = @"";
        _proportion = @"";
        _purchase = 0;
        _receipts = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _productId = [[dictionary objectForKey:@"id"] longValue];
        _title = [CXModelHelper stringValue: dictionary objectForKey:@"title"];
        _category = [[dictionary objectForKey:@"category"] intValue];
        
        _moneyInto = [CXModelHelper stringValue: dictionary objectForKey:@"moneyInto"];
        _scale = [[dictionary objectForKey:@"scale"] intValue];
        _deadline = [CXModelHelper stringValue: dictionary objectForKey:@"deadline"];
        _fullDeadline = [CXModelHelper stringValue: dictionary objectForKey:@"fullDeadline"];
        _profit = [CXModelHelper stringValue: dictionary objectForKey:@"profit"];
        _fullProfit = [CXModelHelper stringValue: dictionary objectForKey:@"fullProfit"];
        _subscribe = [CXModelHelper stringValue: dictionary objectForKey:@"subscribe"];
        _bank = [CXModelHelper stringValue: dictionary objectForKey:@"bank"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _choice = [[dictionary objectForKey:@"choice"] intValue];
        _comment = [CXModelHelper stringValue: dictionary objectForKey:@"comment"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        
        _assign = [CXModelHelper stringValue: dictionary objectForKey:@"assign"];
        _proportion = [CXModelHelper stringValue: dictionary objectForKey:@"proportion"];
        _purchase = [[dictionary objectForKey:@"purchase"] intValue];
        _receipts = [[dictionary objectForKey:@"receipts"] intValue];
    }
    return self;
}


@end
