//
//  CXMyNewsCell.h
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyNewsCellFrame.h"
@interface CXMyNewsCell : UITableViewCell
@property (nonatomic, strong) CXNotificationModel *notificationModel;
@property (nonatomic, strong) CXMyNewsCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UIButton *rightBtn;

@property (strong, nonatomic) UIView *lineView;
@end
