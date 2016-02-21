//
//  CXTrustTransferCenterDetailCell.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationModel.h"
#import "CXTrustTransferCenterDetailCellFrame.h"
@interface CXTrustTransferCenterDetailCell : UITableViewCell
@property (nonatomic, strong) CXBenefitRecordModel *benefitRecordModel;
@property (nonatomic, strong) CXTrustTransferCenterDetailCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *datelineLabel;



@property (strong, nonatomic) UIView *lineView;


@end
