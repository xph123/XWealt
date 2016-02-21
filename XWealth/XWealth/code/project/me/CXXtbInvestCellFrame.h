//
//  CXXtbInvestCellFrame.h
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXtbInvestCellFrame : NSObject

- (id)initWithDataModel:(CXXtbInvestModel *)dataModel;

@property (nonatomic, strong) CXXtbInvestModel *investModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect intstRateRect;
@property (nonatomic, assign) CGRect stateRect;
@property (nonatomic, assign) CGRect inTimeRect;
@property (nonatomic, assign) CGRect intstRect;
@property (nonatomic, assign) CGRect investTimeRect;
@property (nonatomic, assign) CGRect invAmtRect;
@end
