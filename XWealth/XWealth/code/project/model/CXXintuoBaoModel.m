//
//  CXXintuoBaoModel.m
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXintuoBaoModel.h"

@implementation CXXintuoBaoModel
- (id)init
{
    if (self = [super init]) {
        _productId = 0;
        _name=@"";
        _activity = 0;
        _issuance = 0;
        _rate = 0;
        _term = 0;
        _progress = 0;
        _isDesc=@"";
        _flag = 0;
        _url=@"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _productId = [[dictionary objectForKey:@"id"] intValue];
        _name=[dictionary objectForKey:@"name"];
        _activity=[[dictionary objectForKey:@"activity"] intValue];
        _issuance=[[dictionary objectForKey:@"issuance"] intValue];
        _rate=[[dictionary objectForKey:@"rate"] floatValue];
        _url=[dictionary objectForKey:@"url"];
        _term=[[dictionary objectForKey:@"term"] intValue];
        _flag=[[dictionary objectForKey:@"flag"] intValue];
        _progress=[[dictionary objectForKey:@"progress"] floatValue];
        _isDesc=[CXModelHelper stringValue: dictionary objectForKey:@"desc"];
        
    }
    return self;
}

@end
