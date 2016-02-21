//
//  CXMyshareModel.m
//  XWealth
//
//  Created by gsycf on 15/12/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyshareModel.h"

@implementation CXMyshareModel
- (id)init
{
    if (self = [super init]) {
        _Id=0;
        _name=@"";
        _intro=@"";
        _url=@"";
        _imageUrl=@"";
        _code=@"";
        _shareUrl=@"";
        _inviteId=@"";
        _integral=@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _Id = [[dictionary objectForKey:@"id"] longValue];
        _name=[dictionary objectForKey:@"name"];
        _intro=[dictionary objectForKey:@"intro"];
        _url=[dictionary objectForKey:@"url"];
        _imageUrl=[dictionary objectForKey:@"imageUrl"];
        _code=[dictionary objectForKey:@"code"];
        _shareUrl=[dictionary objectForKey:@"shareUrl"];
        _inviteId=[dictionary objectForKey:@"inviteId"];
        _integral=[dictionary objectForKey:@"integral"];
    }
    return self;
}
@end
