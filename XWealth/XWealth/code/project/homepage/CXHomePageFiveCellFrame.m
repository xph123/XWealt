//
//  CXHomePageFiveCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageFiveCellFrame.h"
#define ITEMVIEW_MARGIN     (2.0f)
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (105.0f)
#define PROCESS_HEIGHT      (68.0f)
#define TITLE_HEIGHT     (45.0)
@implementation CXHomePageFiveCellFrame
- (id)initWithDataModel:(CXBuyBackModel *)BuyBackModel
{
    if (self = [super init]) {
        _buyBackModel = BuyBackModel;
    }
    
    return self;
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
- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kMiddleMargin;
        CGFloat y = 0;
        CGFloat width = [self cellWidth]-2*kMiddleMargin-30;
        CGFloat height = kLabelHeight;
        _titleRect = CGRectMake(x, y, width, height);
    }
    
    return _titleRect;
}
- (CGRect)identificationRect
{
    if (_identificationRect.size.width <= 0 && _identificationRect.size.height <= 0) {
        CGFloat x = [self cellWidth]-30-kSmallMargin;
        CGFloat y = kSmallMargin;
        CGFloat width = 30;
        CGFloat height = 30;
        _identificationRect = CGRectMake(x, y, width, height);
    }
    
    return _identificationRect;
}
- (CGRect)profitRect
{
    if (_profitRect.size.width <= 0 && _profitRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self titleRect].size.height+[self titleRect].origin.y;
        CGFloat width = [self cellWidth]/9*2;
        CGFloat height = TITLE_HEIGHT;
        _profitRect = CGRectMake(x, y, width, height);
    }
    
    return _profitRect;
}
- (CGRect)deadlineRect
{
    if (_deadlineRect.size.width <= 0 && _deadlineRect.size.height <= 0) {
        CGFloat x = [self profitRect].size.width+[self profitRect].origin.x;
        CGFloat y = [self titleRect].size.height+[self titleRect].origin.y;
        CGFloat width = [self cellWidth]/9*2;
        CGFloat height = TITLE_HEIGHT;
        
        
        
        _deadlineRect = CGRectMake(x, y, width, height);
    }
    return _deadlineRect;
}
- (CGRect)investTypeRect
{
    if (_investTypeRect.size.width <= 0 && _investTypeRect.size.height <= 0) {
        CGFloat x = [self deadlineRect].size.width+[self deadlineRect].origin.x;
        CGFloat y = [self titleRect].size.height+[self titleRect].origin.y;
        CGFloat width =[self cellWidth]/9*2;
        CGFloat height = TITLE_HEIGHT;
        _investTypeRect = CGRectMake(x, y, width, height);
    }
    return _investTypeRect;
}

- (CGRect)firstGoalBarRect
{
    if (_firstGoalBarRect.size.width <= 0 && _firstGoalBarRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/3*2+([self cellWidth]/3*1-ITEMVIEW_HEIGHT)/2;
        CGFloat y = kSmallLabelHeight;
        CGFloat width = ITEMVIEW_HEIGHT;
        CGFloat height = ITEMVIEW_HEIGHT;
        
        _firstGoalBarRect = CGRectMake(x, y, width, height);
    }
    return _firstGoalBarRect;
}

- (CGRect)downLineRect
{
    if (_downLineRect.size.width <= 0 && _downLineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self deadlineRect].origin.y + [self deadlineRect].size.height+kSmallMargin;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _downLineRect = CGRectMake(x, y, width, height);
    }
    return _downLineRect;
}
- (CGRect)commentLabelRect
{
    if (_commentLabelRect.size.width <= 0 && _commentLabelRect.size.height <= 0) {
        
        CGFloat x = kDefaultMargin;
        CGFloat y = [self downLineRect].origin.y + 1;
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin;
        CGFloat height = kLabelHeight;
        
        CGSize size = [self.buyBackModel.comment getSizeWithWidth:width fontSize:kSmallTextFontSize];
        
        if (size.height > kSmallLabelHeight)
        {
            height = kTwoLineLabelHeight;
        }
        else
        {
            height = kLabelHeight;
        }
        if ([self.buyBackModel.comment isEqualToString:@""]||self.buyBackModel.comment==nil)
        {
            height = 0;
        }
        _commentLabelRect = CGRectMake(x, y, width, height);
    }
    return _commentLabelRect;
}

- (CGRect)backImaRect
{
    if (_backImaRect.size.width <= 0 && _backImaRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight];
        
        _backImaRect = CGRectMake(x, y, width, height);
    }
    return _backImaRect;
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
    return kScreenWidth-2*kDefaultMargin;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = 0;
        
        height=[self titleRect].size.height+[self profitRect].size.height+ [self commentLabelRect].size.height+kDefaultMargin;
        _cellHeight = height;
    }
    return _cellHeight;
}
@end
