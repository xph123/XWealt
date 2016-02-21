//
//  CXFinanciersModel.m
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXFinanciersModel.h"

@implementation CXFinanciersModel
- (id)init
{
    if (self = [super init]) {
        _userId=0;
        _state=0;
        _certificate=@"";
        _position=@"";
        _special=@"";
        _record=@"";
        _orderCount=0;
        _clientCount=0;
        _moneyCount=0;
        _points=0;
        _level=0;
        _identity=@"";
        _institution=@"";
        _name=@"";
        _headImg=@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _userId=[[dictionary objectForKey:@"userId"] longValue];
        
        _state=[[dictionary objectForKey:@"state"] intValue];
        _certificate=[dictionary objectForKey:@"certificate"];
        _position=[dictionary objectForKey:@"position"];
        _special=[dictionary objectForKey:@"record"];
        _record=[dictionary objectForKey:@"special"];
        _orderCount=[[dictionary objectForKey:@"orderCount"] intValue];
        _clientCount=[[dictionary objectForKey:@"clientCount"] intValue];
        _moneyCount=[[dictionary objectForKey:@"moneyCount"] intValue];
        _points=[[dictionary objectForKey:@"points"] intValue];
        _level=[[dictionary objectForKey:@"level"] intValue];
        _identity=[dictionary objectForKey:@"identity"];
        _institution=[dictionary objectForKey:@"institution"];
        CXUserModel *userModel=[[CXUserModel alloc]initWithDictionary:[dictionary objectForKey:@"user"]];
        NSString *nameStr=userModel.nickName;
        if ([nameStr isEqualToString:@""]) {
            nameStr=userModel.userName;
        }
        _name =nameStr;
        _headImg = userModel.headImg;
        
    }
    return self;
}
@end
