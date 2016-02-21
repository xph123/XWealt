//
//  XFileValue.h
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFileValue : NSObject

- (id) initWithFileName:(NSString*) fileName;

- (NSString *)valueForKey:(NSString *)key;
- (void)setValue:(id)anObject forKey:(NSString *)key;

@property (nonatomic, strong) NSString *fileName;

@end
