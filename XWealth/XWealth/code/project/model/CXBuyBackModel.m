//
//  CXBuyBackModel.m
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuyBackModel.h"

@implementation CXBuyBackModel
- (id)init
{
    if (self = [super init]) {
        _buyBackId = 0;
        _userId = 0;
        _userName = @"";
        _phone = @"";
        
        _deadline=0;
        _money=0;
        _profit=0;
        _categoryId=0;
        _investTypeId = 0;
        _intro = @"";

        _dateline = @"";
        _state = 0;
        _receipts = 0;
        _records = 0;
        _comment=@"";
    }
    
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _buyBackId = [[dictionary objectForKey:@"id"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _userName = [CXModelHelper stringValue: dictionary objectForKey:@"userName"];
        _phone = [CXModelHelper stringValue: dictionary objectForKey:@"phone"];
        
        _deadline = [[dictionary objectForKey:@"deadline"] doubleValue];
        _money = [[dictionary objectForKey:@"money"] intValue];
        _categoryId = [[dictionary objectForKey:@"categoryId"] intValue];
        _investTypeId = [[dictionary objectForKey:@"investTypeId"] intValue];
        _profit = [[dictionary objectForKey:@"profit"] doubleValue];
        
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _intro = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _receipts = [[dictionary objectForKey:@"receipts"] intValue];
        _records = [[dictionary objectForKey:@"records"] intValue];
        _comment = [dictionary objectForKey:@"comment"];
    }
    return self;
}

@end
