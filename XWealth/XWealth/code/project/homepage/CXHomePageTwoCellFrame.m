//
//  CXHomePageTwoCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageTwoCellFrame.h"

@implementation CXHomePageTwoCellFrame

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
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
        int backWidth=kScreenWidth-2*kDefaultMargin;
        CGFloat height = 0;
        height = kLabelHeight*5+backWidth/2+backWidth/2/3.5+kDefaultMargin*3;
        
        _cellHeight = height;
    }
    return _cellHeight;

}
@end
