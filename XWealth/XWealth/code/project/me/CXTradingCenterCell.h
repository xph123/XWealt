//
//  CXTradingCenterCell.h
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXTradingCenterCell : UITableViewCell
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIView *line;

@property (assign, nonatomic) BOOL lineBool;// 判断是否有线

- (void)setTitle:(NSString *)title andImage:(NSString*)imageName;
@end
