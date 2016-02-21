//
//  CXExpertModel.m
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXExpertModel.h"

@implementation CXExpertModel
- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _name=@"";
        _image=@"";
        _signature=@"";
        _dateline=@"";
        _remark=@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] longValue];
        _name=[dictionary objectForKey:@"name"];
        _image=[dictionary objectForKey:@"image"];
        _signature=[dictionary objectForKey:@"signature"];
        _dateline=[dictionary objectForKey:@"dateline"];
        _remark=[dictionary objectForKey:@"remark"];
           }
    return self;
}

@end
