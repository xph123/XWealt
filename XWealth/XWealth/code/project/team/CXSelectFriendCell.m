//
//  CXSelectFriendCell.m
//  Link
//
//  Created by chx on 14-11-19.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSelectFriendCell.h"

@implementation CXSelectFriendCell

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
    
    _cellView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, kScreenWidth - 2 * kDefaultMargin, kSelectFriendCellHeight)];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    CGFloat y = (kSelectFriendCellHeight - kRadioButtonHeight) / 2;
    CGRect selRect = CGRectMake(kDefaultMargin, y, kRadioButtonWidth, kRadioButtonHeight);
    
    UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:selRect];
    [selectImageView setImage:IMAGE(@"checkbox_uncheck")];
    [_cellView addSubview:selectImageView];
    self.selectImageView = selectImageView;

    CGRect rect = CGRectMake(kRadioButtonWidth + 2 * kDefaultMargin, 0, kScreenWidth - 56, kSelectFriendCellHeight);
    
    CXUserView *userView = [[CXUserView alloc] initWithFrame:rect];
    [_cellView addSubview:userView];
    self.userView = userView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kSelectFriendCellHeight-1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    line.backgroundColor = kLineColor;
    [_cellView addSubview:line];
}

- (void) setSelectModel:(CXSelectFriendStruct *)selectModel
{
    _selectModel = selectModel;
    
    [self.userView.headImg sd_setImageWithURL:[NSURL URLWithString:self.selectModel.userModel.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    self.userView.name.text = self.selectModel.userModel.nickName;
    
    if (self.selectModel.isSelected == 2)
    {
        [_selectImageView setImage:IMAGE(@"checkbox_already_checked")];
    }
    else if (self.selectModel.isSelected == 1)
    {
        [_selectImageView setImage:IMAGE(@"checkbox_checked")];
    }
    else
    {
        [_selectImageView setImage:IMAGE(@"checkbox_uncheck")];
    }
}

@end
