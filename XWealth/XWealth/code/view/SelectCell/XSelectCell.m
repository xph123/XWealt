//
//  XSelectCell.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XSelectCell.h"

@implementation XSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    
    _cellView = [[UIView alloc] initWithFrame:[self cellViewRect]];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:[self seleteImageRect]];
    [selectImageView setImage:IMAGE(@"round_selector_normal")];
    [_cellView addSubview:selectImageView];
    self.selectImageView = selectImageView;
    
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:[self imageRect]];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 4;
    [_cellView addSubview:headImg];
    self.headImg = headImg;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:[self contentLabelRect]];
    contentLabel.textColor = kTextColor;
    contentLabel.backgroundColor = kColorClear;
    contentLabel.font = kLargeTextFont;
    [_cellView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kSelectFriendCellHeight-1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    line.backgroundColor = kLineColor;
    [_cellView addSubview:line];
}

- (void) setContent:(NSString *)content andImageUrl:(NSString *)imageUrl andIsSelected:(BOOL) isSelected
{
    _content = content;
    _imageUrl = imageUrl;
    _isSelected = isSelected;
    
    if (_imageUrl && _imageUrl.length > 0)
    {
        self.headImg.frame = [self imageRect];
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.headImg.hidden = NO;
    }
    else
    {
        self.headImg.hidden = YES;
    }
    
    self.contentLabel.frame = [self contentLabelRect];
    self.contentLabel.text = self.content;
    
    if (self.isSelected)
    {
        [_selectImageView setImage:IMAGE(@"round_selector_checked")];
    }
    else
    {
        [_selectImageView setImage:IMAGE(@"round_selector_normal")];
    }

}

- (CGRect) cellViewRect
{
    return CGRectMake(kDefaultMargin, 0, kScreenWidth - 2 * kDefaultMargin, kSelectFriendCellHeight);
}

- (CGRect) seleteImageRect
{
    CGFloat y = (kSelectFriendCellHeight - kRadioButtonHeight) / 2;
    CGRect selRect = CGRectMake(kDefaultMargin, y, kRadioButtonWidth, kRadioButtonHeight);
    
    return selRect;
}

- (CGRect) imageRect
{
    CGFloat x = kDefaultMargin * 2 + kRadioButtonWidth;
    CGFloat width = 0;
    CGFloat height = 0;
    
    if (_imageUrl && _imageUrl.length > 0)
    {
        width = kIconMiddleWidth;
        height = kIconMiddleHeight;
    }
    
    return CGRectMake(x, kDefaultMargin, width, height);
}

- (CGRect) contentLabelRect
{
    CGFloat width = kScreenWidth - 5 * kDefaultMargin - kRadioButtonWidth;
    CGFloat x = kDefaultMargin * 2 + kRadioButtonWidth;
    
    if (_imageUrl && _imageUrl.length > 0)
    {
        x += kIconMiddleWidth + kDefaultMargin;
        width -= kIconMiddleWidth + kDefaultMargin;
    }
    
    return CGRectMake(x, kDefaultMargin, width, kIconMiddleHeight);
}

@end
