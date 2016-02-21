//
//  CXMyNewsCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/22.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsCellFrame.h"
#define COMMENT_BUTTON_WIDTH  (50.0f)

@implementation CXMyNewsCellFrame
- (id)initWithDataModel:(CXNotificationModel *)dataModel;
{
    if (self = [super init]) {
        _notificationModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kMiddleMargin;
        CGFloat width = 50;
        CGFloat height = 50;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}
- (CGRect)rightBtnRect
{
    if (_rightBtnRect.size.width <= 0 && _rightBtnRect.size.height <= 0) {
        CGFloat x = kDefaultMargin+42;
        CGFloat y = kMiddleMargin-4;
        CGFloat width = 12;
        CGFloat height = 12;
        _rightBtnRect = CGRectMake(x, y, width, height);
    }
    
    return _rightBtnRect;
}
- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = 5;
        CGFloat width = [self cellWidth] - 4 * kDefaultMargin - [self imageViewRect].size.width-100;
        CGFloat height = kLabelHeight;
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}



- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self titleRect].size.width+[self titleRect].origin.x+kDefaultMargin;
        CGFloat y = 5;
        CGFloat width = 100;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

- (CGRect)contentRect
{
    if (_contentRect.size.width <= 0 && _contentRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = [self cellWidth] - 3 * kDefaultMargin - [self imageViewRect].size.width;
        CGFloat height = kLabelHeight;
        
        _contentRect = CGRectMake(x, y, width, height);
    }
    return _contentRect;
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
        
        CGFloat imageHeight = [self imageViewRect].size.height + 2 * kMiddleMargin;
        
        
        height = imageHeight;
        
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
