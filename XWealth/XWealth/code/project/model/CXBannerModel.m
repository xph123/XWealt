//
//  CXBannerModel.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXBannerModel.h"

@implementation CXBannerModel

- (id)init
{
    if (self = [super init]) {
        _bannerId = 0;
        _name = @"";
        _imageUrl = @"";
        _url = @"";
        _intro = @"";
        _indexs = 0;
        _state = 0;
        _productId = 0;
        _dateline = @"";
        _ptypeId = 0;
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _bannerId = [[dictionary objectForKey:@"id"] intValue];
        _name = [CXModelHelper stringValue: dictionary objectForKey:@"name"];
        _imageUrl = [kBaseURLString stringByAppendingString:[dictionary objectForKey:@"imageUrl"]];
        _intro = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _url = [CXModelHelper stringValue: dictionary objectForKey:@"url"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _indexs = [[dictionary objectForKey:@"indexs"] intValue];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _productId = [[dictionary objectForKey:@"productId"] longValue];
        _ptypeId = [[dictionary objectForKey:@"ptypeId"] intValue];
    }
    return self;
}



@end
