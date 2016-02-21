//
//  CXHomePageSixCell.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXHomePageSixCellFrame.h"
#import "CXProductItemView.h"
#import "KDGoalSimpleBar.h"
@interface CXHomePageSixCell : UICollectionViewCell
@property (nonatomic, strong) CXXintuoBaoModel *xintuoBaoModel;
@property (nonatomic, strong) CXHomePageSixCellFrame *layout;

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
