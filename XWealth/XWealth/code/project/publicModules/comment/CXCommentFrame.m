//
//  CXCommentFrame.m
//  Link
//
//  Created by chx on 14-11-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCommentFrame.h"

@implementation CXCommentFrame

- (id)initWithDataModel:(CXCommentModel *)dataModel
{
    if (self = [super init]) {
        _commentModel = dataModel;
        
    }
    return self;
    
}

- (CGRect)headRect
{
    if (_headRect.size.width <= 0 && _headRect.size.height <= 0) {
        _headRect = CGRectMake(kDefaultMargin, kDefaultMargin, kUserHeadImgWidth, kUserHeadImgHeight);
    }
    
    return _headRect;
}

- (CGRect)nameRect
{
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        CGFloat x = 2 * kDefaultMargin + kUserHeadImgWidth;
        CGFloat y = kDefaultMargin;
        CGFloat width = kScreenWidth - x - kDefaultMargin - [self datelineRect].size.width;
        CGFloat height = 16;
        
        _nameRect = CGRectMake(x, y, width, height);
    }
    
    return _nameRect;
}

- (CGRect)contentRect
{
    if (_contentRect.size.width <= 0 && _contentRect.size.height <= 0) {
        CGFloat x = [self nameRect].origin.x;
        CGFloat y = 2 * kDefaultMargin + 16;
        CGFloat width = kScreenWidth - 3 * kDefaultMargin - [self headRect].size.width;
        CGFloat height = 0;
        
        if (self.commentModel.content.length > 0)
        {
            CGSize size = [self.commentModel.content getSizeWithWidth:width fontSize:kMiddleTextFontSize];
            height = size.height + 1;
        }
        
        _contentRect = CGRectMake(x, y, width, height);
    }
    
    return _contentRect;
}


- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        
        CGFloat width = 0;
        if (self.commentModel.dateline.length > 0)
        {
            CGSize size = [self.commentModel.dateline getSizeWithWidth:width fontSize:kMiddleTextFontSize];
            width = size.width + 1;
        }
        
        CGFloat x =  kScreenWidth - kDefaultMargin - width;
        CGFloat y = kDefaultMargin;
        CGFloat height = 16;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    
    return _datelineRect;
}


- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self cellHeight] - 1;
        CGFloat width = kScreenWidth;
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    
    return _lineRect;
}


- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = 3 * kDefaultMargin + [self nameRect].size.height + [self contentRect].size.height;
        
        CGFloat imgHeight = 2 * kDefaultMargin + [self headRect].size.height;
        
        if (imgHeight > height)
        {
            height = imgHeight;
        }
    
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
