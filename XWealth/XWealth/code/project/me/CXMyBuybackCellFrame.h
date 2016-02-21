//
//  CXMyBuybackCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMyBuybackCellFrame : NSObject
- (id)initWithDataModel:(CXBuyBackModel *)BuyBackModel;
@property (nonatomic, strong) CXBuyBackModel *buyBackModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect deadlineRect;
@property (nonatomic, assign) CGRect profitRect;

@property (nonatomic, assign) CGRect stateRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect lineRect;
@end
