//
//  CXModifyInfoCell.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XModifyInfoCell.h"


@implementation XModifyInfoCell

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
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kExtMenuHeight)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_menuView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, 0, TitleWidth, kExtMenuHeight)];
    _titleLabel.font = kMenuTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_menuView addSubview:_titleLabel];
    
    CGFloat contentLabelX = kScreenWidth- ContentWidth-kDefaultMargin*2-10;
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelX, 0, ContentWidth, kExtMenuHeight)];
    _contentLabel.font = kLargeTextFont;
    _contentLabel.textColor = kAssistTextColor;
    _contentLabel.numberOfLines = 1;
    _contentLabel.textAlignment = NSTextAlignmentRight;
    [_menuView addSubview:_contentLabel];
    
    CGFloat imageX = kScreenWidth- UserHeadWidth-kDefaultMargin*2-10;
    UIImageView *headBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, kDefaultMargin, UserHeadWidth, UserHeadHeight)];
    headBgImgView.image = IMAGE(@"head_bg");
    [_menuView addSubview:headBgImgView];
    _headBgImgView = headBgImgView;
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX + 4, kDefaultMargin + 4, UserHeadWidth - 8, UserHeadHeight - 8)];
    _headImageView.layer.cornerRadius = 10;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClickAction:)];
    [_headImageView addGestureRecognizer:singleTap];
    [_menuView addSubview: _headImageView];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth -  kDefaultMargin - 10, 0, 10, kExtMenuHeight)];
    [_rightImageView setImage:[UIImage imageNamed:@"list_right"]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_menuView addSubview: _rightImageView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, kExtMenuHeight - 0.25, kScreenWidth - kMiddleMargin, 0.5)];
    self.line = line;
    
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void) imgViewClickAction:(NSString *) banner
{
    __unsafe_unretained XModifyInfoCell *weak_self = self;
    if (weak_self.imgViewBlk) {
        weak_self.imgViewBlk();
    }
}

- (void)setTitle:(NSString *)title andContent:(NSString*)content
{
    _title = title;
    _titleLabel.text = _title;
    
    _content = content;
    _contentLabel.text = _content;
    _contentLabel.hidden = NO;
    
    _headImageView.hidden = YES;
    _headBgImgView.hidden = YES;
}

- (void)setTitle:(NSString *)title andImageUrl:(NSString*)imageUrl
{
    _title = title;
    _titleLabel.text = _title;
    
    _contentLabel.hidden = YES;
    
    [_headImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"head_default"]];
    _headImageView.hidden = NO;
    _headBgImgView.hidden = NO;
    
    _menuView.frame = CGRectMake(0, 0, kScreenWidth , HeadCellHeight);
    _line.frame = CGRectMake(kMiddleMargin, HeadCellHeight - 0.25, kScreenWidth - kMiddleMargin, 0.5);
}

@end
