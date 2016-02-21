//
//  CXListInvestCategoryModel.m
//  XWealth
//
//  Created by gsycf on 15/8/17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXListInvestCategoryModel.h"

@implementation CXListInvestCategoryModel
- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _name = @"";
        _logoUrl = @"";
        _dateline = @"";
        _state = 0;
        _categoryId=0;
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _logoUrl = [CXURLConstants getFullProductCategoryUrl:[dictionary objectForKey:@"logoUrl"] ];
        _dateline = [dictionary objectForKey:@"dateline"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _categoryId=[[dictionary objectForKey:@"categoryId"] intValue];
    }
    return self;
}

@end
