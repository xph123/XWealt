//
//  CXScheduleCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXProductListScheduleModel.h"

@interface CXScheduleCellFrame : NSObject
- (id)initWithDataModel:(CXProductListScheduleModel *)dataModel;

@property (nonatomic, strong) CXProductListScheduleModel *productListScheduleModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect roundImgViewRect;
@property (nonatomic, assign) CGRect leftViewRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;

@end
