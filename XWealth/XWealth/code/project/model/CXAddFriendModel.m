//
//  CXAddFriendModel.m
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXAddFriendModel.h"

@implementation CXAddFriendModel

- (id)init
{
    if (self = [super init]) {
        _userId = 0;
        _applyInfo = @"";
        _user = [[CXUserModel alloc] init];
        
        _isFriend = 0;
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {

        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _applyInfo = [CXModelHelper stringValue: dictionary objectForKey:@"info"];
        _isFriend = [[dictionary objectForKey:@"state"] intValue];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        
        // 接口返回的ID是添加好友的ID
        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:dictionary];
        model.userId = _userId;
        _user = model;
    }
    return self;
}

@end
