//
//  CXClassroomCollectionCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomCollectionCellFrame.h"

#define COMMENT_BUTTON_WIDTH  (30.0f)
#define COMMENT_BUTTON_HEIGHT  (15.0f)

@implementation CXClassroomCollectionCellFrame
- (id)initWithDataModel:(CXCourseModel *)dataModel
{
    if (self = [super init]) {
        _courseModel = dataModel;
        
    }
    
    return self;
}


- (CGRect)imageViewRect
{
    if (_imageViewRect.size.width <= 0 && _imageViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = KFCollectionViewCellWidth;
        CGFloat height = KFCollectionViewCellWidth;
        _imageViewRect = CGRectMake(x, y, width, height);
    }
    
    return _imageViewRect;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = kMinSmallMargin;
        CGFloat y = [self imageViewRect].size.height+kMinSmallMargin;
        CGFloat width = [self cellWidth] - kMinSmallMargin*2;
        CGFloat height = kSmallLabelHeight;
        CGSize size = [self.courseModel.name getSizeWithWidth:width fontSize:kSmallTextFontSize];
        
        if (size.height > kSmallLabelHeight)
        {
            height = kLabelHeight;
        }
        else
        {
            height = kSmallLabelHeight;
        }
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}


- (CGRect)commentsRect
{
    if (_commentsRect.size.width <= 0 && _commentsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - kSmallMargin - COMMENT_BUTTON_WIDTH;
        CGFloat y = KFCollectionViewCellWidth+kMinSmallMargin+kLabelHeight;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = COMMENT_BUTTON_HEIGHT;
        
        _commentsRect = CGRectMake(x, y, width, height);
    }
    return _commentsRect;
}

- (CGRect)goodsRect
{
    if (_goodsRect.size.width <= 0 && _goodsRect.size.height <= 0) {
        CGFloat x = [self cellWidth] - (kSmallMargin + COMMENT_BUTTON_WIDTH) * 2;
        CGFloat y = KFCollectionViewCellWidth+kMinSmallMargin+kLabelHeight;
        CGFloat width = COMMENT_BUTTON_WIDTH;
        CGFloat height = COMMENT_BUTTON_HEIGHT;
        
        _goodsRect = CGRectMake(x, y, width, height);
    }
    return _goodsRect;
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
    return KFCollectionViewCellWidth;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = [self imageViewRect].size.height+kLabelHeight+[self commentsRect].size.height+kSmallMargin-2;
        
        _cellHeight = height;
    }
    return _cellHeight;
}
@end
