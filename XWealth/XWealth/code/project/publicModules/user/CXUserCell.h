//
//  CXUserCell.h
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXUserCell : UITableViewCell

@property (nonatomic, strong) CXUserModel *userModel;

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *name;
@property (strong, nonatomic) UILabel *signatureLabel;

@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UIView *line;

@end
