//
//  CXProductListScheduleModel.m
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXProductListScheduleModel.h"

@implementation CXProductListScheduleModel
- (id)init
{
    if (self = [super init]) {
        self.Id = 0;
        self.productId = 0;
        self.total = 0;
        self.type = @"";
        self.dateline = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        self.Id = [[dictionary objectForKey:@"id"] intValue];
         self.productId = [[dictionary objectForKey:@"productId"] intValue];
         self.total = [[dictionary objectForKey:@"total"] intValue];
        self.type = [dictionary objectForKey:@"type"];
        self.dateline = [dictionary objectForKey:@"dateline"];
    }
    
    return self;
}

@end
