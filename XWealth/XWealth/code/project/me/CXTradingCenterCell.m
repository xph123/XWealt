//
//  CXTradingCenterCell.m
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTradingCenterCell.h"

@implementation CXTradingCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = kControlBgColor;
        self.lineBool=YES;
        [self initSubviews];
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
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMiddleMargin, (kExtMenuHeight - kIconHeight) / 2, kIconSmallWidth+5, kIconSmallHeight+5)];
    [_logoImageView setImage:[UIImage imageNamed:@"defaule_image"]];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_menuView addSubview: _logoImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin*2  + kIconWidth, 0, kScreenWidth / 2, kExtMenuHeight)];
    _titleLabel.font = kMenuTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 3 * kDefaultMargin, kExtMenuHeight-kExtMenuHeight, 10, kExtMenuHeight)];
    [_rightImageView setImage:[UIImage imageNamed:@"list_right"]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_menuView addSubview: _rightImageView];
    
    
    
    
}

- (void)setTitle:(NSString *)title andImage:(NSString*)imageName
{
    _title = title;
    _titleLabel.text = _title;
    
    [_logoImageView setImage:[UIImage imageNamed:imageName]];
    if (self.line != nil)
    {
        [self.line removeFromSuperview];
    }
    
    if (self.lineBool==YES) {
        self.line = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, kExtMenuHeight-0.5 , kScreenWidth -kMiddleMargin, 0.5)];
        self.line.backgroundColor = kLineColor;
        [self addSubview:self.line];
    }
    
    
}

@end
