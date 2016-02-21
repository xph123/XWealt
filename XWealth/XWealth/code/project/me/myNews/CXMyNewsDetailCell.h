//
//  CXMyNewsDetailCell.h
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyNewsDetailCellFrame.h"
@interface CXMyNewsDetailCell : UITableViewCell
@property (nonatomic, strong) CXNotificationModel *notificationModel;

@property (strong, nonatomic) UIView *cellView;

@property (strong, nonatomic) UIButton *timeBtn;
@property (strong, nonatomic) UIImageView *iconView;


@property (strong, nonatomic) UIImageView *contentBackView;


@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UIImageView *lineView;
@property (strong, nonatomic) UIImageView *rightImagle;

@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UIButton *firstBtn;
@property (strong, nonatomic) UIButton *secondBtn;


@end
