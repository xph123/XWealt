//
//  CXFriendCell.m
//  Link
//
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXFriendCell.h"

@implementation CXFriendCell

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
    
    CGRect rect = CGRectMake(kDefaultMargin, 0, kScreenWidth - 2 * kDefaultMargin, kUserCellHeight);
    
    CXUserView *userView = [[CXUserView alloc] initWithFrame:rect];
    [self addSubview:userView];
    self.userView = userView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kUserCellHeight-1, rect.size.width, 0.5)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void) setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
    
    [self.userView.headImg setImageWithURL:[NSURL URLWithString:self.userModel.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];

    self.userView.name.text = [_userModel getDisplayName];
}


@end
