//
//  CXProductCell.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductCellFrame.h"
#import "CXProductItemView.h"
#import "KDGoalSimpleBar.h"

@interface CXProductCell : UITableViewCell

@property (nonatomic, strong) CXProductSimplyModel *sProductModel;
@property (nonatomic, strong) CXProductCellFrame *layout;

//背景图片
@property(nonatomic,strong) UIImageView *backImage;
@property (strong, nonatomic) UIView *cellView;
// 类型 期限 收益
// 投向
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UILabel *titlelabel;
//@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) CXProductItemView *categoryView;
@property (nonatomic, strong) CXProductItemView *deadlineView;
@property (nonatomic, strong) CXProductItemView *profitView;
//@property (nonatomic, strong) UILabel *moneyToLabel;

//@property (nonatomic, strong) UIView *verticalLine1;
//@property (nonatomic, strong) UIView *verticalLine2;

//@property (nonatomic, strong) UIView *horizoncalLine1;
@property (nonatomic, strong) UIView *horizoncalLine2;

@property (nonatomic, strong) UILabel *commentLabel;

@property (strong, nonatomic) KDGoalSimpleBar *firstGoalBar;
@property (strong, nonatomic) UIImageView *RoundIma;
// @property (strong, nonatomic) UIView *lineView;

@end
