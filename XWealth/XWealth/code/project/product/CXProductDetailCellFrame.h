//
//  CXProductDetailCellFrame.h
//  XWealth
//
//  Created by chx on 15-3-18.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductDetailCellFrame : NSObject

- (id)initWithDataModel:(CXTitleValueModel *)value1Model andValue2:(CXTitleValueModel*)value2Model andCol:(NSInteger)col;

@property (nonatomic, strong) CXTitleValueModel *value1Model;
@property (nonatomic, strong) CXTitleValueModel *value2Model;

@property (nonatomic, assign) NSInteger col;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellRect;
@property (nonatomic, assign) CGRect value1Rect;

@property (nonatomic, assign) CGRect titleView1Rect;
@property (nonatomic, assign) CGRect titleLabel1Rect;
@property (nonatomic, assign) CGRect valueImageRect;

@property (nonatomic, assign) CGRect value2Rect;
@property (nonatomic, assign) CGRect titleView2Rect;
@property (nonatomic, assign) CGRect titleLabel2Rect;

@end
