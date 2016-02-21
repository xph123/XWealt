//
//  CXAddFriendFrame.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXAddFriendFrame.h"

@implementation CXAddFriendFrame

- (id)initWithDataModel:(CXApplyModel *)dataModel
{
    if (self = [super init]) {
        _applyModel = dataModel;
    }
    return self;
    
}

- (CGRect)headImgRect
{
    if (_headImgRect.size.width <= 0 && _headImgRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        
        CGFloat width = kUserHeadImgWidth;
        CGFloat height = kUserHeadImgHeight;
        
        _headImgRect = CGRectMake(x, y, width, height);
    }
    return _headImgRect;
}

- (CGRect)nameRect
{
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        
        CGFloat x = [self headImgRect].size.width + 2 * kDefaultMargin;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin - x - 50;

        CGFloat y = kDefaultMargin;
        
        CGFloat height = kLabelHeight;
        
        _nameRect = CGRectMake(x, y, width, height);
    }
    return _nameRect;
}

- (CGRect)signatureRect
{
    if (_signatureRect.size.width <= 0 && _signatureRect.size.height <= 0) {
        
        CGFloat x = [self nameRect].origin.x;
        CGFloat width = [self nameRect].size.width;
        
        CGFloat y = kDefaultMargin + kLabelHeight;
        
        CGFloat height = 0;
        
        if (_applyModel.signature && _applyModel.signature.length > 0)
        {
            CGSize size = [_applyModel.signature getSizeWithWidth:width fontSize:kMiddleTextFontSize];
            
            height = size.height + 1;
        }
        
        _signatureRect = CGRectMake(x, y, width, height);
    }
    return _signatureRect;
}


- (CGRect)addFriendBtnRect
{
    if (_addFriendBtnRect.size.width <= 0 && _addFriendBtnRect.size.height <= 0) {
        CGFloat width = 50;
        CGFloat x = kScreenWidth - 3 * kDefaultMargin - width;
        CGFloat y = ([self cellHeight] - kButtonHeight)/2;
        
        CGFloat height = 30;
        
        _addFriendBtnRect = CGRectMake(x, y, width, height);
    }
    return _addFriendBtnRect;
}

- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self cellHeight] - 1;
        
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    return _lineRect;
}

// ----------------------- cell视图
- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight];
        
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
        
        CGFloat height = 0;
        
        height = [self headImgRect].size.height + 2 * kDefaultMargin;
        
        CGFloat txtHeight = 0;
        if ([self signatureRect].size.height  > 0)
        {
            txtHeight = 3 * kDefaultMargin + kLabelHeight + [self signatureRect].size.height;
        }
        
        if (txtHeight > height)
        {
            height = txtHeight;
        }
       
        
        _cellHeight = height;
    }
    return _cellHeight;
}



@end
