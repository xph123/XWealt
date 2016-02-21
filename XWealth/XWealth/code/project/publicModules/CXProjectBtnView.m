//
//  CXProjectBtnView.m
//  XWealth
//
//  Created by chx on 15/7/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProjectBtnView.h"

@implementation CXProjectBtnView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[XMenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
    }
    return self;
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.menuButton.isActive) {
        NSLog(@"On show");
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}

- (void)onShowMenu
{
    //    if (!self.selectView)
    {
        self.selectView = [[CXProjectSelectView alloc] initWithProjects:self.items];
        self.selectView.delegate = self;
    }
    
    [self rotateArrow:M_PI];
    [self.selectView show];
}

- (void)onHideMenu
{
//    [self rotateArrow:0];
    [self.selectView dismiss];
}

//- (void)onChangeArrorTap:(id)sender
//{
//    if (self.menuButton.isActive) {
//        [self rotateArrow:M_PI];
//    } else {
//        NSLog(@"On hide");
//        [self rotateArrow:0];
//    }
//}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods

- (void)projectSelectView:(CXProjectSelectView *)projectSelectView didSelectIndex:(NSInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didNavMenuSelectItemAtIndex:index];

}

//- (void)didSelectItemAtIndex:(NSUInteger)index
//{
//    self.menuButton.isActive = !self.menuButton.isActive;
//    [self onHandleMenuTap:nil];
//    [self.delegate didNavMenuSelectItemAtIndex:index];
//}

- (void)didBackgroundTap
{
    self.menuButton.isActive = 0;
//    self.menuButton.isActive = !self.menuButton.isActive;
    [self rotateArrow:0];
}


@end
