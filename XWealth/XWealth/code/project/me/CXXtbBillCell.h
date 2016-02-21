//
//  CXXtbBillCell.h
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXXtbBillCellFrame.h"

@interface CXXtbBillCell : UITableViewCell

@property (nonatomic, strong) CXXtbBillModel *billModel;
@property (nonatomic, strong) CXXtbBillCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UILabel *desclabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@end
