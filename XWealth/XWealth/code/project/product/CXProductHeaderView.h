//
//  CXProductHeaderView.h
//  XWealth
//
//  Created by chx on 15-4-14.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

@interface CXProductHeaderView : UIView

@property (strong, nonatomic) KDGoalBar *firstGoalBar;
@property (strong, nonatomic) CXProductModel *productModel;

@property (nonatomic, assign) CGFloat headViewHeight;

@property (nonatomic, copy) ActionClickBlk costBtnBlk;

- (id)initWithFrame:(CGRect)frame andProduct:(CXProductModel*)productModel;

@end
