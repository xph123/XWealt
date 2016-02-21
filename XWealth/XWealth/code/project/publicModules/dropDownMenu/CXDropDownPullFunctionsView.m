//
//  CXDropDownPullFunctionsView.m
//  XWealth
//
//  Created by gsycf on 15/9/11.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXDropDownPullFunctionsView.h"
#import "CXDropDownPullFunctionsCell.h"
@implementation CXDropDownPullFunctionsView
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
        
        CGFloat x = kScreenWidth - kDefaultMargin - kPullFunctionViewWidth;
        self.frame = CGRectMake(x, kNavAndStatusBarHeight, kPullFunctionViewWidth, kExtMenuHeight*_functionTitles.count+kMiddleMargin);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = kRadius;
        
        
        self.backView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kPullFunctionViewWidth, kExtMenuHeight*_functionTitles.count+kMiddleMargin)];
        _backView.image=[UIImage imageNamed:@"category_drop"];
        [self addSubview:self.backView];
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kMiddleMargin, kPullFunctionViewWidth, kExtMenuHeight*_functionTitles.count) style:UITableViewStylePlain];
        
        [tableView setSeparatorColor:[UIColor clearColor]];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor clearColor];
//        tableView.alpha=0.5;
        [self addSubview:tableView];
        self.tableView = tableView;
        
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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
    
    CXDropDownPullFunctionsCell *cell = [tableView dequeueReusableCellWithIdentifier:PullFunctionsCellIdentifier];
    if (cell == nil) {
        cell = [[CXDropDownPullFunctionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PullFunctionsCellIdentifier];
    }
    cell.title.textColor=kDropDownColor;
    cell.backgroundColor = [UIColor clearColor];
    cell.icon.image = [UIImage imageNamed:_functionIcons[indexPath.row]];
    cell.title.text = _functionTitles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [_overlayView removeFromSuperview];
    
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
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    [self fadeIn];
}

- (void)dismiss
{
    [self.delegate didBackgroundTap];
    [self fadeOut];
}


@end
