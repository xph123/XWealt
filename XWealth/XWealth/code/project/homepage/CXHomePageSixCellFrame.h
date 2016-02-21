//
//  CXHomePageSixCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomePageSixCellFrame : NSObject
- (id)initWithDataModel:(CXXintuoBaoModel *)dataModel;
@property (nonatomic, strong) CXXintuoBaoModel *productModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect backViewRect;



@property (nonatomic, assign) CGRect nameLabelRect;
@property (nonatomic, assign) CGRect nameTabLabelRect;
@property (nonatomic, assign) CGRect nameTabLabelBackViewRect;


@property (nonatomic, assign) CGRect centreLineRect;

@property (nonatomic, assign) CGRect profitViewRect;
@property (nonatomic, assign) CGRect deadlineViewRect;
@property (nonatomic, assign) CGRect deadlineValueViewRect;

@property (nonatomic, assign) CGRect twoLineRect;

@property (nonatomic, assign) CGRect scaleLabelRect;
@property (nonatomic, assign) CGRect scaleValueLabelRect;

@property (nonatomic, assign) CGRect upLineRect;
@property (nonatomic, assign) CGRect downLineRect;

@end
