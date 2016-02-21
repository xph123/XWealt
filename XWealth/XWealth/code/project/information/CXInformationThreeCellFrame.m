//
//  CXInformationThreeCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/10/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXInformationThreeCellFrame.h"

#define COMMENT_BUTTON_WIDTH  (50.0f)

@implementation CXInformationThreeCellFrame
- (id)initWithDataModel:(CXInformationModel *)dataModel
{
    if (self = [super init]) {
        _informationModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)imageViewOne
{
    if (_imageViewOne.size.width <= 0 && _imageViewOne.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self titleRect].size.height;
        CGFloat width = ([self cellWidth]-4*kDefaultMargin)/3;
        CGFloat height = width/1.36;
        _imageViewOne = CGRectMake(x, y, width, height);
    }
    
    return _imageViewOne;
}

- (CGRect)imageViewTwo
{
    if (_imageViewTwo.size.width <= 0 && _imageViewTwo.size.height <= 0) {
        CGFloat x = [self imageViewOne].origin.x+[self imageViewOne].size.width+kDefaultMargin;
        CGFloat y = [self titleRect].size.height;
        CGFloat width = ([self cellWidth]-4*kDefaultMargin)/3;
        CGFloat height = width/1.36;
        _imageViewTwo = CGRectMake(x, y, width, height);
    }
    
    return _imageViewTwo;
}
- (CGRect)imageViewThree
{
    if (_imageViewThree.size.width <= 0 && _imageViewThree.size.height <= 0) {
        CGFloat x = [self imageViewTwo].origin.x+[self imageViewTwo].size.width+kDefaultMargin;
        CGFloat y = [self titleRect].size.height;
        CGFloat width = ([self cellWidth]-4*kDefaultMargin)/3;
        CGFloat height = width/1.36;
        _imageViewThree = CGRectMake(x, y, width, height);
    }
    
    return _imageViewThree;
}
- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin ;
        CGFloat height = kLabelHeight+5;
        
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
        CGFloat x = kDefaultMargin;
        CGFloat y = [self imageViewOne].origin.y+[self imageViewOne].size.height;
        CGFloat width = 100;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

- (CGRect)commentsRect
{
    if (_commentsRect.size.width <= 0 && _commentsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - kDefaultMargin - COMMENT_BUTTON_WIDTH;
        CGFloat y = [self imageViewOne].origin.y+[self imageViewOne].size.height;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = kLabelHeight;
        
        _commentsRect = CGRectMake(x, y, width, height);
    }
    return _commentsRect;
}

- (CGRect)goodsRect
{
    if (_goodsRect.size.width <= 0 && _goodsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - (kDefaultMargin + COMMENT_BUTTON_WIDTH) * 2;
        CGFloat y = [self imageViewOne].origin.y+[self imageViewOne].size.height;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = kLabelHeight;
        
        _goodsRect = CGRectMake(x, y, width, height);
    }
    return _goodsRect;
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
        
        CGFloat imageHeight = [self imageViewOne].size.height ;
        CGFloat titleHeght  = [self titleRect].size.height;
        
        CGFloat connentHeight = kLabelHeight;
        
        height = imageHeight +titleHeght+connentHeight;
        
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
