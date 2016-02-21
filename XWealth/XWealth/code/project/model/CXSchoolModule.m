//
//  CXSchoolModule.m
//  XWealth
//
//  Created by gsycf on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSchoolModule.h"

@implementation CXSchoolModule
- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _name = @"";
        _logoUrl = @"";
        _state = 0;
        _moduleId = 0;
        _dateline = @"";
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _logoUrl = [CXURLConstants getFullProductCategoryUrl:[dictionary objectForKey:@"logoUrl"] ];
         _state = [[dictionary objectForKey:@"state"] intValue];
         _moduleId = [[dictionary objectForKey:@"moduleId"] intValue];
        _dateline = [dictionary objectForKey:@"dateline"];
       
    }
    return self;
}

@end
