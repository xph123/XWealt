//
//  CXmyAccountItemView.m
//  XWealth
//
//  Created by gsycf on 15/9/22.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXmyAccountItemView.h"

@implementation CXmyAccountItemView
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
    _titleLabel.font = kMiddleTextFont;
    _titleLabel.textColor = kxintuoGrayTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, 25)];
    _valueLabel.font = kLargeTextFont;
    _valueLabel.textColor = kxintuoBlackTextColor;
    _valueLabel.numberOfLines = 1;
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_valueLabel];
}

@end
