//
//  InformationCell.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationCellFrame.h"

@interface CXInformationCell : UITableViewCell
//样式2（默认）
@property (nonatomic, strong) CXInformationModel *informationModel;
@property (nonatomic, strong) CXInformationCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *goodsButton;
@property (strong, nonatomic) UIView *lineView;


@end
