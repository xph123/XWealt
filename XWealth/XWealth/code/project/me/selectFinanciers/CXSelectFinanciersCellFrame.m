//
//  CXSelectFinanciersCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSelectFinanciersCellFrame.h"
#define COMMENT_BUTTON_WIDTH  (50.0f)
@implementation CXSelectFinanciersCellFrame
- (id)initWithDataModel:(CXFinanciersModel *)dataModel
{
    if (self = [super init]) {
        _financiersModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = kIconLargeWidth;
        CGFloat height = kIconLargeHeight;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)nameRect
{
    NSString *nameStr=_financiersModel.name;
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = kSmallMargin;
        CGFloat width = [nameStr length]*20;
        CGFloat height = kLabelHeight;
        
        _nameRect = CGRectMake(x, y, width, height);
    }
    return _nameRect;
}

- (CGRect)authenticationRect
{
    if (_authenticationRect.size.width <= 0 && _authenticationRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x+[self nameRect].size.width+kDefaultMargin;
        CGFloat y = kDefaultMargin+4;
        CGFloat width = 35;
        CGFloat height = kSmallLabelHeight-5;
        
        _authenticationRect = CGRectMake(x, y, width, height);
    }
    return _authenticationRect;
}
- (CGRect)tradeRect
{
    if (_tradeRect.size.width <= 0 && _tradeRect.size.height <= 0) {
        CGFloat x = [self authenticationRect].origin.x+[self authenticationRect].size.width+kDefaultMargin;
        CGFloat y = kDefaultMargin+4;
        CGFloat width = 35;
        CGFloat height = kSmallLabelHeight-5;
        
        _tradeRect = CGRectMake(x, y, width, height);
    }
    return _tradeRect;
}
- (CGRect)specialtyRect
{
    if (_specialtyRect.size.width <= 0 && _specialtyRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x;
        CGFloat y = [self nameRect].origin.y + [self nameRect].size.height;
        CGFloat width = kLabelWidth*3;
        CGFloat height = kSmallLabelHeight;
        
        _specialtyRect = CGRectMake(x, y, width, height);
    }
    return _specialtyRect;
}
- (CGRect)recordRect
{
    if (_recordRect.size.width <= 0 && _recordRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x;
        CGFloat y = [self specialtyRect].origin.y + [self specialtyRect].size.height;
        CGFloat width = kLabelWidth*3;
        CGFloat height = kSmallLabelHeight;
        
        _recordRect = CGRectMake(x, y, width, height);
    }
    return _recordRect;
}
- (CGRect)serviceRect
{
    if (_serviceRect.size.width <= 0 && _serviceRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x;
        CGFloat y = [self recordRect].origin.y + [self recordRect].size.height;
        CGFloat width = kLabelWidth*3;
        CGFloat height = kSmallLabelHeight;
        
        _serviceRect = CGRectMake(x, y, width, height);
    }
    return _serviceRect;
}
- (CGRect)moneyRect
{
    if (_moneyRect.size.width <= 0 && _moneyRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x;
        CGFloat y = [self serviceRect].origin.y + [self serviceRect].size.height;
        CGFloat width = (kScreenWidth-[self nameRect].origin.x)/2;
        CGFloat height = kSmallLabelHeight;
        
        _moneyRect = CGRectMake(x, y, width, height);
    }
    return _moneyRect;
}
- (CGRect)numberRect
{
    if (_numberRect.size.width <= 0 && _numberRect.size.height <= 0) {
        CGFloat x = (kScreenWidth-[self nameRect].origin.x)/2+[self nameRect].origin.x+kDefaultMargin;
        CGFloat y = [self serviceRect].origin.y + [self serviceRect].size.height;
        CGFloat width = (kScreenWidth-[self nameRect].origin.x)/2;
        CGFloat height = kSmallLabelHeight;
        
        _numberRect = CGRectMake(x, y, width, height);
    }
    return _numberRect;
}

- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self cellHeight] - 1;
        CGFloat width = [self cellWidth]-kDefaultMargin;
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    return _lineRect;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight];
        
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
        
        CGFloat connentHeight = [self nameRect].size.height+[self specialtyRect].size.height+[self recordRect].size.height+[self serviceRect].size.height+[self moneyRect].size.height+2*kDefaultMargin;
        
        height = imageHeight > connentHeight ? imageHeight : connentHeight;
        
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
