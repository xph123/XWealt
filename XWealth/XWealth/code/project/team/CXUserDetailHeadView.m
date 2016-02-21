//
//  CXUserDetailHeadView.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserDetailHeadView.h"


@implementation CXUserDetailHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor; [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _headImageView = [[UIImageView alloc] initWithFrame:[self headImageRect]];
    _headImageView.layer.cornerRadius = kRadius;
    _headImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:singleFingerOne];
    [self addSubview: _headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:[self nickNameRect]];
    _nameLabel.font = kLargeTextFont;
    _nameLabel.textColor = kTitleTextColor;
    _nameLabel.numberOfLines = 1;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    _nickNameLabel = [[UILabel alloc] initWithFrame:[self nickNameRect]];
    _nickNameLabel.font = kMiddleTextFont;
    _nickNameLabel.textColor = kAssistTextColor;
    _nickNameLabel.numberOfLines = 1;
    _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    _nickNameLabel.hidden = YES;
    [self addSubview:_nickNameLabel];

    
    _sexImageView = [[UIImageView alloc] initWithFrame:[self sexRect]];
    [self addSubview: _sexImageView];
    
}

- (void)setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    _nameLabel.frame = [self nameRect];
    _nameLabel.text = [_userModel getDisplayName];
    
    _sexImageView.frame = [self sexRect];
    if (_userModel.sex == 1)
    {
        [_sexImageView setImage:IMAGE(@"user_sex_female")];
    }
    else
    {
        [_sexImageView setImage:IMAGE(@"user_sex_male")];
    }
    
    if (_userModel.remarksName && _userModel.remarksName.length > 0)
    {
        _nickNameLabel.frame = [self nickNameRect];
        _nickNameLabel.text = [NSString stringWithFormat:@"%@：%@", StringNickname, _userModel.nickName ];
        _nickNameLabel.hidden = NO;
    }
    else
    {
        _nickNameLabel.hidden = YES;
    }
    
}

- (void) clickHeadImage
{
    __unsafe_unretained CXUserDetailHeadView *weak_self = self;
    if (weak_self.clickHeadImageBlk) {
        weak_self.clickHeadImageBlk();
    }
    
}

// 头像
- (CGRect) headImageRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = kMiddleMargin;
    
    CGFloat width = UserHeadWidth;
    CGFloat height = UserHeadHeight;
    
    return CGRectMake(x, y, width, height);
}

// 姓名
- (CGRect) nameRect
{
    CGFloat x = kDefaultMargin + kMiddleMargin + UserHeadWidth;
    CGFloat y = kMiddleMargin;
    
    CGFloat width = kScreenWidth - kDefaultMargin - x;
    
    if (self.userModel && [self.userModel getDisplayName].length > 0)
    {
        CGSize size = [self getNameSize];
        width = size.width + 10;
    }
    
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
}

// 性别
- (CGRect) sexRect
{
    CGRect rect = [self nameRect];
    CGFloat x = kDefaultMargin + rect.origin.x + rect.size.width;
    CGFloat y = rect.origin.y + kDefaultMargin;
    
    CGFloat width = kIconSmallWidth;
    CGFloat height = kIconSmallHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) nickNameRect
{
    CGFloat x = kDefaultMargin + kMiddleMargin + UserHeadWidth;
    CGFloat y = kMiddleMargin + kLabelHeight + kDefaultMargin;
    
    CGFloat width = kScreenWidth - kDefaultMargin - x;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGSize) getNameSize
{
    return [[self.userModel getDisplayName] getSizeWithWidth:(kScreenWidth / 2) fontSize:kLargeTextFontSize];
}

@end
