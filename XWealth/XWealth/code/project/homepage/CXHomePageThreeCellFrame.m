//
//  CXHomePageThreeCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageThreeCellFrame.h"

@implementation CXHomePageThreeCellFrame
- (id)initWithDataModel:(CXProductModel *)dataModel
{
    if (self = [super init]) {
        _productModel = dataModel;
        
    }
    
    return self;
}
- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = kScreenWidth;
        CGFloat height = kScreenWidth/3;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
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
        height = [self imageViewRect].size.height;
        
        _cellHeight = height;
    }
    return _cellHeight;
}
@end
