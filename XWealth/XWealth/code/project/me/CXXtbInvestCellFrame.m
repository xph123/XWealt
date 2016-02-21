//
//  CXXtbInvestCellFrame.m
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbInvestCellFrame.h"

@implementation CXXtbInvestCellFrame

- (id)initWithDataModel:(CXXtbInvestModel *)dataModel
{
    if (self = [super init]) {
        _investModel = dataModel;
        
    }
    
    return self;
}

- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = 45;
        CGFloat height = 45;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = 0;
        CGFloat height = kLabelHeight;
        
        if (![self.investModel.prodName isEmpty])
        {
            CGSize size = [self.investModel.prodName getSizeWithWidth:200 fontSize:kLargeTextFontSize];
            
            width = size.width;
        }
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)intstRateRect
{
    if (_intstRateRect.size.width <= 0 && _intstRateRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x + [self titleRect].size.width;
        CGFloat y = [self titleRect].origin.y;
        CGFloat width = 0;
        CGFloat height = kLabelHeight;
        
        if (self.investModel.intstRate > 0)
        {
            NSString *intst = [NSString stringWithFormat:@"（年化%0.1f%@）", self.investModel.intstRate, @"%"];
            CGSize size = [intst getSizeWithWidth:120 fontSize:kMiddleTextFontSize];
            
            width = size.width;
        }
        
        _intstRateRect = CGRectMake(x, y, width, height);
    }
    return _intstRateRect;
}


- (CGRect)stateRect
{
    if (_stateRect.size.width <= 0 && _stateRect.size.height <= 0) {
        CGFloat width = 54;
        CGFloat height = 20;
        CGFloat x = kScreenWidth - kDefaultMargin - width;
        CGFloat y = kDefaultMargin + (kLabelHeight - height)/2;
        
        _stateRect = CGRectMake(x, y, width, height);
    }
    
    return _stateRect;
}


- (CGRect)inTimeRect
{
    if (_inTimeRect.size.width <= 0 && _inTimeRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x ;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = 0;
        CGFloat height = kLabelHeight;
        
        if (![self.investModel.inTime isEmpty])
        {
            NSString *intst = [NSString stringWithFormat:@"回款时间 %@", [XDateHelper translateToXtbDisplay: self.investModel.inTime]];
            CGSize size = [intst getSizeWithWidth:200 fontSize:kMiddleTextFontSize];
            
            width = size.width;
        }
        
        _inTimeRect = CGRectMake(x, y, width, height);
    }
    return _inTimeRect;
}

- (CGRect)intstRect
{
    if (_intstRect.size.width <= 0 && _intstRect.size.height <= 0) {
        CGFloat x = [self inTimeRect].origin.x + [self inTimeRect].size.width + kDefaultMargin;
        CGFloat y = [self inTimeRect].origin.y;
        CGFloat width = kScreenWidth - x - kDefaultMargin;
        CGFloat height = kLabelHeight;
        
        _intstRect = CGRectMake(x, y, width, height);
    }
    return _intstRect;
}


- (CGRect)investTimeRect
{
    if (_investTimeRect.size.width <= 0 && _investTimeRect.size.height <= 0) {
        CGFloat x = [self inTimeRect].origin.x ;
        CGFloat y = [self inTimeRect].origin.y + [self inTimeRect].size.height;
        CGFloat width = 0;
        CGFloat height = kSmallLabelHeight;
        
        if (![self.investModel.investTime isEmpty])
        {
            NSString *intst = [NSString stringWithFormat:@"投资时间 %@", [XDateHelper translateToXtbDisplay: self.investModel.investTime]];
            CGSize size = [intst getSizeWithWidth:200 fontSize:kSmallTextFontSize];
            
            width = size.width;
        }
        
        _investTimeRect = CGRectMake(x, y, width, height);
    }
    return _investTimeRect;
}

- (CGRect)invAmtRect
{
    if (_invAmtRect.size.width <= 0 && _invAmtRect.size.height <= 0) {
        CGFloat x = [self investTimeRect].origin.x + [self investTimeRect].size.width + kDefaultMargin;
        CGFloat y = [self investTimeRect].origin.y;
        CGFloat width = kScreenWidth - x - kDefaultMargin;
        CGFloat height = kSmallLabelHeight;

        
        _invAmtRect = CGRectMake(x, y, width, height);
    }
    return _invAmtRect;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 0.5;
        
        _cellViewRect = CGRectMake(x, y, width, height);
    }
    return _cellViewRect;
}

- (CGFloat) cellWidth
{
    return kScreenWidth;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = 0;
        
        CGFloat imageHeight = [self imageViewRect].size.height + 2 * kDefaultMargin;
        
        CGFloat connentHeight = 2 * kDefaultMargin + kLabelHeight*2 + kSmallLabelHeight;
        
        height = imageHeight > connentHeight ? imageHeight : connentHeight;
        
        _cellHeight = height;
    }
    
    return _cellHeight;
}

@end
