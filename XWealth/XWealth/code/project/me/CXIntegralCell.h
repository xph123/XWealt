//
//  CXIntegralCell.h
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXIntegralFrame.h"

@interface CXIntegralCell : UITableViewCell

@property (nonatomic, strong) CXIntegralModel *integralModel;
@property (nonatomic, strong) CXIntegralFrame *layout;

@property (strong, nonatomic) UIView *cellView;


@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (strong, nonatomic) UIView *lineView;

@end
