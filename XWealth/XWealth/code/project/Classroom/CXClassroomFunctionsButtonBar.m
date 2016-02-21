//
//  CXClassroomFunctionsButtonBar.m
//  XWealth
//
//  Created by gsycf on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomFunctionsButtonBar.h"

@implementation CXClassroomFunctionsButtonBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.clipsToBounds=YES;
        _arrayImages=[[NSMutableArray alloc]init];
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    bgView.backgroundColor = kColorWhite;
    [self addSubview:bgView];
    
    _firstImageView = [[UIImageView alloc] initWithFrame:[self firstImageRect]];
    [_firstImageView setImage:[UIImage imageNamed:@"default_image"]];
    _firstImageView.backgroundColor = kColorClear;
    [self addSubview:_firstImageView];
    

    
    _firstButton = [[UIButton alloc] initWithFrame:[self firstButtonRect]];
    _firstButton.backgroundColor = kColorClear;
    //    [_firstButton setBackgroundImage:[UIImage imageNamed:@"task_beovered"] forState:UIControlStateNormal];
    [_firstButton addTarget:self action:@selector(firstButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _firstButton];
    
    
    _secondImageView = [[UIImageView alloc] initWithFrame:[self secondImageRect]];
    [_secondImageView setImage:[UIImage imageNamed:@"default_image"]];
    _secondImageView.backgroundColor = kColorClear;
    [self addSubview:_secondImageView];
    

    
    // 完成
    _secondButton = [[UIButton alloc] initWithFrame:[self secondButtonRect]];
    _secondButton.backgroundColor = kColorClear;
    //    [_secondButton setBackgroundImage:[UIImage imageNamed:@"task_ok"] forState:UIControlStateNormal];
    [_secondButton addTarget:self action:@selector(secondButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _secondButton];
    
    
    // 分类
    _thirdImageView = [[UIImageView alloc] initWithFrame:[self thirdImageRect]];
    [_thirdImageView setImage:[UIImage imageNamed:@"default_image"]];
    _thirdImageView.backgroundColor = kColorClear;
    [self addSubview:_thirdImageView];
    

    
    _thirdButton = [[UIButton alloc] initWithFrame:[self thirdButtonRect]];
    _thirdButton.backgroundColor = kColorClear;
    //    [_thirdButton setBackgroundImage:[UIImage imageNamed:@"task_repeat"] forState:UIControlStateNormal];
    [_thirdButton addTarget:self action:@selector(thirdButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _thirdButton];
    
    
    _fourImageView = [[UIImageView alloc] initWithFrame:[self fourImageRect]];
    [_fourImageView setImage:[UIImage imageNamed:@"default_image"]];
    _fourImageView.backgroundColor = kColorClear;
    [self addSubview:_fourImageView];
    

    
    _fourButton = [[UIButton alloc] initWithFrame:[self fourButtonRect]];
    _fourButton.backgroundColor = kColorClear;
    //    [_fourButton setBackgroundImage:[UIImage imageNamed:@"product_other"] forState:UIControlStateNormal];
    [_fourButton addTarget:self action:@selector(fourButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _fourButton];
}

-(void)getData:(NSMutableArray *)arrData
{
    _firstIModel=arrData[0];
    _secondModel=arrData[1];
    _thirdModel=arrData[2];
    _fourModel=arrData[3];
    [_firstImageView sd_setImageWithURL:[NSURL URLWithString:_firstIModel.logoUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
    [_secondImageView sd_setImageWithURL:[NSURL URLWithString:_secondModel.logoUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
    [_thirdImageView sd_setImageWithURL:[NSURL URLWithString:_thirdModel.logoUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
    [_fourImageView sd_setImageWithURL:[NSURL URLWithString:_fourModel.logoUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
}


- (void)firstButtonClickAction:(id)sender
{
    __unsafe_unretained CXClassroomFunctionsButtonBar *weak_self = self;
    if (weak_self.firstBtnBlk) {
        weak_self.firstBtnBlk();
    }
}

- (void)secondButtonClickAction:(id)sender
{
    __unsafe_unretained CXClassroomFunctionsButtonBar *weak_self = self;
    if (weak_self.secondBtnBlk) {
        weak_self.secondBtnBlk();
    }
}

- (void)thirdButtonClickAction:(id)sender
{
    __unsafe_unretained CXClassroomFunctionsButtonBar *weak_self = self;
    if (weak_self.thirdBtnBlk) {
        weak_self.thirdBtnBlk();
    }
}

- (void)fourButtonClickAction:(id)sender
{
    __unsafe_unretained CXClassroomFunctionsButtonBar *weak_self = self;
    if (weak_self.fourBtnBlk) {
        weak_self.fourBtnBlk();
    }
}

- (CGRect) firstButtonRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondButtonRect
{
    CGFloat x = kFClassroomFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdButtonRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2+kFClassroomFunctionsBtnHeight+kDefaultMargin;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) fourButtonRect
{
    CGFloat x = kFClassroomFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2+kFClassroomFunctionsBtnHeight+kDefaultMargin;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}


- (CGRect) firstImageRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2 ;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)secondImageRect
{
    CGFloat x = kFClassroomFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2 ;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) thirdImageRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2 + kDefaultMargin+kFClassroomFunctionsBtnHeight;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) fourImageRect
{
    CGFloat x = kFClassroomFunctionsBtnWidth + kDefaultMargin * 2;
    CGFloat y = (kFunctionsBtnBarHeight - kFunctionsBtnHeight) / 2 + kDefaultMargin+kFClassroomFunctionsBtnHeight;
    
    CGFloat width = kFClassroomFunctionsBtnWidth;
    CGFloat height = kFClassroomFunctionsBtnHeight;
    
    return CGRectMake(x, y, width, height);
    
}




@end
