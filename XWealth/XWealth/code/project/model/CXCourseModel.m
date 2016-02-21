//
//  CXCourseModel.m
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXCourseModel.h"

@implementation CXCourseModel
- (id)init
{
    if (self = [super init]) {
        _classId = 0;
        _name=@"";
        _imageUrl=@"";
        _sltImageUrl=@"";
        _readers = 0;
        _goods = 0;
        _comments = 0;
        _url=@"";
        _dateline=@"";
        _state = 0;
        _source=@"";
        _author=@"";
        _content=@"";
        _category = 0;
        _type = 0;
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        _classId = [[dictionary objectForKey:@"id"] longValue];
        _name=[dictionary objectForKey:@"name"];
        _imageUrl=[dictionary objectForKey:@"imageUrl"];
        _sltImageUrl=[dictionary objectForKey:@"sltImageUrl"];
        _readers=[[dictionary objectForKey:@"readers"] intValue];
        _goods=[[dictionary objectForKey:@"goods"] intValue];
        _comments=[[dictionary objectForKey:@"comments"] intValue];
        _url=[dictionary objectForKey:@"url"];
        _dateline=[dictionary objectForKey:@"dateline"];
        _state=[[dictionary objectForKey:@"state"] intValue];
        _source=[dictionary objectForKey:@"source"];
        _author=[dictionary objectForKey:@"author"];
        _content=[dictionary objectForKey:@"content"];
        _category=[[dictionary objectForKey:@"category"] intValue];
        _type=[[dictionary objectForKey:@"type"] intValue];
        
    }
    return self;
}
@end
