//
//  CXUserDetailCell.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserDetailCell.h"

#define TitleWidth          72
#define ContentWidth        210

@implementation CXUserDetailCell

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
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, TitleWidth, kMenuHeight)];
    _titleLabel.font = kMiddleTextFont;
    _titleLabel.textColor = kTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin*2 + TitleWidth, 0, ContentWidth, kMenuHeight)];
    _contentLabel.font = kMiddleTextFont;
    _contentLabel.textColor = kAssistTextColor;
    _contentLabel.numberOfLines = 1;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_contentLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kMenuHeight - 1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    self.line = line;
    
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void)setTitle:(NSString *)title andContent:(NSString*)content
{
    _title = title;
    _titleLabel.text = _title;
    
    _content = content;
    _contentLabel.text = _content;
}


@end
