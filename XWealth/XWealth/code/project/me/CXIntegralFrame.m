//
//  CXIntegralFrame.m
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXIntegralFrame.h"

@implementation CXIntegralFrame

- (id)initWithDataModel:(CXIntegralModel *)dataModel
{
    if (self = [super init]) {
        _integralModel = dataModel;
        
    }
    
    return self;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin;
        CGFloat height = kLabelHeight;
        
        if (![self.integralModel.eventName isEmpty])
        {
            NSString *str = @"";
            if (self.integralModel.type == EXP_SUBSCRIBE)
            {
                str = [NSString stringWithFormat:@"您定购了：%@，获得%d现金劵", self.integralModel.eventName, EXP_POINT_SUBSCRIBE];
            }
            else if (self.integralModel.type == EXP_RECOMMENT)
            {
                str = [NSString stringWithFormat:@"您推荐了：%@，获得%d现金劵", self.integralModel.eventName, EXP_POINT_RECOMMENT];
            }
            
            CGSize size = [str getSizeWithWidth:width fontSize:kMiddleTextFontSize];
            
            if (size.height > height)
            {
                height = size.height + 5;
            }
        }
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = 100;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 1;
        
        _cellViewRect = CGRectMake(x, y, width, height);
    }
    return _cellViewRect;
}

- (CGFloat) cellWidth
{
    return kScreenWidth - 2 * kDefaultMargin;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = [self titleRect].size.height + kLabelHeight + 2 * kDefaultMargin;
        
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
