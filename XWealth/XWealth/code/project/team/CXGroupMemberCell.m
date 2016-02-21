//
//  CXGroupMemberCell.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupMemberCell.h"

@implementation CXGroupMemberCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
    }
    
    return self;
    
}

- (void)initSubviews
{
    _userName = [[UILabel alloc] initWithFrame:[self userNameRect]];
    _userName.font = kSmallTextFont;
    _userName.textColor = kTextColor;
    _userName.numberOfLines = 1;
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.backgroundColor = [UIColor clearColor];
    [self addSubview:_userName];
    
    _headImageView = [[UIImageView alloc] initWithFrame:[self headImageRect]];
    _headImageView.contentMode = UIViewContentModeScaleToFill; // UIViewContentModeScaleAspectFit;
    _headImageView.backgroundColor = [UIColor clearColor];
    [self addSubview: _headImageView];
    
}


- (void) setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
    
    _userName.text = [_userModel getDisplayName];
    
    // 添加按钮
    if (userModel.userId == 0)
    {
        [_headImageView setImage:IMAGE(userModel.headImg)];
    }
    // 用户
    else
    {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];
    }
    
}

- (CGRect) headImageRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = kDefaultMargin;
    
    CGFloat width = kGridCellWidth - 2 * kDefaultMargin;
    CGFloat height = width;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) userNameRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = kGridCellHeight - kGridCellTextHeight;
    
    CGFloat width = kGridCellWidth - 2 * kDefaultMargin;
    CGFloat height = kGridCellTextHeight;
    
    return CGRectMake(x, y, width, height);
}


@end
