//
//  CXMeMenuCell.h
//  Link
//  我的菜单的cell  格式：" 标题      > "
//  Created by chx on 14-12-2.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXMeMenuCell : UITableViewCell

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) UIView *upline;
@property (strong, nonatomic) UIView *downline;

@property (assign, nonatomic) BOOL uplineBool;// 判断是否有线
@property (assign, nonatomic) BOOL downlineBool;// 判断是否有线

- (void)setTitle:(NSString *)title andImage:(NSString*)imageName;

@end
