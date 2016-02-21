//
//  CSNavigationMenuView.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XNavigationMenuView.h"
#import "XMenuTable.h"

@interface XNavigationMenuView  ()
@property (nonatomic, strong) XGridView *table;
@property (nonatomic, strong) UIView *menuContainer;
@end


@implementation XNavigationMenuView

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

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;

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
    if (!self.table)
    {
        CGRect frame = self.menuContainer.frame;
        frame.origin.y += kNavAndStatusBarHeight;
        self.table = [[XGridView alloc] initWithFrame:frame items:self.items];
        self.table.menuDelegate = self;
    }
    else if (self.resetting == 1)
    {
        self.table.projectList = self.items;
        self.resetting = 0;
        [self.table reloadData];
    }
    
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    [self.table show];
}

- (void)onHideMenu
{
    [self rotateArrow:0];
    [self.table hide];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didNavMenuSelectItemAtIndex:index];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    
    int index = rowIndex * 3 + colIndex;
    [self.delegate didNavMenuSelectItemAtIndex:index];
}

@end
