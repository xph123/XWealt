//
//  CXCommentView.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXCommentView.h"

@implementation CXCommentView

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
    
    CGFloat width = (kScreenWidth-4*kDefaultMargin) / 3;
    // 评论
    _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin, kSmallMargin, width, kFunctionBarHeight - 2 * kSmallMargin)];
    [_commentsButton setBackgroundColor:[UIColor clearColor]];
    [_commentsButton setTitle: @"0" forState: UIControlStateNormal];
    _commentsButton.titleLabel.font = kMiddleTextFont;
    [_commentsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_commentsButton setImage:[UIImage imageNamed:@"information_number"] forState:UIControlStateNormal];
    [_commentsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _commentsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_commentsButton addTarget:self action:@selector(viewNumberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _commentsButton];
    
    
    UIImageView *leftIma=[[UIImageView alloc]initWithFrame:CGRectMake(width+kDefaultMargin+kMinSmallMargin, kDefaultMargin, 0.5, kButtomBarHeight - 2 * kDefaultMargin)];
    leftIma.image=[UIImage imageNamed:@"view_thread"];
    [self addSubview:leftIma];
    
    
    
    _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(width+2*kDefaultMargin, kSmallMargin, width, kFunctionBarHeight - 2 * kSmallMargin)];
    [_collectButton setBackgroundColor:[UIColor clearColor]];
    [_collectButton setTitle: StringCollection forState: UIControlStateNormal];
    _collectButton.titleLabel.font = kMiddleTextFont;
    [_collectButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_collectButton setImage:[UIImage imageNamed:@"view_collection"] forState:UIControlStateNormal];
    [_collectButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _collectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_collectButton addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _collectButton];
    
    UIImageView *rightIma=[[UIImageView alloc]initWithFrame:CGRectMake(width*2+kDefaultMargin*2+kMinSmallMargin, kDefaultMargin, 0.5, kButtomBarHeight - 2 * kDefaultMargin)];
    rightIma.image=[UIImage imageNamed:@"view_thread"];
    [self addSubview:rightIma];
    
    
    _goodsButton = [[UIButton alloc] initWithFrame:CGRectMake(width*2+3*kDefaultMargin, kSmallMargin, width, kFunctionBarHeight - 2 * kSmallMargin)];
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
- (void)collectBtnClick:(UIButton *)button
{
    if (self.collectBlk) {
        self.collectBlk();
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
