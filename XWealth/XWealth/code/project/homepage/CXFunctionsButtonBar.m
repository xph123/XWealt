//
//  CXFunctionsButtonBar.m
//  Link
//
//  Created by chx on 14-11-6.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXFunctionsButtonBar.h"

#define IconWidth        (44.0f)
#define IconHeight       (44.0f)

@implementation CXFunctionsButtonBar

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
    CGFloat height = kFunctionsBtnHeight+kFunctionsBtnHeight;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    bgView.backgroundColor = kColorWhite;
    [self addSubview:bgView];
    
    _firstImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_firstImageView setImage:IMAGE(@"one")];
    _firstImageView.backgroundColor = kColorClear;
    [self addSubview:_firstImageView];
    
    _firstText = [[UILabel alloc] initWithFrame:[self firstTextRect]];
    _firstText.font = kMiddleTextFont;
    _firstText.textColor = kTextColor;
    _firstText.text = StringProductAll;
    _firstText.numberOfLines = 1;
    _firstText.textAlignment = NSTextAlignmentCenter;
    _firstText.backgroundColor = [UIColor clearColor];
    [self addSubview:_firstText];
    
    _firstButton = [[UIButton alloc] initWithFrame:[self firstButtonRect]];
    _firstButton.backgroundColor = kColorClear;
    //    [_firstButton setBackgroundImage:[UIImage imageNamed:@"task_beovered"] forState:UIControlStateNormal];
    [_firstButton addTarget:self action:@selector(firstButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _firstButton];

    
    _secondImageView = [[UIImageView alloc] initWithFrame:[self secondImageRect]];
    [_secondImageView setImage:IMAGE(@"two")];
    _secondImageView.backgroundColor = kColorClear;
    [self addSubview:_secondImageView];
    
    _secondText = [[UILabel alloc] initWithFrame:[self secondTextRect]];
    _secondText.font = kMiddleTextFont;
    _secondText.textColor = kTextColor;
    _secondText.text = StringTwoMarket;
    _secondText.numberOfLines = 1;
    _secondText.textAlignment = NSTextAlignmentCenter;
    _secondText.backgroundColor = [UIColor clearColor];
    [self addSubview:_secondText];
    
    // 完成
    _secondButton = [[UIButton alloc] initWithFrame:[self secondButtonRect]];
    _secondButton.backgroundColor = kColorClear;
    //    [_secondButton setBackgroundImage:[UIImage imageNamed:@"task_ok"] forState:UIControlStateNormal];
    [_secondButton addTarget:self action:@selector(secondButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _secondButton];

    
    // 分类
    _thirdImageView = [[UIImageView alloc] initWithFrame:[self thirdImageRect]];
    [_thirdImageView setImage:IMAGE(@"three")];
    _thirdImageView.backgroundColor = kColorClear;
    [self addSubview:_thirdImageView];
    
    _thirdText = [[UILabel alloc] initWithFrame:[self thirdTextRect]];
    _thirdText.font = kMiddleTextFont;
    _thirdText.textColor = kTextColor;
    _thirdText.text = StringInformation;
    _thirdText.numberOfLines = 1;
    _thirdText.textAlignment = NSTextAlignmentCenter;
    _thirdText.backgroundColor = [UIColor clearColor];
    [self addSubview:_thirdText];
    
    _thirdButton = [[UIButton alloc] initWithFrame:[self thirdButtonRect]];
    _thirdButton.backgroundColor = kColorClear;
    //    [_thirdButton setBackgroundImage:[UIImage imageNamed:@"task_repeat"] forState:UIControlStateNormal];
    [_thirdButton addTarget:self action:@selector(thirdButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _thirdButton];

    
    _fourImageView = [[UIImageView alloc] initWithFrame:[self fourImageRect]];
    [_fourImageView setImage:IMAGE(@"four")];
    _fourImageView.backgroundColor = kColorClear;
    [self addSubview:_fourImageView];
    
    _fourText = [[UILabel alloc] initWithFrame:[self fourTextRect]];
    _fourText.font = kMiddleTextFont;
    _fourText.textColor = kTextColor;
    _fourText.text = StringClassroom;
    _fourText.numberOfLines = 1;
    _fourText.textAlignment = NSTextAlignmentCenter;
    _fourText.backgroundColor = [UIColor clearColor];
    [self addSubview:_fourText];

    _fourButton = [[UIButton alloc] initWithFrame:[self fourButtonRect]];
    _fourButton.backgroundColor = kColorClear;
    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
    [_fourButton addTarget:self action:@selector(fourButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _fourButton];
    
//五
//    _fiveImageView = [[UIImageView alloc] initWithFrame:[self fiveImageRect]];
//    [_fiveImageView setImage:IMAGE(@"five")];
//    _fiveImageView.backgroundColor = kColorClear;
//    [self addSubview:_fiveImageView];
//    
//    _fiveText = [[UILabel alloc] initWithFrame:[self fiveTextRect]];
//    _fiveText.font = kMiddleTextFont;
//    _fiveText.textColor = kTextColor;
//    _fiveText.text = StringTrustBao;
//    _fiveText.numberOfLines = 1;
//    _fiveText.textAlignment = NSTextAlignmentCenter;
//    _fiveText.backgroundColor = [UIColor clearColor];
//    [self addSubview:_fiveText];
//    
//    _fiveButton = [[UIButton alloc] initWithFrame:[self fiveButtonRect]];
//    _fiveButton.backgroundColor = kColorClear;
//    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
//    [_fiveButton addTarget:self action:@selector(fiveButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview: _fiveButton];
//    
//
//    
//    
//    _sixImageView = [[UIImageView alloc] initWithFrame:[self sixImageRect]];
//    [_sixImageView setImage:IMAGE(@"six")];
//    _sixImageView.backgroundColor = kColorClear;
//    [self addSubview:_sixImageView];
//    
//    _sixText = [[UILabel alloc] initWithFrame:[self sixTextRect]];
//    _sixText.font = kMiddleTextFont;
//    _sixText.textColor = kTextColor;
//    _sixText.text = StringTrustTransfer;
//    _sixText.numberOfLines = 1;
//    _sixText.textAlignment = NSTextAlignmentCenter;
//    _sixText.backgroundColor = [UIColor clearColor];
//    [self addSubview:_sixText];
//    
//    _sixButton = [[UIButton alloc] initWithFrame:[self sixButtonRect]];
//    _sixButton.backgroundColor = kColorClear;
//    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
//    [_sixButton addTarget:self action:@selector(sixButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview: _sixButton];
//
//    _sevenImageView = [[UIImageView alloc] initWithFrame:[self sevenImageRect]];
//    [_sevenImageView setImage:IMAGE(@"seven")];
//    _sevenImageView.backgroundColor = kColorClear;
//    [self addSubview:_sevenImageView];
//    
//    _sevenText = [[UILabel alloc] initWithFrame:[self sevenTextRect]];
//    _sevenText.font = kMiddleTextFont;
//    _sevenText.textColor = kTextColor;
//    _sevenText.text = StringBuyback;
//    _sevenText.numberOfLines = 1;
//    _sevenText.textAlignment = NSTextAlignmentCenter;
//    _sevenText.backgroundColor = [UIColor clearColor];
//    [self addSubview:_sevenText];
//    
//    _sevenButton = [[UIButton alloc] initWithFrame:[self sevenButtonRect]];
//    _sevenButton.backgroundColor = kColorClear;
//    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
//    [_sevenButton addTarget:self action:@selector(sevenButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview: _sevenButton];
//    
//    _eightImageView = [[UIImageView alloc] initWithFrame:[self eightImageRect]];
//    [_eightImageView setImage:IMAGE(@"eight")];
//    _eightImageView.backgroundColor = kColorClear;
//    [self addSubview:_eightImageView];
//    
//    _eightText = [[UILabel alloc] initWithFrame:[self eightTextRect]];
//    _eightText.font = kMiddleTextFont;
//    _eightText.textColor = kTextColor;
//    _eightText.text = StringFot;
//    _eightText.numberOfLines = 1;
//    _eightText.textAlignment = NSTextAlignmentCenter;
//    _eightText.backgroundColor = [UIColor clearColor];
//    [self addSubview:_eightText];
//    
//    _eightButton = [[UIButton alloc] initWithFrame:[self eigthButtonRect]];
//    _eightButton.backgroundColor = kColorClear;
//    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
//    [_eightButton addTarget:self action:@selector(eightButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview: _eightButton];
}

- (void) setUnreadItem:(NSInteger) count
{
    if (count > 0)
    {
        _unreadImageView.hidden = NO;
        _unreadLabel.hidden = NO;
        
        _unreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake([self firstButtonRect].size.width - 30, 8, 16, 16)];
        UIImage *unreadImage = [UIImage imageNamed:@"unread_bg"];
        [_unreadImageView setImage:unreadImage];
        
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake([self firstButtonRect].size.width - 30, 7, 16, 16)];
        _unreadLabel.font = kExtralSmallTextFont;
        _unreadLabel.textColor = [UIColor whiteColor];
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.text = [NSString stringWithFormat:@"%ld", count];
        
        [_firstButton addSubview: _unreadImageView];
        [_firstButton addSubview:_unreadLabel];
    }
    else
    {
        _unreadImageView.hidden = YES;
        _unreadLabel.hidden = YES;
    }
}


- (void)firstButtonClickAction:(id)sender
{
    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
    if (weak_self.firstBtnBlk) {
        weak_self.firstBtnBlk();
    }
}

- (void)secondButtonClickAction:(id)sender
{
    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
    if (weak_self.secondBtnBlk) {
        weak_self.secondBtnBlk();
    }
}

- (void)thirdButtonClickAction:(id)sender
{
    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
    if (weak_self.thirdBtnBlk) {
        weak_self.thirdBtnBlk();
    }
}

- (void)fourButtonClickAction:(id)sender
{
    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
    if (weak_self.fourBtnBlk) {
        weak_self.fourBtnBlk();
    }
}
//- (void)fiveButtonClickAction:(id)sender
//{
//    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
//    if (weak_self.fiveBtnBlk) {
//        weak_self.fiveBtnBlk();
//    }
//}
//- (void)sixButtonClickAction:(id)sender
//{
//    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
//    if (weak_self.sixBtnBlk) {
//        weak_self.sixBtnBlk();
//    }
//}
//- (void)sevenButtonClickAction:(id)sender
//{
//    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
//    if (weak_self.sevenBtnBlk) {
//        weak_self.sevenBtnBlk();
//    }
//}
//- (void)eightButtonClickAction:(id)sender
//{
//    __unsafe_unretained CXFunctionsButtonBar *weak_self = self;
//    if (weak_self.eightBtnBlk) {
//        weak_self.eightBtnBlk();
//    }
//}
#pragma mark -buttonRect
- (CGRect) firstButtonRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = 4;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondButtonRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y =4;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdButtonRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 3;
    CGFloat y = 4;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) fourButtonRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 4;
    CGFloat y = 4;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) fiveButtonRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = 4 +kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)sixButtonRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = 4 +kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) sevenButtonRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 3;
    CGFloat y = 4+kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) eigthButtonRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 4;
    CGFloat y = 4 +kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = kFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}


#pragma mark -ImageRect

- (CGRect) firstImageRect
{
    CGFloat x = (kFunctionsBtnWidth - kIconMiddleWidth) / 2 ;
    CGFloat y = 4+ kDefaultMargin;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondImageRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin  + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdImageRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 2 + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) fourImageRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 3 + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) fiveImageRect
{
    CGFloat x = (kFunctionsBtnWidth - kIconMiddleWidth) / 2 ;
    CGFloat y = kMinSmallMargin + kDefaultMargin+kFunctionsBtnHeight;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)sixImageRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin  + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin+kFunctionsBtnHeight;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) sevenImageRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 2 + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin+kFunctionsBtnHeight;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) eightImageRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 3 + (kFunctionsBtnWidth - kIconMiddleWidth) / 2;
    CGFloat y = 4 + kDefaultMargin+kFunctionsBtnHeight;
    
    CGFloat width = IconWidth;
    CGFloat height = IconHeight;
    
    return CGRectMake(x, y, width, height);
    
}

#pragma amrk -textRect
- (CGRect) firstTextRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = kFunctionsBtnBarHeight -kDefaultMargin- 32;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondTextRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = kFunctionsBtnBarHeight -kDefaultMargin- 32;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdTextRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 3;
    CGFloat y = kFunctionsBtnBarHeight -kDefaultMargin- 32;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) fourTextRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 4;
    CGFloat y = kFunctionsBtnBarHeight-kDefaultMargin - 32;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) fiveTextRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = (kFunctionsBtnBarHeight - 36)+kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)sixTextRect
{
    CGFloat x = kFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = (kFunctionsBtnBarHeight - 36)+kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) sevenTextRect
{
    CGFloat x = kFunctionsBtnWidth * 2 + kDefaultMargin * 3;
    CGFloat y = (kFunctionsBtnBarHeight - 36)+kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) eightTextRect
{
    CGFloat x = kFunctionsBtnWidth * 3 + kDefaultMargin * 4;
    CGFloat y = (kFunctionsBtnBarHeight - 36)+kFunctionsBtnHeight;
    
    CGFloat width = kFunctionsBtnWidth;
    CGFloat height = 28;
    
    return CGRectMake(x, y, width, height);
}

@end
