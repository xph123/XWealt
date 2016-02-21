//
//  CXPopActivityView.m
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXPopActivityView.h"

@implementation CXPopActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithActivityModel:(CXPopActivityModel*)activityModel
{
    self = [super init];
    
    if (self)
    {
        CGFloat width = kScreenWidth - 60;
        CGFloat height = width * 3 / 4 + kFunctionBarHeight;
        CGFloat y = (kScreenHeight - height) / 2;
        CGRect popFrame = CGRectMake(30, y, width, height);
        self.frame = popFrame;
        self.layer.masksToBounds = YES;
        self.backgroundColor = kColorClear;
//        self.layer.cornerRadius = 10;
        
        // Initialization code
        self.activityModel = activityModel;
        
        CGRect imgFrame = CGRectMake(0, 0, self.frame.size.width, height - kFunctionBarHeight);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.backgroundColor = kColorClear;
        imgView.clipsToBounds  = YES;
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.activityModel.imageUrl] placeholderImage:[UIImage imageNamed:@"defaule_image1"]];
        //_imgView.layer.cornerRadius = kRadius;
        [self addSubview:imgView];
        
        CGRect btnFrame = CGRectMake(0, self.frame.size.height-kFunctionBarHeight, self.frame.size.width, kFunctionBarHeight);
        UIButton *activityButton = [[UIButton alloc] initWithFrame:btnFrame];
        [activityButton setBackgroundColor:kMainStyleColor];
        [activityButton setTitle: self.activityModel.btnText forState: UIControlStateNormal];
        activityButton.titleLabel.font = kMiddleTextFont;
        [activityButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [activityButton addTarget:self action:@selector(activityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: activityButton];
        
        CGRect closeFrame = CGRectMake(self.frame.size.width - 30, 0 , 30, 30);
        UIButton *closeButton = [[UIButton alloc] initWithFrame:closeFrame];
        [closeButton setBackgroundColor:kColorClear];
        [closeButton setImage:IMAGE(@"close") forState: UIControlStateNormal];
        [closeButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: closeButton];

        
        
        CGRect UpOverlayViewFrame=self.frame;
        UpOverlayViewFrame.origin.x=0;
        UpOverlayViewFrame.origin.y=0;
        UpOverlayViewFrame.size.width=kScreenWidth;
        UpOverlayViewFrame.size.height=kStatusBarHeight+kNavigationBarHeight+kButtonHeight;
        
        _UpOverlayView = [[UIControl alloc] initWithFrame: UpOverlayViewFrame];
        _UpOverlayView.alpha = 0.1f;
        [_UpOverlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect overlayViewFrame=self.frame;
        overlayViewFrame.origin.x=0;
        overlayViewFrame.origin.y=kNavAndStatusBarHeight+kButtonHeight;
        overlayViewFrame.size.width=kScreenWidth;
        overlayViewFrame.size.height=kScreenHeight-kNavAndStatusBarHeight-kButtonHeight;
        
        _overlayView = [[UIControl alloc] initWithFrame: overlayViewFrame];
        _overlayView.backgroundColor = kColorBlack;
        _overlayView.alpha = 0.1;
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)activityBtnClick:(UIButton *)button
{
    if (self.actionBlk) {
        self.actionBlk();
    }
}

#pragma mark - show & hide
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(.6, .6);
    self.alpha = 0;
    self.center = CGPointMake(self.center.x, self.center.y-20);
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1;
        self.center = CGPointMake(self.center.x, self.center.y+20);
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.alpha = 0.0;
        self.center = CGPointMake(self.center.x, self.center.y-20);
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            _overlayView = nil;
            [_UpOverlayView removeFromSuperview];
            _UpOverlayView = nil;
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:_UpOverlayView];
    [keywindow addSubview:self];
    
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}


@end
