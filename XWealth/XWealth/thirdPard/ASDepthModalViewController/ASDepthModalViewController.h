//
//  ASDepthModalViewController.h
//  Link
//
//  Created by yi.chen on 14-7-21.
//  Copyright (c) 2014年 rasc. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum
{
    ASDepthModalAnimationGrow = 0,
    ASDepthModalAnimationShrink,
    ASDepthModalAnimationNone,
    ASDepthModalAnimationDefault = ASDepthModalAnimationGrow,
} ASDepthModalAnimationStyle;

/*
Mostly inspired by http://lab.hakim.se/avgrund/
*/
@interface ASDepthModalViewController : UIViewController

+ (void)presentView:(UIView *)view withBackgroundColor:(UIColor *)color popupAnimationStyle:(ASDepthModalAnimationStyle)popupAnimationStyle;
+ (void)presentView:(UIView *)view;
+ (void)dismiss;

@end
