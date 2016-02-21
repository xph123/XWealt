//
//  CXShareIndexModel.m
//  XWealth
//
//  Created by gsycf on 16/1/14.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import "CXShareIndexModel.h"

@implementation CXShareIndexModel
-(id)init
{
    self=[super init];
    if (self) {
        _sharesName=@"";
        _curr_price=@"";
        _yes_price=@"";
        _price=@"";
        _percent_price=@"";
    }
    return self;
}
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self=[self init];
    if (self) {
        _sharesName=[dictionary objectForKey:@"sharesName"];
        _curr_price=[dictionary objectForKey:@"curr_price"];
        _yes_price=[dictionary objectForKey:@"yes_price"];
        _price=[dictionary objectForKey:@"price"];
        _percent_price=[dictionary objectForKey:@"percent_price"];
    }
    return self;
}
@end
