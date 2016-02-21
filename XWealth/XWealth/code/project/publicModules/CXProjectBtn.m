//
//  CXProjectBtn.m
//  XWealth
//
//  Created by gsycf on 15/8/13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProjectBtn.h"

@implementation CXProjectBtn
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.x = 0;
        self.menuRightButton = [[XMenuRightBtton alloc] initWithFrame:frame];
        self.menuRightButton.title.text = title;
        [self.menuRightButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuRightButton];
    }
    return self;
}

#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.menuRightButton.isActive) {
        NSLog(@"On show");
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}

- (void)onShowMenu
{
    {
        
        self.selectTableView=[[CXPullFunctionsView alloc]initWithIcons:nil andTitles:self.items];
        self.selectTableView.delegate=self;
        self.menuRightButton.title.textColor = KReleaseButtonColor;
    }
    [self.selectTableView show];
}

- (void)onHideMenu
{
    [self.selectTableView dismiss];
    self.menuRightButton.title.textColor = kTextColor;
}



#pragma mark -
#pragma mark Delegate methods

- (void)pullFunctionsView:(CXPullFunctionsView *)pullFunctionsView didSelectClassName:(NSString *)className
{
    self.menuRightButton.isActive = !self.menuRightButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didNavMenSelectTableAtName:className];
}


- (void)didBackgroundTap
{
    self.menuRightButton.isActive = 0;
    self.menuRightButton.title.textColor = kTextColor;
}


@end
