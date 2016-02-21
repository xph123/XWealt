//
//  XLocalImageCache.m
//  Link
//
//  Created by chx on 14-11-21.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XLocalImageCache.h"

@implementation XLocalImageCache

// 临时保存的文件名（包括路径
+ (NSString *) tempSaveImageName
{
    int i = 1;
    NSString *path;
    
    do {
        path = [NSString stringWithFormat:@"%@/IMAGE_%04d.jpg", kAppDelegate.imageFolder, i++];
    } while ([[NSFileManager defaultManager] fileExistsAtPath:path]);

    return path;
}

// yi.chen 加入本地缓存
+(NSString* )localImageCacheDirectory:(NSString *)dirName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:dirName];
}

//创建缓存文件夹
+(BOOL) createLocalImageCacheDirectory:(NSString *)dirName
{
    NSString *imageDir = [self localImageCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

// 删除图片缓存
+ (BOOL) deleteLocalImageCacheDirectory:(NSString *)dirName
{
    NSString *imageDir = [self localImageCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:imageDir error:nil];
    }
    
    return isDeleted;
}

// 删除缓存中的某张图片
+ (BOOL) deleteLocalImage:(NSString *)directoryPath imageName:(NSString *)imageName
{
    NSString *imageDir = [self localImageCacheDirectory:directoryPath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        NSString *imagePath = [directoryPath stringByAppendingPathComponent : imageName];
        
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (fileExisted) {
            isDeleted = [fileManager removeItemAtPath:imagePath error:nil];
        }
    }
    
    return isDeleted;
}


// 图片本地缓存
+ (BOOL) saveImageToCache:(NSString *)directoryPath  image:(UIImage *)image imageName:(NSString *)imageName imageType:(NSString *)imageType
{
    imageName = [imageName md5];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    bool isSaved = false;
    if ( isDir == YES && existed == YES )
    {
        if ([[imageType lowercaseString] isEqualToString:@"png"])
        {
            //            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
            isSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
        }
        else if ([[imageType lowercaseString] isEqualToString:@"jpg"] || [[imageType lowercaseString] isEqualToString:@"jpeg"])
        {
            //            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
        }
        else
        {
            NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", imageType);
        }
    }
    return isSaved;
}

// 获取缓存图片
+(NSData*) loadImageData:(NSString *)directoryPath imageName:( NSString *)imageName
{
    imageName = [imageName md5];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *imagePath = [directoryPath stringByAppendingPathComponent : imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : imagePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}
// ---
@end
