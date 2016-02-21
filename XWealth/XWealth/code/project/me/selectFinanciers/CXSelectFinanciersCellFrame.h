//
//  CXSelectFinanciersCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSelectFinanciersCellFrame : NSObject
- (id)initWithDataModel:(CXFinanciersModel *)dataModel;

@property (nonatomic, strong) CXFinanciersModel *financiersModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect authenticationRect;
@property (nonatomic, assign) CGRect tradeRect;

@property (nonatomic, assign) CGRect specialtyRect;
@property (nonatomic, assign) CGRect recordRect;
@property (nonatomic, assign) CGRect serviceRect;
@property (nonatomic, assign) CGRect moneyRect;
@property (nonatomic, assign) CGRect numberRect;


@property (nonatomic, assign) CGRect lineRect;
@end
