//
//  CXInformationCellLayout.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationCellFrame.h"

#define COMMENT_BUTTON_WIDTH  (50.0f)

@implementation CXInformationCellFrame

- (id)initWithDataModel:(CXInformationModel *)dataModel
{
    if (self = [super init]) {
        _informationModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kMiddleMargin;
        CGFloat width = kIconRectangleWidth;
        CGFloat height = kIconLargeHeight;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = 5;
        CGFloat width = [self cellWidth] - 3 * kDefaultMargin - [self imageViewRect].size.width;
        CGFloat height = kLabelHeight;
        CGSize size = [self.informationModel.name getSizeWithWidth:width fontSize:kMiddleTextFontSize];
        
        if (size.height > kLabelHeight)
        {
            height = kTwoLineLabelHeight;
        }
        else
        {
            height = kLabelHeight;
        }

        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x;
        CGFloat y = kIconLargeHeight+kDefaultMargin*2-kSmallLabelHeight;
        CGFloat width = 100;
        CGFloat height = kSmallLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

- (CGRect)commentsRect
{
    if (_commentsRect.size.width <= 0 && _commentsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - kDefaultMargin - COMMENT_BUTTON_WIDTH;
        CGFloat y = kIconLargeHeight+kDefaultMargin*2-kSmallLabelHeight;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = kSmallLabelHeight;
        
        _commentsRect = CGRectMake(x, y, width, height);
    }
    return _commentsRect;
}

- (CGRect)goodsRect
{
    if (_goodsRect.size.width <= 0 && _goodsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - (kDefaultMargin + COMMENT_BUTTON_WIDTH) * 2;
        CGFloat y = kIconLargeHeight+kDefaultMargin*2-kSmallLabelHeight;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = kSmallLabelHeight;
        
        _goodsRect = CGRectMake(x, y, width, height);
    }
    return _goodsRect;
}

- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self cellHeight] - 0.5;
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
        
        CGFloat imageHeight = [self imageViewRect].size.height + 2 * kMiddleMargin;
        
        CGFloat connentHeight = 2 * kDefaultMargin  + 2 * kLabelHeight;
        
        height = imageHeight > connentHeight ? imageHeight : connentHeight;
        
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
