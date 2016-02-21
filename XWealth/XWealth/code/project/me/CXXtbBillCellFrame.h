//
//  CXXtbBillCellFrame.h
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXtbBillCellFrame : NSObject

- (id)initWithDataModel:(CXXtbBillModel *)dataModel;

@property (nonatomic, strong) CXXtbBillModel *billModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect descRect;
@property (nonatomic, assign) CGRect balanceRect;

@end
