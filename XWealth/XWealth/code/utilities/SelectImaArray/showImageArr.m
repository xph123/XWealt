//
//  showImageArr.m
//  XWealth
//
//  Created by gsycf on 15/9/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "showImageArr.h"

@implementation showImageArr
{
    UIImageView *_imageView;
    UIView *_backImageView;
    UIScrollView *_backScrollerView;
}
static CGFloat lastScale;
static CGRect oldframe;
-(instancetype)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}
- (void)showImageArray:(NSMutableArray *)ImageArray andImage:(UIImageView*)avatarImageView;
{
    lastScale = 1.0;
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    self.backgroundColor = [UIColor blackColor];
    self.userInteractionEnabled=YES;
    self.alpha = 0;
    
    _backScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    //backScrollerView.contentSize=CGSizeMake(screenWidth,screenHeight);
    _backScrollerView.showsHorizontalScrollIndicator=NO;
    _backScrollerView.showsVerticalScrollIndicator=NO;
    _backScrollerView.minimumZoomScale=1.0f;
    _backScrollerView.maximumZoomScale=5.0f;
    _backScrollerView.bounces=NO;
    _backScrollerView.delegate=self;
    
    _backImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _backImageView.userInteractionEnabled = YES;
    
    
    _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _imageView.image = image;
    _imageView.tag = 100;
    _imageView.userInteractionEnabled = YES;
    
    [_backImageView addSubview:_imageView];
    [_backScrollerView addSubview:_backImageView];
    [self addSubview:_backScrollerView];
    [window addSubview:self];
    window.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [self addGestureRecognizer:tap];
    
    CGSize bigSize;
    CGSize smallSize = image.size;
    CGFloat scale = smallSize.width/smallSize.height;
    CGFloat x, y;
    if (scale > screenWidth / screenHeight) {
        bigSize = CGSizeMake(screenWidth, screenWidth*smallSize.height/smallSize.width);
        x = 0;
        y = (screenHeight - bigSize.height) / 2;
    }
    else {
        bigSize = CGSizeMake(screenHeight*smallSize.width/smallSize.height, screenHeight);
        x = (screenWidth- bigSize.width) / 2;
        y = (screenHeight - bigSize.height) / 2;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        _imageView.frame=CGRectMake(x, y, bigSize.width, bigSize.height);
        self.alpha = 1;
       
    } completion:^(BOOL finished) {
         [[UIApplication sharedApplication] setStatusBarHidden:YES ];
    }];
    
}
- (void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:100];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=oldframe;
        backgroundView.alpha=0;
        
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        
       
    }];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _backImageView;
}

@end
