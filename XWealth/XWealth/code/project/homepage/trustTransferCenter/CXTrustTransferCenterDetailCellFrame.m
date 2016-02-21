//
//  CXTrustTransferCenterDetailCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterDetailCellFrame.h"
#define COMMENT_IMAGE_WIDTH  (40.0f)
#define COMMENT_RIGHTIMAGLE_WIDTH  (10.0f)
#define COMMENT_RIGHTIMAGLE_HIGTH  (44.0f)
#define COMMENT_NAME_WIDTH  (50.0f)
#define COMMENT_PHONE_WIDTH  (100.0f)
@implementation CXTrustTransferCenterDetailCellFrame
- (id)initWithDataModel:(CXBenefitRecordModel *)dataModel
{
    if (self = [super init]) {
        _benefitRecordModel = dataModel;
        
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


- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-COMMENT_PHONE_WIDTH-kDefaultMargin;
        CGFloat y = ([self cellHeight]-kSmallLabelHeight)/2;
        CGFloat width = COMMENT_PHONE_WIDTH;
        CGFloat height = kSmallLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
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
        
        CGFloat imageHeight = COMMENT_IMAGE_WIDTH+kDefaultMargin*2;
        
        height=imageHeight;
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
