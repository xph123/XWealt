//
//  CXUserModel.m
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserModel.h"

@implementation CXUserModel

- (id)init
{
    if (self = [super init]) {
        _userId = 0;
        _userName = @"";
        _headImg = @"";
        _nickName = @"";
        _signature = @"";
        _telePhone = @"";
        _mail = @"";
        _address = @"";
        _occupation = @"";
        _grade = 0;
        _sex = 0;
        _integral = 0;
        _recomment = 0;
        _statusBg = @"";
//        _isFriend = 0;
        _remarksEmail = @"";
        _remarksName = @"";
        _mid = @"";
        _pwdupdstate=0;
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init])
    {
        _userId = [[dictionary objectForKey:@"id"] intValue];
        _userName = [CXModelHelper stringValue: dictionary objectForKey:@"username"];
        _headImg = [CXModelHelper stringValue: dictionary objectForKey:@"head"];
        _nickName = [CXModelHelper stringValue: dictionary objectForKey:@"nickname"];
        _signature = [CXModelHelper stringValue: dictionary objectForKey:@"signature"];
        _telePhone = [CXModelHelper stringValue: dictionary objectForKey:@"phone"];
        _mail = [CXModelHelper stringValue: dictionary objectForKey:@"bindEmail"];
        _address = [CXModelHelper stringValue: dictionary objectForKey:@"address"];
        _occupation = [CXModelHelper stringValue: dictionary objectForKey:@"industry"];
        _grade = [[dictionary objectForKey:@"grade"] intValue];
        _sex = [[dictionary objectForKey:@"sex"] intValue];
        _integral = [[dictionary objectForKey:@"integral"] intValue];
        _recomment = [[dictionary objectForKey:@"recomment"] intValue];
        _statusBg = [CXModelHelper stringValue: dictionary objectForKey:@"statusBg"];
        _mid = [CXModelHelper stringValue: dictionary objectForKey:@"mid"];
        
        _remarksName = [CXModelHelper stringValue: dictionary objectForKey:@"remarksName"];
        _remarksEmail = [CXModelHelper stringValue: dictionary objectForKey:@"remarksEmail"];
        _pwdupdstate = [[dictionary objectForKey:@"pwdupdstate"] intValue];
//        _isFriend = 0;
    }
    return self;
}

// 得到用来显示的名字
- (NSString *) getDisplayName
{
    NSString *name;
    
    if (![self.remarksName isEmpty])
    {
        name = self.remarksName;
    }
    else
    {
        name = ![self.nickName isEmpty] ? self.nickName : self.userName;
    }
    
    return name;
}

- (NSDictionary *) saveToNSDictionary
{
    NSDictionary *userDic = @{@"id": [NSString stringWithFormat:@"%ld", _userId],
                              @"username": _userName,
                              @"head": _headImg,
                              @"nickname": _nickName,
                              @"signature": _signature,
                              @"phone": _telePhone,
                              @"bindEmail": _mail,
                              @"address": _address,
                              @"industry": _occupation,
                              @"grade": [NSString stringWithFormat:@"%d", _grade],
                              @"sex": [NSString stringWithFormat:@"%d", _sex],
                              @"integral": [NSString stringWithFormat:@"%d", _integral],
                              @"statusBg": _statusBg,
                              @"recomment": [NSString stringWithFormat:@"%ld", _recomment],
                              @"mid": _mid,
                              };
    
    
    return userDic;
}
@end
