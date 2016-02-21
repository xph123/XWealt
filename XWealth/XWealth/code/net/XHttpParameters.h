//
//  CSHttpParaments.h
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHttpParameters : NSObject

@property (strong, nonatomic) NSMutableDictionary *parameters;

+ (XHttpParameters *)parameters;

- (void)appendParameterWithName:(NSString *)name andStringValue:(NSString *)value;
- (void)appendParameterWithName:(NSString *)name andIntValue:(int)value;
- (void)appendParameterWithName:(NSString *)name andLongValue:(long)value;
- (void)appendParameterWithName:(NSString *)name andLongLongValue:(long long)value;
-(void)appendParameterWithName:(NSString *)name andDataValue:(NSData *)data;

@end
