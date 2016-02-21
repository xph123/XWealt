//
//  CXDropProjectBtn.m
//  XWealth
//
//  Created by gsycf on 15/9/11.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXDropProjectBtn.h"

@implementation CXDropProjectBtn
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuRightButton = [[XMenuRightBtton alloc] initWithFrame:frame];
        self.menuRightButton.title.font=kMiddleTextFont;
        self.menuRightButton.title.text = title;
        self.menuRightButton.title.textAlignment=NSTextAlignmentRight;
        self.menuRightButton.title.textColor = [UIColor whiteColor];
        [self.menuRightButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuRightButton];
    }
    return self;
}

#pragma mark -
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
    //    if (!self.selectView)
    {
        
        self.selectTableView=[[CXDropDownPullFunctionsView alloc]initWithIcons:self.icons andTitles:self.items];
        self.selectTableView.delegate=self;
    }
    
    [self.selectTableView show];
}

- (void)onHideMenu
{
    //    [self rotateArrow:0];
    [self.selectTableView dismiss];
}



#pragma mark -
#pragma mark Delegate methods
- (void)pullFunctionsView:(CXDropDownPullFunctionsView *)pullFunctionsView didSelectIndex:(NSInteger)index
{
    self.menuRightButton.isActive = !self.menuRightButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didNavMenSelectTableAtIndex:index];
}


//- (void)didSelectItemAtIndex:(NSUInteger)index
//{
//    self.menuButton.isActive = !self.menuButton.isActive;
//    [self onHandleMenuTap:nil];
//    [self.delegate didNavMenuSelectItemAtIndex:index];
//}
- (void)didBackgroundTap
{
    self.menuRightButton.isActive = 0;
    //    self.menuButton.isActive = !self.menuButton.isActive;
}


@end
