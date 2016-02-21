//
//  CXSubscribeModel.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSubscribeModel.h"

@implementation CXSubscribeModel

- (id)init
{
    if (self = [super init]) {
        _subscribeId = 0;
        _productId = 0;
        _userId = 0;
        _requirement = @"";
        _money = 0;
        _number = 0;
        _payment = 0;
        _more = @"";
        _dateline = @"";
        _state = 0;
        _name = @"";
        _idno = @"";
        _productName = @"";
    }

    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _subscribeId = [[dictionary objectForKey:@"id"] longValue];
        _productId = [[dictionary objectForKey:@"productId"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _requirement = [CXModelHelper stringValue: dictionary objectForKey:@"requirement"];
        _money = [[dictionary objectForKey:@"money"] doubleValue];
        _number = [[dictionary objectForKey:@"number"] intValue];
        _payment = [[dictionary objectForKey:@"payment"] intValue];
        _more = [CXModelHelper stringValue: dictionary objectForKey:@"more"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _idno = [CXModelHelper stringValue: dictionary objectForKey:@"idno"];
        
    
        NSDictionary *productDic = [dictionary objectForKey:@"product"];
            
        if (![productDic isEmpty])
        {
            _productName = [CXModelHelper stringValue: productDic objectForKey:@"title"];
        }
    }
    return self;
}


@end
