//
//  CXProductOperatorView.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductOperatorView.h"

@implementation CXProductOperatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorWhite;
        self.clipsToBounds=YES;
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kMinimumThread)];
    lineView.backgroundColor = kLineColor;
    [self addSubview:lineView];
    
    CGFloat width = (kScreenWidth - 5 * kDefaultMargin) / 4;
    
    
    _scheduleButton = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin * 4 + width * 3 , kDefaultMargin, width, kTabBarHeight - 2 * kDefaultMargin)];
    _scheduleButton.layer.masksToBounds = YES;
    _scheduleButton.layer.cornerRadius = kRadius;
    //_scheduleButton.layer.borderColor = kLineColor.CGColor;
//    _scheduleButton.layer.borderWidth = 1;
    [_scheduleButton setBackgroundColor:kMainStyleColor];
    [_scheduleButton setTitle: StringProductSchedule forState: UIControlStateNormal];
    _scheduleButton.titleLabel.font = kMiddleTextFont;
    [_scheduleButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_scheduleButton addTarget:self action:@selector(scheduleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _scheduleButton];
    
    
    _attentionButton = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin * 3 + width * 2, kDefaultMargin, width, kTabBarHeight - 2 * kDefaultMargin)];
    _attentionButton.layer.masksToBounds = YES;
    _attentionButton.layer.cornerRadius = kRadius;
    //_attentionButton.layer.borderColor = kLineColor.CGColor;
//    _attentionButton.layer.borderWidth = 1;
    [_attentionButton setBackgroundColor:kMainStyleColor];
    [_attentionButton setTitle: @"我要关注" forState: UIControlStateNormal];
    _attentionButton.titleLabel.font = kMiddleTextFont;
    [_attentionButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_attentionButton addTarget:self action:@selector(attentionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _attentionButton];
    
   
    _mailButton = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin * 2 + width, kDefaultMargin, width, kTabBarHeight - 2 * kDefaultMargin)];
    _mailButton.layer.masksToBounds = YES;
    _mailButton.layer.cornerRadius = kRadius;
    //_mailButton.layer.borderColor = kLineColor.CGColor;
    //_mailButton.layer.borderWidth = 1;
    [_mailButton setBackgroundColor:kMainStyleColor];
    [_mailButton setTitle: @"转发邮件" forState: UIControlStateNormal];
    _mailButton.titleLabel.font = kMiddleTextFont;
    [_mailButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_mailButton addTarget:self action:@selector(mailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _mailButton];
    
    
    _tradeButton = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, width, kTabBarHeight - 2 * kDefaultMargin)];
    _tradeButton.layer.masksToBounds = YES;
    _tradeButton.layer.cornerRadius = kRadius;
    //_tradeButton.layer.borderColor = kLineColor.CGColor;
    //_tradeButton.layer.borderWidth = 1;
    [_tradeButton setBackgroundColor:kMainStyleColor];
    [_tradeButton setTitle: StringWindSubscribe forState: UIControlStateNormal];
    _tradeButton.titleLabel.font = kMiddleTextFont;
    [_tradeButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_tradeButton addTarget:self action:@selector(tradeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _tradeButton];
    


    
}

- (void)attentionBtnClick:(UIButton *)button
{
    if (self.attentionBlk) {
        self.attentionBlk();
    }
}

- (void)mailBtnClick:(UIButton *)button
{
    if (self.mailBlk) {
        self.mailBlk();
    }
}

- (void)tradeBtnClick:(UIButton *)button
{
    if (self.tradeBlk) {
        self.tradeBlk();
    }
}
- (void)scheduleBtnClick:(UIButton *)button
{
    if (self.scheduleBlk) {
        self.scheduleBlk();
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
