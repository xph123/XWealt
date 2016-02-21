//
//  CXBuybackTrustCenterDetailCell.h
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBuybackTrustCenterDetailCellFrame.h"
@interface CXBuybackTrustCenterDetailCell : UITableViewCell
@property (nonatomic, strong) CXBuybackRecordModel *buybackRecordModel;
@property (nonatomic, strong) CXBuybackTrustCenterDetailCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *datelineLabel;

@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) UIView *lineView;



@end
