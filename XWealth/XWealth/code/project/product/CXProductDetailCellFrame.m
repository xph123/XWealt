//
//  CXProductDetailCellFrame.m
//  XWealth
//
//  Created by chx on 15-3-18.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductDetailCellFrame.h"

@implementation CXProductDetailCellFrame

- (id)initWithDataModel:(CXTitleValueModel *)value1Model andValue2:(CXTitleValueModel*)value2Model andCol:(NSInteger)col
{
    if (self = [super init]) {
        _value1Model = value1Model;
        _value2Model = value2Model;
        _col = col;
    }
    
    return self;
}

- (CGRect)titleView1Rect
{
    if (_titleView1Rect.size.width <= 0 && _titleView1Rect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self titleViewWidth];
        CGFloat height = [self cellHeight] - 1;
        
        _titleView1Rect = CGRectMake(x, y, width, height);
    }
    return _titleView1Rect;
}

- (CGRect)titleLabel1Rect
{
    if (_titleLabel1Rect.size.width <= 0 && _titleLabel1Rect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        
        CGFloat width = [self titleViewWidth] - 2 * kDefaultMargin;
        CGFloat height = [self cellHeight] - 1;
        
        _titleLabel1Rect = CGRectMake(x, y, width, height);
    }
    return _titleLabel1Rect;
}
- (CGRect)valueImageRect
{
    if (self.value1Model.imageValue!=nil&&![self.value1Model.imageValue isEqualToString:@""]) {
        if (_valueImageRect.size.width <= 0 && _valueImageRect.size.height <= 0) {
            CGFloat x = [self titleViewWidth] + kDefaultMargin;
            CGFloat y = kDefaultMargin;
            CGFloat width = [self viewWidth] - [self titleViewWidth] - 2 * kDefaultMargin;
            CGFloat height = [self viewWidth] - [self titleViewWidth] - 2 * kDefaultMargin;
            
            _valueImageRect = CGRectMake(x, y, width, height);
        }
    }
    else
    {
         _valueImageRect = CGRectMake(0, 0, 0, 0);
    }
    return _valueImageRect;
}
- (CGRect)value1Rect
{
    if (_value1Rect.size.width <= 0 && _value1Rect.size.height <= 0) {
        CGFloat x = [self titleViewWidth] + kDefaultMargin;
        CGFloat y = [self valueImageRect].origin.y+[self valueImageRect].size.height+kDefaultMargin;
        
        CGFloat width = [self viewWidth] - [self titleViewWidth] - 2 * kDefaultMargin;
        CGFloat height = kTwoLineLabelHeight;
        
//        CGFloat dymanicHeight = 0;
        if (self.col == 1)
        {
            UILabel *value1Label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            value1Label.font = kMiddleTextFont;
            value1Label.numberOfLines = 0;
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.value1Model.value];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:4];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.value1Model.value.length)];
            
            value1Label.attributedText = attributedString;
            //调节高度
            CGSize size = CGSizeMake(width, 500000);
            
            CGSize labelSize = [value1Label sizeThatFits:size];
            
            if (labelSize.height > height)
            {
                height = labelSize.height + kDefaultMargin*2;
            }
            
//            dymanicHeight = [self.value1Model.value getSizeWithWidth:width fontSize:kMiddleTextFontSize].height + 10;
//            if (dymanicHeight > height)
//            {
//                height = dymanicHeight;
//            }
        }
        
        _value1Rect = CGRectMake(x, y, width, height);
    }
    return _value1Rect;
}

- (CGRect)titleView2Rect
{
    if (_titleView2Rect.size.width <= 0 && _titleView2Rect.size.height <= 0) {
        CGFloat x = [self viewWidth];
        CGFloat y = 0;
        
        CGFloat width = [self titleViewWidth];
        CGFloat height = [self cellHeight] - 1;
        
        _titleView2Rect = CGRectMake(x, y, width, height);
    }
    return _titleView2Rect;
}

- (CGRect)titleLabel2Rect
{
    if (_titleLabel2Rect.size.width <= 0 && _titleLabel2Rect.size.height <= 0) {
        CGFloat x = [self titleView2Rect].origin.x + kDefaultMargin;
        CGFloat y = kDefaultMargin;
        
        CGFloat width = [self titleViewWidth] - 2 * kDefaultMargin;
        CGFloat height = [self titleView2Rect].size.height;
        
        _titleLabel2Rect = CGRectMake(x, y, width, height);
    }
    return _titleLabel2Rect;
}

- (CGRect)value2Rect
{
    if (_value2Rect.size.width <= 0 && _value2Rect.size.height <= 0) {
        CGFloat x = [self titleView2Rect].origin.x +  [self titleView2Rect].size.width + kDefaultMargin;
        CGFloat y = 0;
        
        CGFloat width = [self viewWidth] - [self titleViewWidth] - 2 * kDefaultMargin;
        CGFloat height = kTwoLineLabelHeight;
    
        _value2Rect = CGRectMake(x, y, width, height);
    }
    return _value2Rect;
}

- (CGFloat) titleViewWidth
{
    return 80;
}

- (CGRect)cellRect
{
    if (_cellRect.size.width <= 0 && _cellRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 0.5;
        
        _cellRect = CGRectMake(x, y, width, height);
    }
    return _cellRect;
}

- (CGFloat) viewWidth
{
    CGFloat width = 0;
    
    if (_col == 1)
    {
        width = [self cellWidth];
    }
    else
    {
        width = [self cellWidth] / 2;
    }
    return width;
}

- (CGFloat) cellWidth
{
    return kScreenWidth;
}

- (CGFloat) cellHeight
{
    return [self value1Rect].size.height+[self value1Rect].origin.y;
}


@end
