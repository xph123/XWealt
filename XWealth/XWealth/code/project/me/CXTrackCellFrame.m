//
//  CXTrackCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/8/25.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXTrackCellFrame.h"
#define STATE_IMAGE_WIDTH   (16.0f)
#define STATE_IMAGE_HEIGHT  (54.0f)
#define ITEMVIEW_MARGIN     (2.0f)
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define PROCESS_HEIGHT      (68.0f)
@implementation CXTrackCellFrame
- (id)initWithDataModel:(CXTrackModel *)dataModel
{
    if (self = [super init]) {
        _trackModel = dataModel;
    }
    
    return self;
}
- (CGRect)cellViewRect
{
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    _cellViewRect = CGRectMake(kMiddleMargin, 0, cellWidth, [self cellHeight]-kMiddleMargin);
    return _cellViewRect;
}
- (CGRect)payerLabelRect
{
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    _payerLabelRect = CGRectMake(kDefaultMargin, kLabelHeight+ kSmallLabelHeight*2+kDefaultMargin, cellWidth - 2 * kDefaultMargin, kSmallLabelHeight);
    return _payerLabelRect;
}
- (CGRect)statelabelRect
{
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    _statelabelRect = CGRectMake(kDefaultMargin, [self payerLabelRect].origin.y+[self payerLabelRect].size.height, cellWidth/2 - 2 * kDefaultMargin, kSmallLabelHeight);
    return _statelabelRect;
}
- (CGRect)datelineLabelRect
{
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    _datelineLabelRect= CGRectMake(kDefaultMargin, [self statelabelRect].origin.y+[self statelabelRect].size.height, cellWidth/2 - 2 * kDefaultMargin, kSmallLabelHeight);
    return _datelineLabelRect;
}

- (CGRect)lineRect
{
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    _lineRect= CGRectMake(kDefaultMargin, [self datelineLabelRect].origin.y+[self datelineLabelRect].size.height+kSmallMargin, cellWidth - 2 * kDefaultMargin, 1);
    return _lineRect;
}

- (CGRect)remarkLabelRect
{
    
    if (_remarkLabelRect.size.width <= 0 && _remarkLabelRect.size.height <= 0) {
        CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
        CGFloat x = kDefaultMargin;
        CGFloat y = [self lineRect].origin.y+[self lineRect].size.height;
        CGFloat width = cellWidth - 2 * kDefaultMargin;
        CGFloat height = 0;
       
        if (![self.trackModel.remark isEqualToString:@""]) {
             CGSize size = [self.trackModel.remark getSizeWithWidth:width fontSize:kSmallTextFontSize];
            height=size.height+kMiddleMargin;
        }
       
        _remarkLabelRect = CGRectMake(x, y, width, height);
    }
    return _remarkLabelRect;

}


- (CGFloat) cellHeight
{
    CGFloat height = [self remarkLabelRect].origin.y+[self remarkLabelRect].size.height+kMiddleMargin;
    return height;
}
@end
