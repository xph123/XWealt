//
//  CXHomePageFiveCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomePageFiveCellFrame : NSObject
- (id)initWithDataModel:(CXBuyBackModel *)BuyBackModel;
@property (nonatomic, strong) CXBuyBackModel *buyBackModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect backImaRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect identificationRect;
@property (nonatomic, assign) CGRect profitRect;
//@property (nonatomic, assign) CGRect deadlineValueRect;
@property (nonatomic, assign) CGRect deadlineRect;
@property (nonatomic, assign) CGRect investTypeRect;
@property (nonatomic, assign) CGRect firstGoalBarRect;


@property (nonatomic, assign) CGRect upLineRect;
@property (nonatomic, assign) CGRect downLineRect;
@property (nonatomic, assign) CGRect commentLabelRect;
@end
