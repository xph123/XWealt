//
//  CSHttpParaments.m
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XHttpParameters.h"

@implementation XHttpParameters

- (id)init
{
    if (self = [super init]) {
        _parameters = [[NSMutableDictionary alloc] initWithCapacity:4];
    }
    return self;
}

+ (XHttpParameters *)parameters
{
    return [[XHttpParameters alloc] init];
}

- (void)appendParameterWithName:(NSString *)name andStringValue:(NSString *)value
{
    [self.parameters setValue:value forKey:name];
}
-(void)appendParameterWithName:(NSString *)name andDataValue:(NSData *)data
{
    [self.parameters setObject:data forKey:name];
}

- (void)appendParameterWithName:(NSString *)name andIntValue:(int)value
{
    [self appendParameterWithName:name andStringValue:[NSString stringWithFormat:@"%i",value]];
}

- (void)appendParameterWithName:(NSString *)name andLongValue:(long)value
{
    [self appendParameterWithName:name andStringValue:[NSString stringWithFormat:@"%ld",value]];
}

- (void)appendParameterWithName:(NSString *)name andLongLongValue:(long long)value
{
    [self appendParameterWithName:name andStringValue:[NSString stringWithFormat:@"%lld",value]];
}
@end
