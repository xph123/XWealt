//
//  SJAvatarBrowser.m
//  Link
//
//  Created by yi.chen on 14-8-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "SJAvatarBrowser.h"
//#import "UIImageView+WebCache.h"

static CGFloat lastScale;
static CGRect oldframe;

@implementation SJAvatarBrowser
+ (void)showImage:(UIImageView *)avatarImageView
{
    lastScale = 1.0;
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 100;
    imageView.userInteractionEnabled = YES;
    
//    UIView *backImageView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//    backImageView.backgroundColor=[UIColor blackColor];
//    backImageView.alpha=0;
    
//    [backImageView addSubview:imageView];
//    [backgroundView addSubview:backImageView];
    [window addSubview:imageView];
    window.backgroundColor = [UIColor blackColor];
    //点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    //放大缩小
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
    //[pinchRecognizer setDelegate:self];
    [imageView addGestureRecognizer:pinchRecognizer];
    //滑动
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [imageView addGestureRecognizer:panGestureRecognizer];
    
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
        imageView.frame=CGRectMake(x, y, bigSize.width, bigSize.height);
        //backImageView.alpha=1;
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

+ (void)showImage:(UIImageView *)avatarImageView bigImageUrl:(NSString *)bigImageUrl
{
    lastScale = 1.0;
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor blackColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.tag = 100;
    imageView.userInteractionEnabled = YES;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(screenWidth/2, screenHeight/2);
    [indicator startAnimating];
    [backgroundView addSubview:indicator];
    
//    DownloadImageSuccessBlock sucess = ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//        [indicator stopAnimating];
//        [indicator removeFromSuperview];
//    };
//    DonwloadIageFailureBlock fail = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        [indicator stopAnimating];
//        [indicator removeFromSuperview];
//    };
    
//    [imageView setImageWithURL:[NSURL URLWithString:bigImageUrl] placeholderImage:image success:sucess failure:fail];
    [imageView sd_setImageWithURL:[NSURL URLWithString:bigImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }];
//    [imageView setImageWithURL:[NSURL URLWithString:bigImageUrl] placeholderImage:image success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        [indicator stopAnimating];
//        [indicator removeFromSuperview];
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        [indicator stopAnimating];
//        [indicator removeFromSuperview];
//    }];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:bigImageUrl] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [indicator stopAnimating];
//        [indicator removeFromSuperview];
//    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
    //[pinchRecognizer setDelegate:self];
    [imageView addGestureRecognizer:pinchRecognizer];
    
    
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
        imageView.frame=CGRectMake(x, y, bigSize.width, bigSize.height);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}





+ (void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

+ (void)scaGesture:(UIPinchGestureRecognizer *)sender
{
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer *)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer *)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[(UIPinchGestureRecognizer *)sender view]setTransform:newTransform];
    lastScale = [(UIPinchGestureRecognizer *)sender scale];
}

+ (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:[recognizer view]];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:[recognizer view]];
}


@end