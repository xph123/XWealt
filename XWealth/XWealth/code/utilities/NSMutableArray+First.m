//
//  NSMutableArray+First.m
//  Link
//
//  Created by yi.chen on 14-7-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "NSMutableArray+First.h"

@implementation NSMutableArray (First)

- (void)bringObjectToIndexOne:(id)object
{
    NSMutableArray *array = [NSMutableArray array];
    if ([self containsObject:object]) {
        [array addObject:object];
    }
    [self removeObject:object];
    for (int i = 0; i < self.count; i++) {
        [array addObject:self[i]];
    }
    [self removeAllObjects];
    [self addObjectsFromArray:array];
}

@end
