//
//  CXPopWindowViewController.m
//  XWealth
//
//  Created by gsycf on 16/1/8.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import "CXPopWindowViewController.h"

@interface CXPopWindowViewController ()

@end

@implementation CXPopWindowViewController
- (id)initWithImageName:(NSString*)ImageName
{
    self = [super init];
    
    if (self)
    {
        CGFloat width = kScreenWidth - 60;
        CGFloat height = width*1.375;
        CGFloat y = (kScreenHeight - height) / 2;
        CGRect popFrame = CGRectMake(30, y, width, height);
        self.view.frame = popFrame;
        self.view.layer.masksToBounds = YES;
        self.view.backgroundColor = kColorClear;
        //        self.layer.cornerRadius = 10;
        
        // Initialization code
        
        CGRect imgFrame = CGRectMake(0, 0, self.view.frame.size.width, height);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.backgroundColor = kColorClear;
        imgView.clipsToBounds  = YES;
        imgView.image=[UIImage imageNamed:ImageName];
        //_imgView.layer.cornerRadius = kRadius;
        [self.view addSubview:imgView];
        
        
        
        
//        
//        CGRect UpOverlayViewFrame=self.frame;
//        UpOverlayViewFrame.origin.x=0;
//        UpOverlayViewFrame.origin.y=0;
//        UpOverlayViewFrame.size.width=kScreenWidth;
//        UpOverlayViewFrame.size.height=kStatusBarHeight+kNavigationBarHeight+kButtonHeight;
//        
//        _UpOverlayView = [[UIControl alloc] initWithFrame: UpOverlayViewFrame];
//        _UpOverlayView.alpha = 0.1f;
//        [_UpOverlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//        
//        CGRect overlayViewFrame=self.frame;
//        overlayViewFrame.origin.x=0;
//        overlayViewFrame.origin.y=kNavAndStatusBarHeight+kButtonHeight;
//        overlayViewFrame.size.width=kScreenWidth;
//        overlayViewFrame.size.height=kScreenHeight-kNavAndStatusBarHeight-kButtonHeight;
//        
//        _overlayView = [[UIControl alloc] initWithFrame: overlayViewFrame];
//        _overlayView.backgroundColor = kColorBlack;
//        _overlayView.alpha = 0.1;
//        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}


@end
