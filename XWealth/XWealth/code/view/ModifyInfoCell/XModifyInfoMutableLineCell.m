//
//  XModifyInfoMutableLineCell.m
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XModifyInfoMutableLineCell.h"

@implementation XModifyInfoMutableLineCell

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
    _titleLabel.font = kLargeTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin*2 + TitleWidth, 0, ContentWidth, kMenuHeight)];
    _contentLabel.font = kLargeTextFont;
    _contentLabel.textColor = kAssistTextColor;
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_contentLabel];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 3 * kDefaultMargin - 10, 0, 10, kMenuHeight)];
    [_rightImageView setImage:[UIImage imageNamed:@"list_right"]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_menuView addSubview: _rightImageView];
}

- (void)setTitle:(NSString *)title andContent:(NSString*)content
{
    _title = title;
    _titleLabel.text = _title;
    
    _content = content;
    _contentLabel.text = _content;
    
    CGSize size = [_content getSizeWithWidth:ContentWidth fontSize:kLargeTextFontSize];
    _cellHeight = size.height + 1 + 2 * kDefaultMargin;
    if (_cellHeight < kMenuHeight)
    {
        _cellHeight = kMenuHeight;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    CGRect frame = _contentLabel.frame;
    frame.size.height = _cellHeight;
    _contentLabel.frame = frame;
    
    CGRect cellFrame = _menuView.frame;
    cellFrame.size.height = _cellHeight;
    _menuView.frame = cellFrame;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, _cellHeight - 1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    self.line = line;
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (CGFloat) cellHeight
{
    return _cellHeight;
}
@end
