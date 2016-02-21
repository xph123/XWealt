//
//  CXBuybackTrustCenterCell.h
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXBuybackTrustCenterCellFrame.h"
#import "KDGoalSimpleBar.h"
@interface CXBuybackTrustCenterCell : UITableViewCell

@property (nonatomic, strong) CXBuyBackModel  *buyBackModel;

@property (nonatomic, strong) CXBuybackTrustCenterCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UIImageView *backIma;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *identificationImage;
//@property (nonatomic, strong) UILabel *deadlineLabel;
//@property (nonatomic, strong) UILabel *deadlineValueLabel;
//@property (nonatomic, strong) UILabel *profitLabel;
//@property (nonatomic, strong) UILabel *investTypeLable;

@property (nonatomic, strong) CXProductItemView *profitView;
@property (nonatomic, strong) CXProductItemView *deadlineView;
@property (nonatomic, strong) CXProductItemView *investTypeView;
@property (strong, nonatomic) KDGoalSimpleBar *firstGoalBar;

@property (nonatomic, strong) UIView *upLine;
@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UILabel *commentLabel;

@end
