//
//  CXInformation.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationModel.h"

@implementation CXInformationModel

- (id)init
{
    if (self = [super init]) {
        _informationId = 0;
        _name = @"";
        _imageUrl = @"";
        _sltImageUrl = @"";
        _sltImageUrl2 = @"";
        _sltImageUrl3 = @"";
        _url = @"";
        _comments = 0;
        _state = 0;
        _category=0;
        _goods = 0;
        _dateline = @"";
        _source = @"";
        _author = @"";
        _content = @"";
        _imgWidth = 0;
        _imgHeight = 0;
        _pageType =@"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _informationId = [[dictionary objectForKey:@"id"] intValue];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _imageUrl = [dictionary objectForKey:@"imageUrl"];
        _sltImageUrl = [dictionary objectForKey:@"sltImageUrl"];
        _sltImageUrl2 = [dictionary objectForKey:@"sltImageUrl2"];
        _sltImageUrl3 = [dictionary objectForKey:@"sltImageUrl3"];
        _url = [CXModelHelper stringValue: dictionary objectForKey:@"url"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _comments = [[dictionary objectForKey:@"comments"] intValue];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _category = [[dictionary objectForKey:@"category"] intValue];
        _goods = [[dictionary objectForKey:@"goods"] intValue];
        
        _source = [CXModelHelper stringValue: dictionary objectForKey:@"source"];
        _author = [CXModelHelper stringValue: dictionary objectForKey:@"author"];
        _content = [CXModelHelper stringValue: dictionary objectForKey:@"content"];
        _imgWidth = [[dictionary objectForKey:@"imgWidth"] intValue];
        _imgHeight = [[dictionary objectForKey:@"imgHeight"] intValue];
        _pageType = [CXModelHelper stringValue: dictionary objectForKey:@"pageType"];
    }
    return self;
}


@end
