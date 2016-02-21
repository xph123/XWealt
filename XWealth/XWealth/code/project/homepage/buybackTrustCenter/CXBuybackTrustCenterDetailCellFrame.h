//
//  CXBuybackTrustCenterDetailCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBuybackTrustCenterDetailCellFrame : NSObject
- (id)initWithDataModel:(CXBuybackRecordModel *)dataModel;

@property (nonatomic, strong) CXBuybackRecordModel *buybackRecordModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect phoneRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect moneyRect;
@property (nonatomic, assign) CGRect rightImageRect;
@property (nonatomic, assign) CGRect lineRect;

@end
