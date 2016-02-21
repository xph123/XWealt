//
//  CXTrustTransferDetailOperatorView.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferDetailOperatorView.h"

@implementation CXTrustTransferDetailOperatorView

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
    
    _dataButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _dataButton.frame=CGRectMake(0, 0, kScreenWidth/2, self.frame.size.height);
    [_dataButton setBackgroundColor:kxintuoOrangeColor];
    [_dataButton setTitle:StringProductData forState:UIControlStateNormal];
    [_dataButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    _dataButton.titleLabel.font=kMiddleTextFont;
//    _dataButton.layer.masksToBounds=YES;
//    _dataButton.layer.cornerRadius=kRadius;
    [_dataButton addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dataButton];
    
    
    _SubscribeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _SubscribeButton.frame=CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, self.frame.size.height);
    [_SubscribeButton setBackgroundColor:kMainStyleColor];
    [_SubscribeButton setTitle:StringWindSubscribe forState:UIControlStateNormal];
    [_SubscribeButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    _SubscribeButton.titleLabel.font=kMiddleTextFont;
//    _SubscribeButton.layer.masksToBounds=YES;
//    _SubscribeButton.layer.cornerRadius=kRadius;
    [_SubscribeButton addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_SubscribeButton];
}
#pragma mark - private click
-(void)dataBtnClick:(UIButton *)button
{
    if (self.dataBlk) {
        self.dataBlk();
    }
}
-(void)subscribeBtnClick:(UIButton *)button
{
    if (self.subscribeBlk) {
        self.subscribeBlk();
    }
}
@end
