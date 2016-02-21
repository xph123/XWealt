//
//  CXTrustTransferCenterCell.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXTrustTransferCenterCellFrame.h"
@interface CXTrustTransferCenterCell : UITableViewCell
@property (nonatomic, strong) CXBenefitModel *BenefitModel;
@property (nonatomic, strong) CXTrustTransferCenterCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UIImageView *backIma;

@property (nonatomic, strong) UIImageView *stateImageView;

@property (nonatomic, strong) UIView *upLine;
@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *identificationImage;

@property (nonatomic, strong) UILabel *preProfitLable;
@property (nonatomic, strong) UILabel *preProfitValueLable;
@property (nonatomic, strong) CXProductItemView *deadlineView;
@property (nonatomic, strong) CXProductItemView *moneyView;
@property (nonatomic, strong) CXProductItemView *profitView;





@property (nonatomic, strong) UIImageView *typeView;
@property (nonatomic, strong) UILabel *commentLabel;
@end
