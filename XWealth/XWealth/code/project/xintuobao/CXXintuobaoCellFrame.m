//
//  CXXintuobaoCellFrame.m
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXintuobaoCellFrame.h"

#define ITEMVIEW_HEIGHT          (40.0f)//(20 + kLabelHeight)
#define PROGRESS_LINE_HEIGHT     (4.0f)
#define PROCESS_WIDTH       (68.0f)
#define PROCESS_HEIGHT      (68.0f)

@implementation CXXintuobaoCellFrame

- (id)initWithDataModel:(CXXintuoBaoModel *)dataModel
{
    if (self = [super init]) {
        _productModel = dataModel;
    }
    
    return self;
}
- (CGRect)nameLabelRect
{
    if (_nameLabelRect.size.width <= 0 && _nameLabelRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = kMinSmallMargin;
        CGFloat width = ([self cellWidth]-kLabelWidth)/2-kDefaultMargin-kMiddleMargin;
        CGFloat height = kLabelHeight;
        
        _nameLabelRect = CGRectMake(x, y, width, height);
    }
    return _nameLabelRect;
}
- (CGRect)nameTabLabelRect
{
    if (_nameTabLabelRect.size.width <= 0 && _nameTabLabelRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 2;
        CGFloat width = kLabelWidth;
        CGFloat height = kMiddleMargin;
        
        _nameTabLabelRect = CGRectMake(x, y, width, height);
    }
    return _nameTabLabelRect;
}
- (CGRect)nameTabLabelBackViewRect
{
    if (_nameTabLabelBackViewRect.size.width <= 0 && _nameTabLabelBackViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin+[self nameLabelRect].size.width+[self nameLabelRect].origin.x;
        CGFloat y = kMinSmallMargin+8;
        CGFloat width = kLabelWidth;
        CGFloat height = kMiddleMargin+4;
        
        _nameTabLabelBackViewRect = CGRectMake(x, y, width, height);
    }
    return _nameTabLabelBackViewRect;
}


- (CGRect)centreLineRect
{
    if (_centreLineRect.size.width <= 0 && _centreLineRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self nameLabelRect].origin.y + [self nameLabelRect].size.height;
        CGFloat width = [self cellWidth]-kDefaultMargin;
        CGFloat height = 1;
        
        _centreLineRect = CGRectMake(x, y, width, height);
    }
    return _centreLineRect;
}

- (CGRect)profitViewRect
{
    if (_profitViewRect.size.width <= 0 && _profitViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self centreLineRect].origin.y+kDefaultMargin;
        CGFloat width = kScreenWidth/3-kDefaultMargin;
        CGFloat height = kLabelHeight*2;
        
        _profitViewRect = CGRectMake(x, y, width, height);
    }
    return _profitViewRect;
}
- (CGRect)deadlineViewRect
{
    if (_deadlineViewRect.size.width <= 0 && _deadlineViewRect.size.height <= 0) {
        CGFloat x = kScreenWidth/3+kDefaultMargin;
        CGFloat y = [self centreLineRect].origin.y+kDefaultMargin;
        CGFloat width = kLabelWidth;
        CGFloat height = kLabelHeight;
        
        _deadlineViewRect = CGRectMake(x, y, width, height);
    }
    return _deadlineViewRect;
}

- (CGRect)deadlineValueViewRect
{
    if (_deadlineValueViewRect.size.width <= 0 && _deadlineValueViewRect.size.height <= 0) {
        CGFloat x = kScreenWidth/3*2;
        CGFloat y = [self centreLineRect].origin.y+kDefaultMargin;
        CGFloat width = kScreenWidth/3-kDefaultMargin;
        CGFloat height = kLabelHeight;
        
        _deadlineValueViewRect = CGRectMake(x, y, width, height);
    }
    return _deadlineValueViewRect;
}
- (CGRect)twoLineRect
{
    if (_twoLineRect.size.width <= 0 && _twoLineRect.size.height <= 0) {
        CGFloat x = kScreenWidth/3+kDefaultMargin;
        CGFloat y = [self deadlineViewRect].origin.y+[self deadlineViewRect].size.height;
        CGFloat width =  kScreenWidth/3*2-kDefaultMargin;
        CGFloat height = 0.5;
        
        _twoLineRect = CGRectMake(x, y, width, height);
    }
    return _twoLineRect;
}


- (CGRect)scaleLabelRect
{
    if (_scaleLabelRect.size.width <= 0 && _scaleLabelRect.size.height <= 0) {
        CGFloat x = kScreenWidth/3+kDefaultMargin;
        CGFloat y = [self twoLineRect].origin.y;
        CGFloat width = kLabelWidth;
        CGFloat height = kLabelHeight;
        
        _scaleLabelRect = CGRectMake(x, y, width, height);
    }
    return _scaleLabelRect;
}
- (CGRect)scaleValueLabelRect
{
    if (_scaleValueLabelRect.size.width <= 0 && _scaleValueLabelRect.size.height <= 0) {
        CGFloat x = kScreenWidth/3*2;
        CGFloat y = [self twoLineRect].origin.y;
        CGFloat width = kScreenWidth/3-kDefaultMargin;
        CGFloat height = kLabelHeight;

        
        _scaleValueLabelRect = CGRectMake(x, y, width, height);
    }
    return _scaleValueLabelRect;
}
-(CGRect)upLineRect
{
    if (_upLineRect.size.width <= 0 && _upLineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        _upLineRect = CGRectMake(x, y, width, height);
    }
    
    return _upLineRect;
}
- (CGRect)downLineRect
{
    if (_downLineRect.size.width <= 0 && _downLineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self cellHeight]-kDefaultMargin-0.5;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _downLineRect = CGRectMake(x, y, width, height);
    }
    return _downLineRect;
}

- (CGRect)backViewRect
{
    if (_backViewRect.size.width <= 0 && _backViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = kScreenWidth;
        CGFloat height = [self cellHeight]-kDefaultMargin;
        
        
        _backViewRect = CGRectMake(x, y, width, height);
    }
    return _backViewRect;
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
        
        //CGFloat height = (kLabelHeight * 2) + ITEMVIEW_HEIGHT  + kDefaultMargin;
        CGFloat height = [self nameLabelRect].size.height+[self profitViewRect].size.height+kDefaultMargin+kMiddleMargin;
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
