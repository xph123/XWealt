//
//  CXProductCellFrame.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductCellFrame.h"

#define STATE_IMAGE_WIDTH   (16.0f)
#define STATE_IMAGE_HEIGHT  (54.0f)
#define ITEMVIEW_MARGIN     (2.0f)
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define PROCESS_HEIGHT      (68.0f)

@implementation CXProductCellFrame

- (id)initWithDataModel:(CXProductSimplyModel *)dataModel
{
    if (self = [super init]) {
        _sProductModel = dataModel;
    }
    
    return self;
}


- (CGRect)stateImageViewRect
{
    if (_stateImageViewRect.size.width <= 0 && _stateImageViewRect.size.height <= 0) {
        CGFloat width = STATE_IMAGE_WIDTH;
        CGFloat height = STATE_IMAGE_HEIGHT;
        CGFloat x = - 4;
        CGFloat y = kMiddleMargin;
        
        _stateImageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _stateImageViewRect;
}

- (CGRect)titlelabelRect
{
    if (_titlelabelRect.size.width <= 0 && _titlelabelRect.size.height <= 0) {
        CGFloat x = kDefaultMargin*2;
        CGFloat y = 0;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin - PROCESS_WIDTH;
        CGFloat height = kLabelHeight;
        
        _titlelabelRect = CGRectMake(x, y, width, height);
    }
    return _titlelabelRect;
}

- (CGRect) ProgressImageRect
{
    if (_ProgressImageRect.size.width <= 0 && _ProgressImageRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - PROCESS_WIDTH + kDefaultMargin;
        CGFloat y = kMiddleMargin;
        CGFloat width = PROCESS_WIDTH - kDefaultMargin * 2;
        CGFloat height = PROCESS_HEIGHT - kDefaultMargin * 2;
        
        _ProgressImageRect = CGRectMake(x, y, width, height);
    }
    return _ProgressImageRect;
}

//- (CGRect)bankLabelRect
//{
//    if (_bankLabelRect.size.width <= 0 && _bankLabelRect.size.height <= 0) {
//        CGFloat x = [self titlelabelRect].origin.x;
//        CGFloat y = [self titlelabelRect].origin.y + [self titlelabelRect].size.height;
//        CGFloat width = [self titlelabelRect].size.width;
//        CGFloat height = kLabelHeight;
//        
//        _bankLabelRect = CGRectMake(x, y, width, height);
//    }
//    return _bankLabelRect;
//}

- (CGRect)profitViewRect
{
    if (_profitViewRect.size.width <= 0 && _profitViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self titlelabelRect].origin.y + [self titlelabelRect].size.height;
        CGFloat width = [self itemViewWidth];
        CGFloat height = ITEMVIEW_HEIGHT;
        
        _profitViewRect = CGRectMake(x, y, width, height);
    }
    return _profitViewRect;
}

- (CGRect)deadlineViewRect
{
    if (_deadlineViewRect.size.width <= 0 && _deadlineViewRect.size.height <= 0) {
        CGFloat x = [self profitViewRect].origin.x + [self profitViewRect].size.width + ITEMVIEW_MARGIN;
        CGFloat y = [self profitViewRect].origin.y;
        CGFloat width = [self itemViewWidth];
        CGFloat height = ITEMVIEW_HEIGHT;
        
        _deadlineViewRect = CGRectMake(x, y, width, height);
    }
    return _deadlineViewRect;
}

- (CGRect)categoryViewRect
{
    if (_categoryViewRect.size.width <= 0 && _categoryViewRect.size.height <= 0) {
        CGFloat x = [self deadlineViewRect].origin.x + [self deadlineViewRect].size.width + ITEMVIEW_MARGIN;
        CGFloat y = [self deadlineViewRect].origin.y;
        CGFloat width = [self itemViewWidth];
        CGFloat height = ITEMVIEW_HEIGHT;
        
        _categoryViewRect = CGRectMake(x, y, width, height);
    }
    return _categoryViewRect;
}

- (CGRect)verticalLine1Rect
{
    if (_verticalLine1Rect.size.width <= 0 && _verticalLine1Rect.size.height <= 0) {
        CGFloat x = [self profitViewRect].origin.x + [self profitViewRect].size.width + ITEMVIEW_MARGIN / 2;
        CGFloat y = [self profitViewRect].origin.y;
        CGFloat width = 0.5;
        CGFloat height = ITEMVIEW_HEIGHT - kDefaultMargin;
        
        _verticalLine1Rect = CGRectMake(x, y, width, height);
    }
    return _verticalLine1Rect;
}

- (CGRect)verticalLine2Rect
{
    if (_verticalLine2Rect.size.width <= 0 && _verticalLine2Rect.size.height <= 0) {
        CGFloat x = [self deadlineViewRect].origin.x + [self deadlineViewRect].size.width + ITEMVIEW_MARGIN / 2;
        CGFloat y = [self deadlineViewRect].origin.y;
        CGFloat width = 0.5;
        CGFloat height = ITEMVIEW_HEIGHT - kDefaultMargin;
        
        _verticalLine2Rect = CGRectMake(x, y, width, height);
    }
    return _verticalLine2Rect;
}

//- (CGRect)horizoncalLine1Rect
//{
//    if (_horizoncalLine1Rect.size.width <= 0 && _horizoncalLine1Rect.size.height <= 0) {
//        CGFloat x = [self categoryViewRect].origin.x + ITEMVIEW_MARGIN;
//        CGFloat y = [self categoryViewRect].origin.y + [self categoryViewRect].size.height;
//        CGFloat width = [self cellWidth] - 2 * ITEMVIEW_MARGIN;
//        CGFloat height = 0.5;
//        
//        _horizoncalLine1Rect = CGRectMake(x, y, width, height);
//    }
//    return _horizoncalLine1Rect;
//}

//- (CGRect)moneyToLabelRect
//{
//    if (_moneyToLabelRect.size.width <= 0 && _moneyToLabelRect.size.height <= 0) {
//        CGFloat x = kDefaultMargin;
//        CGFloat y = [self horizoncalLine1Rect].origin.y + 1;
//        CGFloat width = [self cellWidth] - kDefaultMargin * 2;
//        CGFloat height = kTwoLineLabelHeight;
//        
//        _moneyToLabelRect = CGRectMake(x, y, width, height);
//    }
//    return _moneyToLabelRect;
//}


- (CGRect)horizoncalLine2Rect
{
    if (_horizoncalLine2Rect.size.width <= 0 && _horizoncalLine2Rect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self categoryViewRect].origin.y + [self categoryViewRect].size.height;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;

        _horizoncalLine2Rect = CGRectMake(x, y, width, height);
    }
    return _horizoncalLine2Rect;
}


//- (CGRect)horizoncalLine2Rect
//{
//    if (_horizoncalLine2Rect.size.width <= 0 && _horizoncalLine2Rect.size.height <= 0) {
//        CGFloat x = 0;
//        CGFloat y = [self horizoncalLine1Rect].origin.y + 1 + kTwoLineLabelHeight;
//        CGFloat width = [self cellWidth];
//        CGFloat height = 0.5;
//        
//        _horizoncalLine2Rect = CGRectMake(x, y, width, height);
//    }
//    return _horizoncalLine2Rect;
//}


- (CGRect)commentLabelRect
{
    if (_commentLabelRect.size.width <= 0 && _commentLabelRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self horizoncalLine2Rect].origin.y + 1;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin;
        CGFloat height = kTwoLineLabelHeight;
        
        CGSize size = [self.sProductModel.comment getSizeWithWidth:width fontSize:kMiddleTextFontSize];
        
        if (size.height > kLabelHeight)
        {
            height = kTwoLineLabelHeight;
        }
        else
        {
            height = kLabelHeight;
        }
        
        _commentLabelRect = CGRectMake(x, y, width, height);
    }
    return _commentLabelRect;
}

//- (CGRect)lineViewRect
//{
//    if (_lineViewRect.size.width <= 0 && _lineViewRect.size.height <= 0) {
//        CGFloat x = 0;
//        CGFloat y = [self cellHeight] - 1;
//        CGFloat width = [self cellWidth];
//        CGFloat height = 1;
//        
//        _lineViewRect = CGRectMake(x, y, width, height);
//    }
//    return _lineViewRect;
//}

- (CGFloat) itemViewWidth
{
    return ([self cellWidth] - ITEMVIEW_MARGIN * 2 - kMiddleMargin - PROCESS_WIDTH) / 3 ;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 4;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 4;
        
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
        
        CGFloat height = (kLabelHeight + 4) + ITEMVIEW_HEIGHT + [self commentLabelRect].size.height;
        
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
