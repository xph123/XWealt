//
//  CXCommentModel.m
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCommentModel.h"

@implementation CXCommentModel

- (id)init
{
    if (self = [super init]) {
        _userId = 0;
        _userName = @"";
        _head = @"";
        _taskId = 0;
        _commentId = 0;
        _content = @"";
        _beCommentUserId = 0;
        _beCommnetUserName = @"";
        _dateline = @"";
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _commentId = [[dictionary objectForKey:@"id"] longValue];
        _userId = [[dictionary objectForKey:@"userId"] longValue];
        _userName = [CXModelHelper stringValue: dictionary objectForKey:@"nickname"];
        _head = [CXModelHelper stringValue: dictionary objectForKey:@"head"];
        _taskId = [[dictionary objectForKey:@"taskId"] longValue];
        _content = [CXModelHelper stringValue: dictionary objectForKey:@"content"];
        _beCommentUserId = [[dictionary objectForKey:@"beCommentUserId"] longValue];
        _beCommnetUserName = [CXModelHelper stringValue: dictionary objectForKey:@"beCommnetNickName"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];

    }
    return self;
}


@end
