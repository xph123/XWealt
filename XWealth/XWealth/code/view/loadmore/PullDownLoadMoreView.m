//
//  PullDownLoadMoreView.m
//  Link
//
//  Created by wangqi on 14-9-20.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import "PullDownLoadMoreView.h"
#import "Constants.h"
#import "UIColor+UIImage.h"

#define FontSize    15
#define TextColor   kGetColor(180, 180, 180)

@implementation PullDownLoadMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIImage *image = [kGetColor(236, 236, 236) translateIntoImage];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [button setTitleColor:kTextColor forState:UIControlStateNormal];
//        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        button.backgroundColor = kControlBgColor;
        [button addTarget:self action:@selector(clickToLoadMore:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
		_statusBtn = button;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.center = CGPointMake(80, frame.size.height/2);
		[self addSubview:view];
		_activityView = view;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        iv.image = IMAGE(@"reloading");
        iv.center = _activityView.center;
        [self addSubview:iv];
        _refreshView = iv;
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
            [_statusBtn setTitle:NSLocalizedString(@"正在更新 . . .", nil) forState:UIControlStateNormal];
            _refreshView.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            
            break;
            
        case LoadMoreStateComplete:
            [_statusBtn setTitle:NSLocalizedString(@"更新完成", nil) forState:UIControlStateNormal];
            _statusBtn.userInteractionEnabled = NO;
            _refreshView.hidden = YES;
            _activityView.hidden = YES;
            [_activityView stopAnimating];


            
            
            break;
            
        case LoadMoreStateNormal:
            [_statusBtn setTitle:NSLocalizedString(@"准备更新", nil) forState:UIControlStateNormal];
            _refreshView.hidden = YES;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            break;
            
        case LoadMoreStateFail:
            [_statusBtn setTitle:NSLocalizedString(@"更新失败", nil) forState:UIControlStateNormal];
            _refreshView.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            break;
            
        case LoadMoreStateNoData:
            [_statusBtn setTitle:_noData forState:UIControlStateNormal];
            _statusBtn.userInteractionEnabled = NO;
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
//    if (_state == LoadMoreStateComplete) {
//        return;
//    }
    if ((NSInteger)scrollView.contentOffset.y == 0) {
        if (_state != LoadMoreStateIsLoading) {
            if (_delegate && [_delegate respondsToSelector:@selector(loadMore)]) {
                [_delegate loadMore];
            }
        }
    }
}

- (void)updateWithCurrentPage:(NSString *)currentPage
{
    if ([currentPage isEqualToString:@"0"]) {  
        self.state = LoadMoreStateNoData;
    }
    else  {
        if ([currentPage isEqualToString:@"1"]) {
            self.state = LoadMoreStateComplete;
        }
        else {
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
