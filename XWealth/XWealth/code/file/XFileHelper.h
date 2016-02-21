//
//  XFileHelper.h
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFileHelper : NSObject

+ (id)sharedFileHelper;

+ (void)saveFile:(NSString *)filePath andFileName:(NSString *)fileName andData:(NSData *)fileData;
+ (void)deleteFile:(NSString *)filePath andFileName:(NSString *)fileName;
+ (NSData *)dataWithFileName:(NSString *)filePath andFileName:(NSString *)fileName;

@end
