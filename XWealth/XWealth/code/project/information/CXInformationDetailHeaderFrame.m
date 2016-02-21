//
//  CXInformationDetailHeaderFrame.m
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationDetailHeaderFrame.h"

@implementation CXInformationDetailHeaderFrame

- (id)initWithDataModel:(CXInformationModel *)dataModel
{
    if (self = [super init]) {
        _informationModel = dataModel;
    }
    
    return self;
}

- (CGRect)titleRect
{
    if (_titleRect.size.width <= 0 && _titleRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = [self cellWidth];
        CGFloat height = [self.informationModel.name getSizeWithWidth:width fontSize:kLargeTextFontSize].height + 5;
        
        _titleRect = CGRectMake(x, y, width, height);
    }
    return _titleRect;
}

- (CGRect)sourceRect
{
    if (_sourceRect.size.width <= 0 && _sourceRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self titleRect].origin.y + [self titleRect].size.height + kDefaultMargin;
         NSString *source = [NSString stringWithFormat:@"%@:%@", @"来源", self.informationModel.source];
        CGFloat width = [source getSizeWithWidth:200 fontSize:kSmallTextFontSize].width + 5;
        CGFloat height = kLabelHeight;
        
        _sourceRect = CGRectMake(x, y, width, height);
    }
    return _sourceRect;
}

- (CGRect)authorRect
{
    if (_authorRect.size.width <= 0 && _authorRect.size.height <= 0) {
        CGFloat x = [self sourceRect].origin.x + [self sourceRect].size.width + kDefaultMargin;
        CGFloat y = [self sourceRect].origin.y;
        NSString *author = [NSString stringWithFormat:@"%@:%@", @"作者", self.informationModel.author];
        CGFloat width = [author getSizeWithWidth:200 fontSize:kSmallTextFontSize].width + 5;
        CGFloat height = kLabelHeight;
        
        _authorRect = CGRectMake(x, y, width, height);
    }
    return _authorRect;
}


- (CGRect)datelineRect
{
    if (_datelineRect.size.width <= 0 && _datelineRect.size.height <= 0) {
        CGFloat x = [self authorRect].origin.x + [self authorRect].size.width + kDefaultMargin;
        CGFloat y = [self authorRect].origin.y;
        CGFloat width = [self cellWidth] - [self sourceRect].size.width - [self authorRect].size.width - 4 * kDefaultMargin;
        CGFloat height = kLabelHeight;
        
        _datelineRect = CGRectMake(x, y, width, height);
    }
    return _datelineRect;
}

- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self cellHeight] - 1;
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    return _lineRect;
}

// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight] - 1;
        
        _cellViewRect = CGRectMake(x, y, width, height);
    }
    return _cellViewRect;
}

- (CGFloat) cellWidth
{
    return kScreenWidth - 2 * kDefaultMargin;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = [self titleRect].size.height + kLabelHeight + kDefaultMargin * 2;
        
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
