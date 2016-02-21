//
//  CXBenefitReleaseCell.h
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXBenefitReleaseCellFrame.h"
@interface CXBenefitReleaseCell : UITableViewCell

@property (nonatomic, strong) CXBenefitModel *BenefitModel;
@property (nonatomic, strong) CXBenefitReleaseCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) CXProductItemView *deadlineView;
@property (nonatomic, strong) CXProductItemView *moneyView;
@property (nonatomic, strong) CXProductItemView *profitView;

@property (nonatomic, strong) UIView *verticalLine1;
@property (nonatomic, strong) UIView *verticalLine2;
@property (nonatomic, strong) UIView *horizoncalLine2;

@property (nonatomic, strong) UILabel *statelabel;
@property (nonatomic, strong) UILabel *datelineLabel;

@end
