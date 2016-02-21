//
//  XFileHelper.m
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XFileHelper.h"

@implementation XFileHelper

+ (id)sharedFileHelper
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedFileHelper = nil;
    dispatch_once(&pred, ^{
        _sharedFileHelper = [[self alloc] init]; // or some other init method
    });
    return _sharedFileHelper;
}

// 如果文件名带路径，则文件路径传入@""
+ (void)saveFile:(NSString *)filePath andFileName:(NSString *)fileName andData:(NSData *)fileData
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    [fileData writeToFile:path atomically:YES];
}

+ (void)deleteFile:(NSString *)filePath andFileName:(NSString *)fileName
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:path error:nil];
}

+ (NSData *)dataWithFileName:(NSString *)filePath andFileName:(NSString *)fileName
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    return [NSData dataWithContentsOfFile:path];
}

@end
