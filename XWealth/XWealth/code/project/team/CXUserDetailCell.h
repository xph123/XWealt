//
//  CXUserDetailCell.h
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXUserDetailCell : UITableViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *line;

- (void)setTitle:(NSString *)title andContent:(NSString*)content;


@end
