//
//  CXBuybackTrustCenterDetailOperatorView.m
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterDetailOperatorView.h"

@implementation CXBuybackTrustCenterDetailOperatorView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kColorWhite;
        self.clipsToBounds=YES;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kMinimumThread)];
    lineView.backgroundColor=kLineColor;
    [self addSubview:lineView];
    
    _SubscribeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _SubscribeButton.frame=CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
    [_SubscribeButton setBackgroundColor:kMainStyleColor];
    [_SubscribeButton setTitle:StringWindSubscribe forState:UIControlStateNormal];
    [_SubscribeButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    _SubscribeButton.titleLabel.font=kMiddleTextFont;
//    _SubscribeButton.layer.masksToBounds=YES;
    [_SubscribeButton addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_SubscribeButton];
}
#pragma mark - private click

-(void)subscribeBtnClick:(UIButton *)button
{
    if (self.subscribeBlk) {
        self.subscribeBlk();
    }
}

@end
