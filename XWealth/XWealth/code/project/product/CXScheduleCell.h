//
//  CXScheduleCell.h
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductListScheduleModel.h"
#import "CXScheduleCellFrame.h"
@interface CXScheduleCell : UITableViewCell
@property (nonatomic, strong) CXProductListScheduleModel *productListScheduleModel;
@property (nonatomic, strong) CXScheduleCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;


@property (nonatomic, strong) UIImageView *roundImgView;
@property (nonatomic, strong) UIView *leftView;


@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UILabel *titlelabel;



@end
