//
//  CXTrustTransferCenterCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterCellFrame.h"
#define STATE_IMAGE_WIDTH   (16.0f)
#define STATE_IMAGE_HEIGHT  (54.0f)

#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)
#define IMAGE_STATE         (44.0f)
#define TITLE_HEIGHT        (45.0)
@implementation CXTrustTransferCenterCellFrame
- (id)initWithDataModel:(CXBenefitModel *)BenefitModel
{
    if (self = [super init]) {
        _benefitModel = BenefitModel;
    }
    
    return self;
}
- (CGRect)stateImageViewRect
{
    if (_stateImageViewRect.size.width <= 0 && _stateImageViewRect.size.height <= 0) {
        CGFloat width = STATE_IMAGE_WIDTH;
        CGFloat height = STATE_IMAGE_HEIGHT;
        CGFloat x = - 4;
        CGFloat y = kMiddleMargin;
        
        _stateImageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _stateImageViewRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kMiddleMargin+kDefaultMargin;
        CGFloat y = 0;
        CGFloat width = [self cellWidth]-2*(kMiddleMargin+kDefaultMargin)-30;
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
- (CGRect)preProfitRect
{
    if (_preProfitRect.size.width <= 0 && _preProfitRect.size.height <= 0) {
        CGFloat x = 20;
        CGFloat y = [self titleRect].size.height+[self titleRect].origin.y-5;
        CGFloat width = [self cellWidth]/2;
        CGFloat height = kLabelHeight;
        _preProfitRect = CGRectMake(x, y, width, height);
    }
    
    return _preProfitRect;
}
- (CGRect)preProfitValueRect
{
    if (_preProfitValueRect.size.width <= 0 && _preProfitValueRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/2+20;
        CGFloat y = [self titleRect].size.height+[self titleRect].origin.y-5;
        CGFloat width = [self cellWidth]/3;
        CGFloat height = kLabelHeight;
        _preProfitValueRect = CGRectMake(x, y, width, height);
    }
    
    return _preProfitValueRect;
}
- (CGRect)profitRect
{
    if (_profitRect.size.width <= 0 && _profitRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self preProfitRect].size.height+[self preProfitRect].origin.y;
        CGFloat width = [self cellWidth]/3;
        CGFloat height = ITEMVIEW_HEIGHT;
        _profitRect = CGRectMake(x, y, width, height);
    }
    
    return _profitRect;
}
- (CGRect)deadlineRect
{
    if (_deadlineRect.size.width <= 0 && _deadlineRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/3;
        CGFloat y = [self preProfitRect].size.height+[self preProfitRect].origin.y;
        CGFloat width = [self cellWidth]/3;
        CGFloat height = TITLE_HEIGHT;
        
        
        
        _deadlineRect = CGRectMake(x, y, width, height);
    }
    return _deadlineRect;
}
- (CGRect)moneyRect
{
    if (_moneyRect.size.width <= 0 && _moneyRect.size.height <= 0) {
        CGFloat x = [self cellWidth]/3*2;
        CGFloat y = [self preProfitRect].size.height+[self preProfitRect].origin.y;
        CGFloat width =[self cellWidth]/3;
        CGFloat height = TITLE_HEIGHT;
        _moneyRect = CGRectMake(x, y, width, height);
    }
    return _moneyRect;
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
        
        CGSize size = [self.benefitModel.comment getSizeWithWidth:width fontSize:kSmallTextFontSize];
        
        if (size.height > kSmallLabelHeight)
        {
            height = kTwoLineLabelHeight;
        }
        else
        {
            height = kLabelHeight;
        }
         if ([self.benefitModel.comment isEqualToString:@""]||self.benefitModel.comment==nil)
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
        
        CGFloat height = kLabelHeight  + ITEMVIEW_HEIGHT + [self titleRect].size.height+ [self commentLabelRect].size.height+kMinSmallMargin;
        
        _cellHeight = height;
    }
    return _cellHeight;
}

@end
