//
//  CXTrustTransferCenterDetailCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTrustTransferCenterDetailCellFrame : NSObject
- (id)initWithDataModel:(CXBenefitRecordModel *)dataModel;

@property (nonatomic, strong) CXBenefitRecordModel *benefitRecordModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect phoneRect;
@property (nonatomic, assign) CGRect datelineRect;

@property (nonatomic, assign) CGRect lineRect;
@end
