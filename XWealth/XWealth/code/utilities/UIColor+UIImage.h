//
//  UIColor+UIImage.h
//  Link
//
//  Created by yi.chen on 14-5-29.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIImage)

- (UIImage *)translateIntoImage;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
