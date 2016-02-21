//
//  XModifyInfoMutableLineCell.h
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TitleWidth          72
#define ContentWidth        190

@interface XModifyInfoMutableLineCell : UITableViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIView *line;

@property (assign, nonatomic) CGFloat cellHeight;

- (void)setTitle:(NSString *)title andContent:(NSString*)content;


@end
