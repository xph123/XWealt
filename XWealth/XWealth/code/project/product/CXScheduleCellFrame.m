//
//  CXScheduleCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXScheduleCellFrame.h"
#define COMMENT_BUTTON_WIDTH  (50.0f)
@implementation CXScheduleCellFrame
- (id)initWithDataModel:(CXProductListScheduleModel *)dataModel
{
    if (self = [super init]) {
        _productListScheduleModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)roundImgViewRect
{
    if (_roundImgViewRect.size.width <= 0 && _roundImgViewRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/2-kIconSmallWidth/2;
        CGFloat y = kDefaultMargin;
        CGFloat width = kIconSmallWidth;
        CGFloat height = kIconSmallWidth;
        _roundImgViewRect = CGRectMake(x, y, width, height);
    }
    
    return _roundImgViewRect;
}
- (CGRect)leftViewRect
{
    if (_leftViewRect.size.width <= 0 && _leftViewRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/2-kMinSmallMargin/2;
        CGFloat y = [self roundImgViewRect].origin.y+[self roundImgViewRect].size.height+kDefaultMargin;
        CGFloat width = kMinSmallMargin;
        CGFloat height = kThreadHeight;
        _leftViewRect = CGRectMake(x, y, width, height);
    }
    
    return _leftViewRect;
}
- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x =[self roundImgViewRect].size.width+[self roundImgViewRect].origin.x+kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = [self cellWidth]/2-kDefaultMargin-kIconWidth/2;
        CGFloat height = kLabelHeight;
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = [self cellWidth]/2-kDefaultMargin*2-kIconWidth/2;
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
        
        CGFloat imageHeight = [self roundImgViewRect].size.height+[self leftViewRect].size.height + kSmallMargin*3+kSmallMargin;
        
        
        height=imageHeight;
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
