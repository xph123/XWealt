//
//  CXGroupModel.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupModel.h"

@implementation CXGroupModel

- (id)init
{
    if (self = [super init]) {
        _groupID = 0;
        _groupName = @"";
        _groupDesc = @"";
        _groupLogo = @"";
        _createDate = @"";
        _managerUserId = 0;
        _memberCount = 0;
        _remain = 0;
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    //{"dateline":"2015-01-26 11:33:38","grade":0,"id":3,"intro":"在于自己如何","logo":"3.jpg","managerUserId":2,"name":"一个人","number":3,"organizationId":0,"sysad":"","type":0}
    if (self = [self init]) {
        _groupID = [[dictionary objectForKey:@"id"] longValue];
        _groupName = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _groupLogo = [CXURLConstants getGroupLogoImageUrl: [dictionary objectForKey:@"logo"]];
        _groupDesc = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _createDate = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _managerUserId = [[dictionary objectForKey:@"managerUserId"] longValue];
        _memberCount = [[dictionary objectForKey:@"number"] intValue];
        _remain = [[dictionary objectForKey:@"grade"] intValue];
        
        //        _isFriend = 0;
    }
    return self;
}

@end
