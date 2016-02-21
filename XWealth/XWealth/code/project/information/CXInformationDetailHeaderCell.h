//
//  CXInformationDetailHeaderCell.h
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationDetailHeaderFrame.h"

@interface CXInformationDetailHeaderCell : UITableViewCell

@property (nonatomic, strong) CXInformationModel * informationModel;

@property (nonatomic, strong) CXInformationDetailHeaderFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *datelineLabel;

@property (strong, nonatomic) UIView *lineView;

@end
