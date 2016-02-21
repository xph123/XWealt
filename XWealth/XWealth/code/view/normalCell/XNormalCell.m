//
//  XNormalCell.m
//  XWealth
//
//  Created by chx on 15/7/8.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "XNormalCell.h"

@implementation XNormalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
        self.backgroundColor = kControlBgColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)initSubviews
{
    //    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, 2, SCREEN_WIDTH - 2 * DefaultMargin, MenuHeight - 4)];
    //    [_bgImageView setImage:[UIImage imageNamed:@"roundrect_background"]];
    //    [self addSubview: _bgImageView];
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , kExtMenuHeight)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_menuView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, 0, kScreenWidth / 2, kExtMenuHeight)];
    _titleLabel.font = kMenuTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth -  kDefaultMargin-10, 0, 10, kExtMenuHeight)];
    [_rightImageView setImage:[UIImage imageNamed:@"list_right"]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_menuView addSubview: _rightImageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kExtMenuHeight - 0.25, kScreenWidth -  kDefaultMargin, 0.5)];
    
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}


@end
