//
//  CXBenefitModel.m
//  XWealth
//
//  Created by gsycf on 15/8/17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXBenefitModel.h"

@implementation CXBenefitModel
- (id)init
{
    if (self = [super init]) {
        _releaseId = 0;
        _userId=0;
        _userName=@"";
        _phone=@"";
        _name=@"";
        _deadline=0;
        _money=0;
        _establishDate=@"";
        _profit=0;
        _intro=@"";
        _dateline=@"";
        _state=0;
        _productId=0;
        _categoryId=0;
        _investTypeId=0;
        _records=0;
        
        _days=0;
        _preProfit=0;
        _acceptDisCount=@"";
        _preTransDate=@"";
        _payType=0;
        _recLevel=0;
        _comment=@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _releaseId = [[dictionary objectForKey:@"id"] longValue];
        _userId=[[dictionary objectForKey:@"userId"] longValue];
        _userName=[dictionary objectForKey:@"userName"];
        _phone=[dictionary objectForKey:@"phone"];
        _name=[dictionary objectForKey:@"name"];
        _deadline=[[dictionary objectForKey:@"deadline"] intValue];
        _money=[[dictionary objectForKey:@"money"] doubleValue];
        _establishDate=[dictionary objectForKey:@"establishDate"];
        _profit=[[dictionary objectForKey:@"profit"] doubleValue];
        _intro=[dictionary objectForKey:@"intro"];
        _dateline=[CXModelHelper stringValue:dictionary objectForKey:@"dateline"];
        _state=[[dictionary objectForKey:@"state"] intValue];
        _productId=[[dictionary objectForKey:@"productId"] longValue];
        _categoryId=[[dictionary objectForKey:@"categoryId"] longValue];
        _investTypeId=[[dictionary objectForKey:@"investTypeId"] longValue];
        _records=[[dictionary objectForKey:@"records"]intValue];
        
        _days=[[dictionary objectForKey:@"days"]intValue];
        _preProfit=[[dictionary objectForKey:@"preProfit"]doubleValue];
        _acceptDisCount=[dictionary objectForKey:@"acceptDisCount"];
        _preTransDate=[dictionary objectForKey:@"preTransDate"];
        _payType=[[dictionary objectForKey:@"payType"]intValue];
        _recLevel=[[dictionary objectForKey:@"recLevel"]intValue];
        _comment=[dictionary objectForKey:@"comment"];
    }
    return self;
}
@end
