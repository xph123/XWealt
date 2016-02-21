//
//  CXXtbInvestModel.m
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbInvestModel.h"

@implementation CXXtbInvestModel

- (id)init
{
    if (self = [super init]) {
        self.investId = 0;
        self.prodType = @"";
        self.prodId = 0;
        self.prodName = @"";
        self.prodTerm = @"";
        self.prodStatus = 0;
        self.prodUrl = @"";
        self.investTime = @"";
        self.inTime = @"";
        
        self.intstRate = 0;
        self.invAmt = 0;
        self.intst = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        self.investId = [[dictionary objectForKey:@"id"] intValue];
        self.prodType = [dictionary objectForKey:@"prodType"];
        self.prodId = [[dictionary objectForKey:@"prodId"] intValue];
        self.prodName = [dictionary objectForKey:@"prodName"];
        self.prodTerm = [dictionary objectForKey:@"prodTerm"];
        self.prodStatus = [[dictionary objectForKey:@"prodStatus"] intValue];
        self.prodUrl = [dictionary objectForKey:@"prodUrl"];
       
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        
        NSTimeInterval invTimeInt=[[dictionary objectForKey:@"invTime"] doubleValue];
        NSDate *invTimeDate=[NSDate dateWithTimeIntervalSince1970:invTimeInt];
        
        self.investTime = [dateFormatter stringFromDate: invTimeDate];
        
        NSTimeInterval inTimeInt=[[dictionary objectForKey:@"inTime"] doubleValue];
        NSDate *inTimeDate=[NSDate dateWithTimeIntervalSince1970:inTimeInt];
        
        self.inTime = [dateFormatter stringFromDate: inTimeDate];

        self.intstRate = [[dictionary objectForKey:@"intstRate"] floatValue];
        self.invAmt = [[dictionary objectForKey:@"invAmt"] floatValue];
        self.intst = [[dictionary objectForKey:@"intst"] floatValue];
    }
    
    return self;
}

@end
