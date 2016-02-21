//
//  CXSelectRightCell.h
//  Link
//  选择cell，选择按钮在右边，图标是个打勾
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSelectRightCell : UITableViewCell

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *rightImageView;

@property (nonatomic, assign) BOOL isSelected;

- (void)setTitle:(NSString *)title andSelect:(int)isSelected;
@end
