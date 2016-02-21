//
//  CXXtbBillModel.m
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbBillModel.h"

@implementation CXXtbBillModel
- (id)init
{
    if (self = [super init]) {
        self.billId = 0;
        self.type = 0;
        self.childType = 0;
        self.desc = @"";
        self.amount = @"";
        self.balance = @"";
        self.beType = @"";
        self.parmid = 0;
        self.name = @"";
        self.payTime = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        self.billId = [[dictionary objectForKey:@"id"] intValue];
        self.type = [[dictionary objectForKey:@"type"] intValue];
        self.childType = [[dictionary objectForKey:@"childType"] intValue];
        
        self.desc = [dictionary objectForKey:@"desc"];
        self.amount = [dictionary objectForKey:@"amount"];
        self.balance = [dictionary objectForKey:@"balance"];
        self.beType = [dictionary objectForKey:@"beType"];
        
        self.parmid = [[dictionary objectForKey:@"parmid"] intValue];
        
        self.name = [dictionary objectForKey:@"name"];
        self.payTime = [dictionary objectForKey:@"payTime"];
    }
    
    return self;
}

@end
