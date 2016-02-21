//
//  UDCustomNavigation.m
//  XWealth
//
//  Created by gsycf on 15/11/18.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "UDCustomNavigation.h"

@interface UDCustomNavigation ()

@end

@implementation UDCustomNavigation
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self=[super initWithRootViewController:rootViewController];
    if (self) {
        CGRect frame = self.navigationBar.frame;
        self.alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        self.alphaView.backgroundColor = kNavigationBarColor;
        [self.view insertSubview:self.alphaView belowSubview:self.navigationBar];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
        self.navigationBar.layer.masksToBounds = YES;

        //[self.navigationItem setHidesBackButton:YES];
        
        
      

//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];


    }
    return self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];

    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0,60, 40);
    
    [btn setImage:[UIImage imageNamed:@"list_white_left"] forState:UIControlStateNormal];
    //btn.backgroundColor=[UIColor blueColor];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets= UIEdgeInsetsMake(0, -3, 0, 0);
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
    viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
}
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:YES];
}
-(void)setAlpha:(BOOL)state andAnimation:(BOOL)AnimationState
{
    if (AnimationState) {
        if (state) {
            [UIView animateWithDuration:1 animations:^{
                self.alphaView.alpha = 0.0;
            } completion:^(BOOL finished) {
                
            }];
            
        }
        else
        {
            self.view.backgroundColor=kNavigationBarColor;
            [UIView animateWithDuration:1 animations:^{
                self.alphaView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
            
        }

    }
    else
    {
        if (state) {
                self.alphaView.alpha = 0.0;
        }
        else
        {
                self.alphaView.alpha = 1.0;
            
        }
    }
    
}
-(void)setRecoverySystemStyle:(BOOL)state
{
    if (state) {
        self.view.backgroundColor=kNavigationBarColor;
        self.navigationBar.alpha = 1.0;
       
    }
    else
    {
        
    }


}



@end
