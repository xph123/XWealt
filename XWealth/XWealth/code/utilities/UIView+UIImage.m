//
//  UIView+UIImage.m
//  Link
//
//  Created by yi.chen on 14-10-13.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "UIView+UIImage.h"

@implementation UIView (UIImage)

+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
