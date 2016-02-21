//
//  CXSubscribeCell.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
@interface CXSubscribeCell : UITableViewCell

@property (nonatomic, strong) CXSubscribeModel *subscribeModel;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) CXProductItemView *moneyView;
@property (nonatomic, strong) CXProductItemView *nameView;
@property (nonatomic, strong) CXProductItemView *paymentView;

@property (nonatomic, strong) UIView *verticalLine1;
@property (nonatomic, strong) UIView *verticalLine2;
@property (nonatomic, strong) UIView *horizoncalLine2;



@property (nonatomic, strong) UILabel *statelabel;
@property (nonatomic, strong) UILabel *datelineLabel;

@end
