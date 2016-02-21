//
//  CXExpertCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXExpertCellFrame.h"
#define COMMENT_BUTTON_WIDTH  (50.0f)
@implementation CXExpertCellFrame
- (id)initWithDataModel:(CXExpertModel *)expertModel;
{
    if (self = [super init]) {
        _expertModel = expertModel;
        
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
- (CGRect)nameRect
{
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = 5;
        CGFloat width = [self cellWidth] - 3 * kDefaultMargin - [self imageViewRect].size.width;
        CGFloat height = kLabelHeight;
        _nameRect = CGRectMake(x, y, width, height);
    }
    return _nameRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = [self nameRect].origin.y+[self nameRect].size.height;
        CGFloat width = [self cellWidth] - 3 * kDefaultMargin - [self imageViewRect].size.width;
        CGFloat height = kLabelHeight;
        CGSize size = [self.expertModel.signature getSizeWithWidth:width fontSize:kMiddleTextFontSize];
        
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
