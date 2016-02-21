//
//  CXBenefitRecordModel.m
//  XWealth
//
//  Created by gsycf on 15/10/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBenefitRecordModel.h"

@implementation CXBenefitRecordModel
- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _userId=0;
        _userName=@"";
        _userHead=@"";
        _phone=@"";
        _intro=@"";
        _dateline=@"";
        _state=0;
        _benefitId=0;
        

    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] longValue];
        _userId=[[dictionary objectForKey:@"userId"] longValue];
        _userName=[dictionary objectForKey:@"userName"];
        _userHead=[dictionary objectForKey:@"userHead"];
        _phone=[dictionary objectForKey:@"phone"];
        _intro=[dictionary objectForKey:@"intro"];
        _dateline=[dictionary objectForKey:@"dateline"];
        _state=[[dictionary objectForKey:@"state"] intValue];
        _benefitId=[[dictionary objectForKey:@"benefitId"] longValue];

    }
    return self;
}
@end
