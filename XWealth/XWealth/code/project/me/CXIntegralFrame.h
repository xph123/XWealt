//
//  CXIntegralFrame.h
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXIntegralFrame : NSObject

- (id)initWithDataModel:(CXIntegralModel *)dataModel;

@property (nonatomic, strong) CXIntegralModel *integralModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;

@end
