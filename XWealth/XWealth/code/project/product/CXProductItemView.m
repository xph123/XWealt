//
//  CXProductItemView.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductItemView.h"

@implementation CXProductItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorClear;
        self.clipsToBounds=YES;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    CGFloat width = self.frame.size.width;
    
    if (width < 90)
    {
        width = 90;
    }
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    _titleLabel.font = kSmallTextFont;
    _titleLabel.textColor = kAssistTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, 25)];
    _valueLabel.font = kMiddleTextFont;
    _valueLabel.textColor = kTextColor;
    _valueLabel.numberOfLines = 1;
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_valueLabel];
}
-(void)setTitleLabelFrame:(CGRect)rect andSetTitlefont:(UIFont *)textFont
{
    _titleLabel.frame=rect;
    _titleLabel.font=textFont;
}
-(void)setValueLabelFrame:(CGRect)rect andSetTitlefont:(UIFont *)textFont
{
    _valueLabel.frame=rect;
    _valueLabel.font=textFont;
}

@end
