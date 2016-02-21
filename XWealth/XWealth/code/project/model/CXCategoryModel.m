//
//  CXCategoryModel.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCategoryModel.h"

@implementation CXCategoryModel

- (id)init
{
    if (self = [super init]) {
        _Id = 0;
        _name = @"";
        _logoUrl = @"";
        _dateline = @"";
        _state = 0;
        _value = 0;
        _ptypeId = 0;
        _column1 = @"";
        _column2 = @"";
        _column3 = @"";
        _categoryId = 0;
        _url=@"";
    }
    return self;
}

- (id)init:(int)Id andName:(NSString*)name andImg:(NSString*)logoUrl
{
    if (self = [super init]) {
        _Id = Id;
        _name = name;
        _logoUrl = logoUrl;
    }
    return self;
}

- (id)initWithProductDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _state = [[dictionary objectForKey:@"state"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _Id = [[dictionary objectForKey:@"id"] intValue];
        _logoUrl = [CXURLConstants getFullProductCategoryUrl:[dictionary objectForKey:@"logoUrl"] ];
        _dateline = [dictionary objectForKey:@"dateline"];
        _value = [[dictionary objectForKey:@"value"] intValue];
        _ptypeId = [[dictionary objectForKey:@"ptypeId"] intValue];
        _column1 = [dictionary objectForKey:@"column1"];
        _column2 = [dictionary objectForKey:@"column2"];
        _column3 = [dictionary objectForKey:@"column3"];
        _categoryId = [[dictionary objectForKey:@"categoryId"] intValue];
        _url=[dictionary objectForKey:@"url"];
    }
    return self;
}

- (id)initWithInformationDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _state = [[dictionary objectForKey:@"state"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _Id = [[dictionary objectForKey:@"id"] intValue];
        _logoUrl = [CXURLConstants getFullInformationCategoryUrl:[dictionary objectForKey:@"logoUrl"] ];
        _dateline = [dictionary objectForKey:@"dateline"];
        _value = [[dictionary objectForKey:@"value"] intValue];
        _ptypeId = [[dictionary objectForKey:@"ptypeId"] intValue];
        _column1 = [dictionary objectForKey:@"column1"];
        _column2 = [dictionary objectForKey:@"column2"];
        _column3 = [dictionary objectForKey:@"column3"];
        _categoryId = [[dictionary objectForKey:@"categoryId"] intValue];
        _url=[dictionary objectForKey:@"url"];
    }
    return self;
}

@end
