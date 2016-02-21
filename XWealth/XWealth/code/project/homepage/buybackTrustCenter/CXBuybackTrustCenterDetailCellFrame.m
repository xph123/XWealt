//
//  CXBuybackTrustCenterDetailCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterDetailCellFrame.h"
#define COMMENT_IMAGE_WIDTH  (40.0f)
#define COMMENT_RIGHTIMAGLE_WIDTH  (10.0f)
#define COMMENT_RIGHTIMAGLE_HIGTH  (44.0f)
#define COMMENT_NAME_WIDTH  (50.0f)
#define COMMENT_PHONE_WIDTH  (100.0f)
@implementation CXBuybackTrustCenterDetailCellFrame
- (id)initWithDataModel:(CXBuybackRecordModel *)dataModel
{
    if (self = [super init]) {
        _buybackRecordModel = dataModel;
        
    }
    
    return self;
}
- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kMiddleMargin+6;
        CGFloat y = ([self cellHeight]-COMMENT_IMAGE_WIDTH+10)/2;
        CGFloat width = COMMENT_IMAGE_WIDTH-10;
        CGFloat height = COMMENT_IMAGE_WIDTH-10;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)nameRect
{
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x+[self imageViewRect].size.width+ kLargeMargin;
        CGFloat y = ([self cellHeight]-kLabelHeight)/2;
        CGFloat width = COMMENT_NAME_WIDTH;
        CGFloat height = kLabelHeight;
        
        _nameRect = CGRectMake(x, y, width, height);
    }
    return _nameRect;
}
- (CGRect)phoneRect
{
    if (_phoneRect.size.width <= 0 && _phoneRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x + [self nameRect].size.width + kDefaultMargin;
        CGFloat y = ([self cellHeight]-kLabelHeight)/2;
        CGFloat width = COMMENT_PHONE_WIDTH;
        CGFloat height = kLabelHeight;
        _phoneRect = CGRectMake(x, y, width, height);
    }
    return _phoneRect;
}
- (CGRect)moneyRect
{
    if (_moneyRect.size.width <= 0 && _moneyRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-[self rightImageRect].size.width-COMMENT_PHONE_WIDTH-kLargeMargin;
        CGFloat y = [self cellHeight]/2-kSmallLabelHeight;
        CGFloat width = COMMENT_PHONE_WIDTH;
        CGFloat height = kSmallLabelHeight;
        
        _moneyRect = CGRectMake(x, y, width, height);
    }
    return _moneyRect;
}

- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-[self rightImageRect].size.width-COMMENT_PHONE_WIDTH-kLargeMargin;
        CGFloat y = [self moneyRect].origin.y+[self moneyRect].size.height;
        CGFloat width = COMMENT_PHONE_WIDTH;
        CGFloat height = kSmallLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}
- (CGRect)rightImageRect
{
    if (_rightImageRect.size.width <= 0 && _rightImageRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-kDefaultMargin-COMMENT_RIGHTIMAGLE_WIDTH;
        CGFloat y = ([self cellHeight]-COMMENT_RIGHTIMAGLE_HIGTH)/2;
        CGFloat width = COMMENT_RIGHTIMAGLE_WIDTH;
        CGFloat height = COMMENT_RIGHTIMAGLE_HIGTH;
        
        _rightImageRect = CGRectMake(x, y, width, height);
    }
    return _rightImageRect;
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
        
        CGFloat imageHeight = COMMENT_IMAGE_WIDTH+2*kDefaultMargin;
        
        height=imageHeight;
        _cellHeight = height;
    }
    return _cellHeight;
}



@end
