//
//  CXXintuobaoCell.h
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXXintuobaoCellFrame.h"
#import "CXProductItemView.h"
#import "KDGoalSimpleBar.h"

@interface CXXintuobaoCell : UITableViewCell

@property (nonatomic, strong) CXXintuoBaoModel *productModel;
@property (nonatomic, strong) CXXintuobaoCellFrame *layout;

//背景图片
@property (strong, nonatomic) UIView *cellView;

@property (strong, nonatomic) UIView *backView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nameTabLabel;
@property (nonatomic, strong) UIView *nameTabLabelBackView;


@property (nonatomic, strong) UIView *centreLine;

@property (nonatomic, strong) CXProductItemView *profitView;

@property (nonatomic, strong) UILabel *deadlineView;
@property (nonatomic, strong) UILabel *deadlineValueView;
@property (nonatomic, strong) UIView *twoLine;
@property (nonatomic, strong) UILabel *scaleLabel;
@property (nonatomic, strong) UILabel *scaleValueLabel;

@property (nonatomic, strong) UIView *upLine;
@property (nonatomic, strong) UIView *downLine;

@end
