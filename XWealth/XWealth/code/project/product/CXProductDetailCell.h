//
//  CXProductDetailCell.h
//  XWealth
//
//  Created by chx on 15-3-18.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductDetailCellFrame.h"

@interface CXProductDetailCell : UITableViewCell

@property (nonatomic, strong) CXTitleValueModel *firstValueModel;
@property (nonatomic, strong) CXTitleValueModel *secondValueModel;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) CXProductDetailCellFrame *layout;

@property (nonatomic, strong) UIView *title1View;
@property (nonatomic, strong) UILabel *title1Label;
@property (nonatomic, strong) UILabel *value1Label;
@property (nonatomic, strong) UIImageView *valueImage;

@property (nonatomic, strong) UIView *title2View;
@property (nonatomic, strong) UILabel *title2Label;
@property (nonatomic, strong) UILabel *value2Label;

-(void) setValue1:(CXTitleValueModel*)value1 andValue2:(CXTitleValueModel*)value2;

@end
