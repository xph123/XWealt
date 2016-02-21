//
//  CXBuybackRecordModel.m
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackRecordModel.h"

@implementation CXBuybackRecordModel
- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _userId=0;
        _intro=@"";
        _dateline=@"";
        _state=0;
        _buybackId=0;
        _benefitId=0;
        _money=0;
        
        
        _userName=@"";
        _userHead=@"";
        _phone=@"";
        
        _productName=@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] longValue];
        _userId=[[dictionary objectForKey:@"userId"] longValue];
        _intro=[dictionary objectForKey:@"intro"];
        _dateline=[dictionary objectForKey:@"dateline"];
        _state=[[dictionary objectForKey:@"state"] intValue];
        _buybackId=[[dictionary objectForKey:@"buybackId"] longValue];
        _benefitId=[[dictionary objectForKey:@"benefitId"] longValue];
        _money=[[dictionary objectForKey:@"money"] intValue];
        
        
        
        _userName=[dictionary objectForKey:@"userName"];
        _userHead=[dictionary objectForKey:@"userHead"];
        _phone=[dictionary objectForKey:@"phone"];
        _productName=[dictionary objectForKey:@"productName"];
    }
    return self;
}

@end
