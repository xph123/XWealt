//
//  CXSelectRightCell.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XSelectRightCell.h"

@implementation XSelectRightCell

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
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, kScreenWidth - 2 * kDefaultMargin, kMenuHeight)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_menuView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, 0, kScreenWidth / 2, kMenuHeight)];
    _titleLabel.font = kLargeTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 3 * kDefaultMargin - 21, 0, 21, kMenuHeight)];
    [_rightImageView setImage:[UIImage imageNamed:@"right_select"]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    _rightImageView.hidden = YES;
    [_menuView addSubview: _rightImageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kMenuHeight - 1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void)setTitle:(NSString *)title andSelect:(int)isSelected
{
    _title = title;
    _titleLabel.text = _title;
    _isSelected = isSelected;
    
    if (_isSelected)
    {
        _rightImageView.hidden = NO;
    }
    else
    {
        _rightImageView.hidden = YES;
    }
    
}



@end
