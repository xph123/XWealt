//
//  CXXtbInvestCell.h
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXXtbInvestCellFrame.h"

@interface CXXtbInvestCell : UITableViewCell

@property (nonatomic, strong) CXXtbInvestModel *investModel;
@property (nonatomic, strong) CXXtbInvestCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *intstRatelabel;
@property (nonatomic, strong) UIButton *stateBtn;
@property (nonatomic, strong) UILabel *inTimeLabel;
@property (nonatomic, strong) UILabel *intstLabel;
@property (nonatomic, strong) UILabel *investTimeLabel;
@property (nonatomic, strong) UILabel *invAmtLabel;

@end
