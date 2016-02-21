//
//  CXMyBuybackCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyBuybackCellFrame.h"
#define ITEMVIEW_MARGIN     (2.0f)
#define ITEMVIEW_HEIGHT     (40.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (125.0f)
#define PROCESS_HEIGHT      (68.0f)
@implementation CXMyBuybackCellFrame
- (id)initWithDataModel:(CXBuyBackModel *)BuyBackModel
{
    if (self = [super init]) {
        _buyBackModel = BuyBackModel;
    }
    
    return self;
}
- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        CGFloat width = [self cellWidth]-2*kDefaultMargin;
        CGFloat height = kLabelHeight;
        _titleRect = CGRectMake(x, y, width, height);
    }
    
    return _titleRect;
}

- (CGRect)deadlineRect
{
    if (_deadlineRect.size.width <= 0 && _deadlineRect.size.height <= 0) {
        CGFloat x = kMiddleMargin;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = PROCESS_WIDTH;
        CGFloat height = kLabelHeight;
        
        _deadlineRect = CGRectMake(x, y, width, height);
    }
    return _deadlineRect;
}
- (CGRect)profitRect
{
    if (_profitRect.size.width <= 0 && _profitRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/2;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = PROCESS_WIDTH;
        CGFloat height = kLabelHeight;
        _profitRect = CGRectMake(x, y, width, height);
    }
    return _profitRect;
}


- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self deadlineRect].origin.y + [self deadlineRect].size.height;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    return _lineRect;
}
- (CGRect)stateRect
{
    if (_stateRect.size.width <= 0 && _stateRect.size.height <= 0) {
        CGFloat x = kMiddleMargin;
        CGFloat y = [self lineRect].origin.y + kMinSmallMargin;
        CGFloat width = PROCESS_WIDTH;
        CGFloat height = kLabelHeight;
        
        _stateRect = CGRectMake(x, y, width, height);
    }
    return _stateRect;
}
- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-PROCESS_WIDTH-kDefaultMargin;
        CGFloat y = [self lineRect].origin.y  + kMinSmallMargin;
        CGFloat width = PROCESS_WIDTH;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
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
        
        CGFloat imageHeight = [self titleRect].size.height*3+[self titleRect].origin.y+kDefaultMargin;
        height=imageHeight;
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
