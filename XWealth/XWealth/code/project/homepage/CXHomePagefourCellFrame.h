//
//  CXHomePagefourCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomePagefourCellFrame : NSObject
- (id)initWithDataModel:(CXBenefitModel *)BenefitModel;
@property (nonatomic, strong) CXBenefitModel *benefitModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect backImaRect;

@property (nonatomic, assign) CGRect stateImageViewRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect identificationRect;
@property (nonatomic, assign) CGRect preProfitRect;
@property (nonatomic, assign) CGRect preProfitValueRect;

@property (nonatomic, assign) CGRect profitRect;
@property (nonatomic, assign) CGRect deadlineRect;
@property (nonatomic, assign) CGRect moneyRect;



@property (nonatomic, assign) CGRect downLineRect;
@property (nonatomic, assign) CGRect commentLabelRect;
@end
