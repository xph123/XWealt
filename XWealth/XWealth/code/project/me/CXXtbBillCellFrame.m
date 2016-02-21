//
//  CXXtbBillCellFrame.m
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbBillCellFrame.h"

@implementation CXXtbBillCellFrame

- (id)initWithDataModel:(CXXtbBillModel *)dataModel
{
    if (self = [super init]) {
        _billModel = dataModel;
        
    }
    
    return self;
}

- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = 45;
        CGFloat height = 45;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = [self imageViewRect].origin.x + [self imageViewRect].size.width + kDefaultMargin;
        CGFloat y = kDefaultMargin;
        CGFloat width = [self cellWidth] - 4 * kDefaultMargin - [self imageViewRect].size.width - 60;
        CGFloat height = kLabelHeight;
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x + [self titleRect].size.width + kDefaultMargin;
        CGFloat y = [self titleRect].origin.y;
        CGFloat width = 60;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

- (CGRect)descRect
{
    if (_descRect.size.width <= 0 && _descRect.size.height <= 0) {
        CGFloat x = [self titleRect].origin.x;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        CGFloat width = [self titleRect].size.width;
        CGFloat height = kSmallLabelHeight;
        
        _descRect = CGRectMake(x, y, width, height);
    }
    return _descRect;
}

- (CGRect)balanceRect
{
    if (_balanceRect.size.width <= 0 && _balanceRect.size.height <= 0) {
        CGFloat width = 0;
        CGFloat height = kSmallLabelHeight;
        
        if (self.billModel.balance && self.billModel.balance.length > 0)
        {
            NSString *balanceStr = [NSString stringWithFormat:@"投后余额：%@", self.billModel.balance];
            CGSize size = [balanceStr getSizeWithWidth:200 fontSize:kSmallTextFontSize];
            
            width = size.width;
        }
        
        CGFloat x = [self cellWidth] - kDefaultMargin - width;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height;
        
        _balanceRect = CGRectMake(x, y, width, height);
    }
    return _balanceRect;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 0.5;
        
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
        
        CGFloat imageHeight = [self imageViewRect].size.height + 2 * kDefaultMargin;
        
        CGFloat connentHeight = 2 * kDefaultMargin + kLabelHeight + kSmallLabelHeight;
        
        height = imageHeight > connentHeight ? imageHeight : connentHeight;
        
        _cellHeight = height;
    }
    
    return _cellHeight;
}

@end
