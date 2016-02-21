//
//  CXPullFunctionsView.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXPullFunctionsView.h"
#import "CXPullFunctionsCell.h"


@implementation CXPullFunctionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithIcons:(NSArray *)functionIcons andTitles:(NSArray*)functionTitles
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _functionIcons = functionIcons;
        _functionTitles = functionTitles;
        
        CGFloat x = 0;
        NSLog(@"%f",self.frame.origin.y);
        self.frame = CGRectMake(x, kNavAndStatusBarHeight+kButtonHeight, kScreenWidth, kExtMenuHeight*_functionTitles.count);
        self.layer.masksToBounds = YES;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, self.frame.size.width, kExtMenuHeight*_functionTitles.count) style:UITableViewStylePlain];
        [tableView setSeparatorColor:kControlBgColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        self.tableView = tableView;
        
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
        _overlayView.alpha = 0.2;
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _functionTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PullFunctionsCellIdentifier = @"PullFunctionsCellIdentifier";
    
    CXPullFunctionsCell *cell = [tableView dequeueReusableCellWithIdentifier:PullFunctionsCellIdentifier];
    if (cell == nil) {
        cell = [[CXPullFunctionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PullFunctionsCellIdentifier];
    }
    //cell.title.textColor=kTextColor;
    cell.icon.image = _functionIcons[indexPath.row];
    cell.title.text = _functionTitles[indexPath.row];
    if ([cell.title.text isEqualToString:self.selectStr]) {
        cell.title.textColor=KReleaseButtonColor;
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [_overlayView removeFromSuperview];
    [_UpOverlayView removeFromSuperview];
    
    if (_delegate && _delegate != nil)
    {
        if ([_delegate respondsToSelector:@selector(pullFunctionsView:didSelectIndex:)])
        {
            [_delegate pullFunctionsView:self didSelectIndex:indexPath.row];
        }
    }
    [self.delegate didBackgroundTap];
}

#pragma mark - show & hide

- (void)fadeIn
{
//    NSLog(@"%f,%f,%f,%f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
//    self.transform=CGAffineTransformMakeTranslation(0, -(self.frame.origin.y+self.frame.size.height));
//    self.alpha = 0;
//    self.center = CGPointMake(self.center.x, self.center.y-20);

    self.transform = CGAffineTransformMakeScale(.6, .6);
    self.alpha = 0;
    self.center = CGPointMake(self.center.x, self.center.y-20);
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.transform=CGAffineTransformMakeTranslation(0, 0);
//    } completion:^(BOOL finished) {
//        
//    }];
     [UIView animateWithDuration:.25 animations:^{
//        self.alpha = 1;
//        self.center = CGPointMake(self.center.x, self.center.y+20);
//        self.transform=CGAffineTransformMakeTranslation(0, 0);
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
    [self.delegate didBackgroundTap];
    [self fadeOut];
}


@end
