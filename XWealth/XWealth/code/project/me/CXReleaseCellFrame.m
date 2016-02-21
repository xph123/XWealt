//
//  CXReleaseCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/9/24.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXReleaseCellFrame.h"
#define STATE_IMAGE_WIDTH   (16.0f)
#define STATE_IMAGE_HEIGHT  (54.0f)
#define ITEMVIEW_MARGIN     (2.0f)
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define PROCESS_HEIGHT      (68.0f)
@implementation CXReleaseCellFrame
- (id)initWithDataModel:(CXProductReleaseModel *)releaseModel
{
    if (self = [super init]) {
        _releaseModel = releaseModel;
    }
    
    return self;
}
- (CGFloat) cellWidth
{
    return kScreenWidth - 2 * kDefaultMargin;
}
- (CGFloat)titlelabelHight
{
        CGFloat width = [self cellWidth] - 2 * kDefaultMargin;
        CGFloat height = kLabelHeight;
        CGSize size = [self.releaseModel.name getSizeWithWidth:width fontSize:kMiddleTextFontSize];
        
        if (size.height > kLabelHeight)
        {
            height = kTwoLineLabelHeight;
        }
        else
        {
            height = kLabelHeight;
        }
    return height;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = (kLabelHeight + 8) + ITEMVIEW_HEIGHT + [self titlelabelHight];
        
        _cellHeight = height;
    }
    return _cellHeight;
}
@end
