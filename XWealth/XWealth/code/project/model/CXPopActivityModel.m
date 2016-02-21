//
//  CXPopActivityModel.m
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXPopActivityModel.h"

@implementation CXPopActivityModel

- (id)init
{
    if (self = [super init]) {
        _activityId = 0;
        _infoId=0;
        _name = @"";
        _imageUrl = @"";
        _url = @"";
        _intro = @"";
        _btnText = @"";
        _state = 0;
        _dateline = @"";
        _startDate = @"";
        _shareUrl=@"";
        _endDate = @"";
        _type = 0;
        _platform = 0;
        _joined = 0;
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _activityId = [[dictionary objectForKey:@"id"] intValue];
        _infoId = [[dictionary objectForKey:@"infoId"] intValue];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _imageUrl = [kBaseURLString stringByAppendingString:[dictionary objectForKey:@"imageUrl"]];
        _intro = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _url = [CXModelHelper stringValue: dictionary objectForKey:@"url"];
        _btnText = [CXModelHelper stringValue: dictionary objectForKey:@"btnText"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _startDate = [CXModelHelper stringValue: dictionary objectForKey:@"startDate"];
        _endDate = [CXModelHelper stringValue: dictionary objectForKey:@"endDate"];
         _shareUrl = [CXModelHelper stringValue: dictionary objectForKey:@"shareUrl"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _type = [[dictionary objectForKey:@"type"] intValue];
        
        _platform = [[dictionary objectForKey:@"platform"] intValue];
        _joined = [[dictionary objectForKey:@"joined"] intValue];
    }
    return self;
}


@end
