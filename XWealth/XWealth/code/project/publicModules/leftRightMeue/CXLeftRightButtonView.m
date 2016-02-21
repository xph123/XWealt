//
//  CXLeftRightButtonView.m
//  XWealth
//
//  Created by gsycf on 15/10/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXLeftRightButtonView.h"

@implementation CXLeftRightButtonView
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.x = 0;
        frame.origin.y += 1.0;
        self.classroomButton = [[CXLeftRightButton alloc] initWithFrame:frame];
        self.classroomButton.title.text = title;
        [self.classroomButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.classroomButton];
    }
    return self;
}

#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.classroomButton.isActive) {
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
        //self.selectTableView.btnHight=self.classroomButton.frame.origin.y;
        self.selectTableView.delegate=self;
        self.selectTableView.selectStr= self.classroomButton.title.text;
        self.classroomButton.title.textColor = KReleaseButtonColor;
        //        [self addSubview:self.selectTableView];
    }
    [_classroomButton layoutSubviews];
    self.classroomButton.arrow.image=[UIImage imageNamed:@"minArrow_up.png"];
    [self.selectTableView show];
}
- (void)onHideMenu
{
    [self.selectTableView dismiss];
    self.classroomButton.title.textColor = kTextColor;
}


#pragma mark Delegate methods

- (void)pullFunctionsView:(CXPullFunctionsView *)pullFunctionsView didSelectIndex:(NSInteger)index
{
    [self.delegate didNavMenSelectTableAtIndex:index andBool:self.classroomButton.isActive];
    self.classroomButton.isActive = !self.classroomButton.isActive;
    [self onHandleMenuTap:nil];
    
}


- (void)didBackgroundTap
{
    self.classroomButton.isActive = 0;
    self.classroomButton.title.textColor = kTextColor;
    self.classroomButton.arrow.image=[UIImage imageNamed:@"minArrow_down"];
    [_classroomButton layoutSubviews];
}
-(void)setButtonTitle:(NSString *)title
{
    _classroomButton.title.text=title;
    [_classroomButton layoutSubviews];
}



@end
