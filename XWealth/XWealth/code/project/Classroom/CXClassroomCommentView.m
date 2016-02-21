//
//  CXClassroomCommentView.m
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomCommentView.h"

@implementation CXClassroomCommentView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kTabBarColor;
        self.clipsToBounds=YES;
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    
    CGFloat width = 100;
    // 评论
    _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - kDefaultMargin - width, kSmallMargin, width, kFunctionBarHeight - 2 * kSmallMargin)];
    [_commentsButton setBackgroundColor:[UIColor clearColor]];
    [_commentsButton setTitle: @"0" forState: UIControlStateNormal];
    _commentsButton.titleLabel.font = kMiddleTextFont;
    [_commentsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_commentsButton setImage:[UIImage imageNamed:@"information_number"] forState:UIControlStateNormal];
    [_commentsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _commentsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_commentsButton addTarget:self action:@selector(viewNumberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _commentsButton];
    
    
    _goodsButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2 + kDefaultMargin, kSmallMargin, width, kFunctionBarHeight - 2 * kSmallMargin)];
    [_goodsButton setBackgroundColor:[UIColor clearColor]];
    [_goodsButton setTitle: @"0" forState: UIControlStateNormal];
    _goodsButton.titleLabel.font = kMiddleTextFont;
    [_goodsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_goodsButton setImage:[UIImage imageNamed:@"information_good"] forState:UIControlStateNormal];
    [_goodsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _goodsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_goodsButton addTarget:self action:@selector(favorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _goodsButton];
    
}

- (void) setComments:(NSInteger) comments
{
    NSString *str = [NSString stringWithFormat:@"%ld", comments];
    [_commentsButton setTitle: str forState: UIControlStateNormal];
}

- (void) setGoods:(NSInteger) goods
{
    NSString *str = [NSString stringWithFormat:@"%ld", goods];
    [_goodsButton setTitle: str forState: UIControlStateNormal];
}

- (void)viewNumberBtnClick:(UIButton *)button
{
    if (self.viewNumberBlk) {
        self.viewNumberBlk();
    }
}

- (void)favorBtnClick:(UIButton *)button
{
    if (self.favorBlk) {
        self.favorBlk();
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
