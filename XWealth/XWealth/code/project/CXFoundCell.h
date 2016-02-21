//
//  CXFoundCell.h
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXFoundCell : UITableViewCell
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
