//
//  CXSecondHandMarketButtonBar.m
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSecondHandMarketButtonBar.h"
#define IconWidth        (40.0f)
#define IconHeight       (40.0f)
@implementation CXSecondHandMarketButtonBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.clipsToBounds=YES;
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = kScreenWidth;
    CGFloat height = kFunctionsBtnImaHeight*2;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    bgView.backgroundColor = kColorWhite;
    [self addSubview:bgView];
    
    _firstView =[[UIView alloc]initWithFrame:[self firstViewRect]];
    _firstView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:_firstView];
    
    _firstImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_firstImageView setImage:IMAGE(@"five")];
    _firstImageView.backgroundColor = kColorClear;
    UITapGestureRecognizer *firstTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstButtonClickAction:)];
    [_firstView addGestureRecognizer:firstTap];
    _firstView.userInteractionEnabled=YES;
    [_firstView addSubview:_firstImageView];
    
    _firstTitleLable = [[UILabel alloc] initWithFrame:[self firstTitleRect]];
    _firstTitleLable.font = kMiddleTextFont;
    _firstTitleLable.textColor = kTitleTextColor;
    _firstTitleLable.text = StringTrustTransfer;
    _firstTitleLable.numberOfLines = 1;
    _firstTitleLable.textAlignment = NSTextAlignmentLeft;
    _firstTitleLable.backgroundColor = [UIColor clearColor];
    [_firstView addSubview:_firstTitleLable];

    _firstContentLable = [[UILabel alloc] initWithFrame:[self firstContentRect]];
    _firstContentLable.font = kSmallTextFont;
    _firstContentLable.textColor = kAssistTextColor;
    _firstContentLable.text = @"卖二手信托";
    _firstContentLable.numberOfLines = 1;
    _firstContentLable.textAlignment = NSTextAlignmentLeft;
    _firstContentLable.backgroundColor = [UIColor clearColor];
    [_firstView addSubview:_firstContentLable];
    
    UIView *oneLine=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kDefaultMargin, 1, kFunctionsBtnImaHeight-2*kDefaultMargin)];
    oneLine.backgroundColor=kControlBgColor;
    [bgView addSubview:oneLine];
    
    _secondView =[[UIView alloc]initWithFrame:[self secondViewRect]];
    _secondView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *secondTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondButtonClickAction:)];
    [_secondView addGestureRecognizer:secondTap];
    _secondView.userInteractionEnabled=YES;
    [bgView addSubview:_secondView];
    
    _secondImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_secondImageView setImage:IMAGE(@"six")];
    _secondImageView.backgroundColor = kColorClear;
    [_secondView addSubview:_secondImageView];
    
    _secondTitleLable = [[UILabel alloc] initWithFrame:[self firstTitleRect]];
    _secondTitleLable.font = kMiddleTextFont;
    _secondTitleLable.textColor = kTitleTextColor;
    _secondTitleLable.text = StringBuyback;
    _secondTitleLable.numberOfLines = 1;
    _secondTitleLable.textAlignment = NSTextAlignmentLeft;
    _secondTitleLable.backgroundColor = [UIColor clearColor];
    [_secondView addSubview:_secondTitleLable];
    
    _secondContentLable = [[UILabel alloc] initWithFrame:[self firstContentRect]];
    _secondContentLable.font = kSmallTextFont;
    _secondContentLable.textColor = kAssistTextColor;
    _secondContentLable.text = @"买二手信托";
    _secondContentLable.numberOfLines = 1;
    _secondContentLable.textAlignment = NSTextAlignmentLeft;
    _secondContentLable.backgroundColor = [UIColor clearColor];
    [_secondView addSubview:_secondContentLable];
    
    _thirView =[[UIView alloc]initWithFrame:[self thirdViewRect]];
    _thirView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *thirTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdButtonClickAction:)];
    [_thirView addGestureRecognizer:thirTap];
    _thirView.userInteractionEnabled=YES;
    [self addSubview:_thirView];
    
    _thirImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_thirImageView setImage:IMAGE(@"seven")];
    _thirImageView.backgroundColor = kColorClear;
    [_thirView addSubview:_thirImageView];
    
    _thirTitleLable = [[UILabel alloc] initWithFrame:[self firstTitleRect]];
    _thirTitleLable.font = kMiddleTextFont;
    _thirTitleLable.textColor = kTitleTextColor;
    _thirTitleLable.text = StringTrustBao;
    _thirTitleLable.numberOfLines = 1;
    _thirTitleLable.textAlignment = NSTextAlignmentLeft;
    _thirTitleLable.backgroundColor = [UIColor clearColor];
    [_thirView addSubview:_thirTitleLable];
    
    _thirContentLable = [[UILabel alloc] initWithFrame:[self firstContentRect]];
    _thirContentLable.font = kSmallTextFont;
    _thirContentLable.textColor = kAssistTextColor;
    _thirContentLable.text = @"十元理财专区";
    _thirContentLable.numberOfLines = 1;
    _thirContentLable.textAlignment = NSTextAlignmentLeft;
    _thirContentLable.backgroundColor = [UIColor clearColor];
    [_thirView addSubview:_thirContentLable];
    
    
    UIView *twoLine=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kFunctionsBtnImaHeight +kDefaultMargin, 1, kFunctionsBtnImaHeight-2*kDefaultMargin)];
    twoLine.backgroundColor=kControlBgColor;
    [bgView addSubview:twoLine];
    
    _fourView =[[UIView alloc]initWithFrame:[self fourViewRect]];
    _fourView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *fourTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourButtonClickAction:)];
    [_fourView addGestureRecognizer:fourTap];
    _fourView.userInteractionEnabled=YES;
    [bgView addSubview:_fourView];
    
    _fourImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_fourImageView setImage:IMAGE(@"eight")];
    _fourImageView.backgroundColor = kColorClear;
    [_fourView addSubview:_fourImageView];
    
    _fourTitleLable = [[UILabel alloc] initWithFrame:[self firstTitleRect]];
    _fourTitleLable.font = kMiddleTextFont;
    _fourTitleLable.textColor = kTitleTextColor;
    _fourTitleLable.text = StringFot;
    _fourTitleLable.numberOfLines = 1;
    _fourTitleLable.textAlignment = NSTextAlignmentLeft;
    _fourTitleLable.backgroundColor = [UIColor clearColor];
    [_fourView addSubview:_fourTitleLable];
    
    _fourContentLable = [[UILabel alloc] initWithFrame:[self firstContentRect]];
    _fourContentLable.font = kSmallTextFont;
    _fourContentLable.textColor = kAssistTextColor;
    _fourContentLable.text = @"二十至100万专区";
    _fourContentLable.numberOfLines = 1;
    _fourContentLable.textAlignment = NSTextAlignmentLeft;
    _fourContentLable.backgroundColor = [UIColor clearColor];
    [_fourView addSubview:_fourContentLable];
    
}
- (void)firstButtonClickAction:(id)sender
{
    __unsafe_unretained CXSecondHandMarketButtonBar *weak_self = self;
    if (weak_self.firstBtnBlk) {
        weak_self.firstBtnBlk();
    }
}

- (void)secondButtonClickAction:(id)sender
{
    __unsafe_unretained CXSecondHandMarketButtonBar *weak_self = self;
    if (weak_self.secondBtnBlk) {
        weak_self.secondBtnBlk();
    }
}

- (void)thirdButtonClickAction:(id)sender
{
    __unsafe_unretained CXSecondHandMarketButtonBar *weak_self = self;
    if (weak_self.thirdBtnBlk) {
        weak_self.thirdBtnBlk();
    }
}

- (void)fourButtonClickAction:(id)sender
{
    __unsafe_unretained CXSecondHandMarketButtonBar *weak_self = self;
    if (weak_self.fourBtnBlk) {
        weak_self.fourBtnBlk();
    }
}
#pragma mark -buttonRect
- (CGRect) firstViewRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = kScreenWidth/2-1;
    CGFloat height = kFunctionsBtnImaHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondViewRect
{
    CGFloat x = kScreenWidth/2+1;
    CGFloat y = 0;
    CGFloat width = kScreenWidth/2-1;
    CGFloat height = kFunctionsBtnImaHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdViewRect
{
    CGFloat x = 0;
    CGFloat y = kFunctionsBtnImaHeight;
    CGFloat width = kScreenWidth/2-1;
    CGFloat height = kFunctionsBtnImaHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) fourViewRect
{
    CGFloat x = kScreenWidth/2+1;
    CGFloat y = kFunctionsBtnImaHeight;
    CGFloat width = kScreenWidth/2-1;
    CGFloat height = kFunctionsBtnImaHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) firstImageRect
{
    CGFloat x = kDefaultMargin ;
    CGFloat y = kDefaultMargin;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) firstTitleRect
{
    CGFloat x = [self firstImageRect].origin.x+[self firstImageRect].size.width+kDefaultMargin;
    CGFloat y = kDefaultMargin;
    
    CGFloat width = kScreenWidth/2-IconWidth-2*kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) firstContentRect
{
    CGFloat x =[self firstImageRect].origin.x+[self firstImageRect].size.width+kDefaultMargin;
    CGFloat y = [self firstTitleRect].origin.y+[self firstTitleRect].size.height;
    
    CGFloat width = kScreenWidth/2-IconWidth-2*kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
}



@end
