//
//  PullUpLoadMoreView.m
//  Link
//
//  Created by wangqi on 14-9-19.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import "PullUpLoadMoreView.h"
#import "Constants.h"
#import "UIColor+UIImage.h"

#define FontSize    15
#define TextColor   kGetColor(180, 180, 180)

@implementation PullUpLoadMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, frame.size.height)];
        statusLabel.textColor = kTextColor;
        statusLabel.backgroundColor = kControlBgColor;
        statusLabel.font = kMiddleTextFont;
        statusLabel.numberOfLines = 2;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:statusLabel];
        _statusLabel = statusLabel;

//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
//        [button setTitleColor:kTextColor forState:UIControlStateNormal];
//        button.backgroundColor = kControlBgColor;
//        [button addTarget:self action:@selector(clickToLoadMore:) forControlEvents:UIControlEventTouchUpInside];
//		[self addSubview:button];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        button.backgroundColor = kColorClear;
        [button addTarget:self action:@selector(clickToLoadMore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
		_statusBtn = button;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.center = CGPointMake(frame.size.width/2-60, frame.size.height/2);
		[self addSubview:view];
		_activityView = view;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        iv.image = IMAGE(@"reloading");
        iv.center = _activityView.center;
        [self addSubview:iv];
        _refreshView = iv;
        
        self.state = LoadMoreStateIsLoading;
        
    }
    return self;
}

- (void)clickToLoadMore:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(loadMore)]) {
        [_delegate loadMore];
    }
}

- (void)setState:(LoadMoreState)aState
{
	switch (aState) {
        case LoadMoreStateIsLoading:
            _statusLabel.text = NSLocalizedString(@"正在加载 . . .", nil);
//            [_statusBtn setTitle:NSLocalizedString(@"正在加载 . . .", nil) forState:UIControlStateNormal];
            _refreshView.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            
            break;
            
        case LoadMoreStateComplete://加载完成
            _statusLabel.text = NSLocalizedString(@"", nil);
//            [_statusBtn setTitle:NSLocalizedString(@"", nil) forState:UIControlStateNormal];
            _statusBtn.userInteractionEnabled = NO;
            _refreshView.hidden = YES;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
//            [self removeFromSuperview];
            
            break;

        case LoadMoreStateNormal:
            _statusLabel.text = NSLocalizedString(@"加载更多", nil);
//            [_statusBtn setTitle:NSLocalizedString(@"加载更多", nil) forState:UIControlStateNormal];
            _refreshView.hidden = YES;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            break;
            
        case LoadMoreStateFail:
            _statusLabel.text = NSLocalizedString(@"加载失败", nil);
//            [_statusBtn setTitle:NSLocalizedString(@"加载失败", nil) forState:UIControlStateNormal];
            _refreshView.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            break;
            
        case LoadMoreStateNoData:
            _statusLabel.text = _noData;
//            [_statusBtn setTitle:_noData forState:UIControlStateNormal];
            _refreshView.hidden = YES;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            break;

        default:
            break;
    }
	_state = aState;
}

- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == LoadMoreStateComplete) {
        return;
    }

    if (fabs(fabs(scrollView.contentOffset.y) - scrollView.contentSize.height + scrollView.frame.size.height) <= 1) {
        if (_state != LoadMoreStateIsLoading) {
            if (_delegate && [_delegate respondsToSelector:@selector(loadMore)]) {
                [_delegate loadMore];
            }
        }
    }
}

- (void)updateWithCurrentLoadCount:(NSInteger)currentLoadCount
                    totalLoadCount:(NSInteger)totalLoadCount
                          pageSize:(NSString *)pageSize
{
    if (currentLoadCount == 0) {
        if (totalLoadCount == 0) {
            self.state = LoadMoreStateNoData;
        }
        else {
            self.state = LoadMoreStateComplete;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(updateDelegateView)]) {
            [_delegate updateDelegateView];
        }
    }
    else {
        if (currentLoadCount < [pageSize integerValue]) {
            self.state = LoadMoreStateComplete;
        }
        else{
            self.state = LoadMoreStateNormal;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(updateDelegateView)]) {
            [_delegate updateDelegateView];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
