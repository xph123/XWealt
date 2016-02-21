//
//  XLocalImageCache.h
//  Link
//
//  Created by chx on 14-11-21.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDirectoryOfImage           @"ImageCache" // 图片缓存的位置

@interface XLocalImageCache : NSObject

// 临时保存的文件名（包括路径
+ (NSString *) tempSaveImageName;

// 本地缓存路径
+(NSString* )localImageCacheDirectory:(NSString *)dirName;

//创建缓存文件夹
+(BOOL) createLocalImageCacheDirectory:(NSString *)dirName;

// 删除图片缓存
+ (BOOL) deleteLocalImageCacheDirectory:(NSString *)dirName;

// 删除缓存中的某张图片
+ (BOOL) deleteLocalImage:(NSString *)directoryPath imageName:(NSString *)imageName;

// 图片本地缓存
+ (BOOL) saveImageToCache:(NSString *)directoryPath  image:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType;

// 获取缓存图片
+(NSData*) loadImageData:(NSString *)directoryPath imageName:( NSString *)imageName;

@end
