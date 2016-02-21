//
//  CXTrackModel.m
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXTrackModel.h"

@implementation CXTrackModel
- (id)init
{
    if (self = [super init]) {
        _releaseId = 0;
        _userId=0;
        _name=@"";
        _category=0;
        _payType=0;
        _payDate=@"";
        _amount=0;
        _lockArea=0;
        _profit=0;
        _payer=@"";
        _dateline=@"";
        _state=0;
        _remark=@"";
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _releaseId = [[dictionary objectForKey:@"id"] longValue];
        _userId=[[dictionary objectForKey:@"userId"] longValue];
        _name=[dictionary objectForKey:@"name"];
        _category=[[dictionary objectForKey:@"category"] intValue];
        _payType=[[dictionary objectForKey:@"payType"] intValue];
        _payDate=[dictionary objectForKey:@"payDate"];
        _amount=[[dictionary objectForKey:@"amount"] doubleValue];
        _lockArea=[[dictionary objectForKey:@"lockArea"] intValue];
        _profit=[[dictionary objectForKey:@"profit"] doubleValue];
        _payer=[dictionary objectForKey:@"payer"];
        _dateline=[CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _state=[[dictionary objectForKey:@"state"] intValue];
        _remark=[dictionary objectForKey:@"remark"];
    }
    return self;
}

@end
