//
//  XFileValue.m
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XFileValue.h"

@implementation XFileValue

- (id) initWithFileName:(NSString*) fileName
{
    self = [super init];
    if (self)
    {
        self.fileName = fileName;
    }
    return self;
}


- (NSString *)valueForKey:(NSString *)key
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:self.fileName];
    if(![[dictionary allKeys] containsObject:key])
        return @"";
    if (![dictionary objectForKey:key]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", [dictionary objectForKey:key]];
}

- (void)setValue:(id)anObject forKey:(NSString *)key
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:self.fileName];
    [dictionary setValue:anObject forKey:key];
    [dictionary writeToFile:self.fileName atomically:YES];
}


@end
