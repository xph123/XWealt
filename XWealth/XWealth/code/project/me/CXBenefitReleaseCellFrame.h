//
//  CXBenefitReleaseCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/9/24.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBenefitReleaseCellFrame : NSObject
- (id)initWithDataModel:(CXBenefitModel *)BenefitModel;
@property (nonatomic, strong) CXBenefitModel *benefitModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat titlelabelHight;

@end
