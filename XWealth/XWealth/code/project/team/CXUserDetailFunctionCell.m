//
//  CXUserDetailFunctionCell.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserDetailFunctionCell.h"

#define ButtonX     10
#define ButtonWidth (kScreenWidth - 2 * ButtonX)

@implementation CXUserDetailFunctionCell

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
    _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addFriendBtn.frame = CGRectMake(ButtonX, kLargeMargin, ButtonWidth, kButtonHeight);
    [_addFriendBtn setBackgroundColor:kMainStyleColor];
    [_addFriendBtn setTitle: StringAddFriend forState: UIControlStateNormal];
    _addFriendBtn.titleLabel.font = kMiddleTextFont;
    [_addFriendBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    _addFriendBtn.layer.cornerRadius = kRadius;
    _addFriendBtn.layer.masksToBounds = YES;
    [_addFriendBtn addTarget:self action:@selector(clickAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _addFriendBtn];
    
    _addAppointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAppointBtn.frame = CGRectMake(ButtonX, kLargeMargin, ButtonWidth, kButtonHeight);
    [_addAppointBtn setBackgroundColor:kMainStyleColor];
    [_addAppointBtn setTitle: StringAppoint forState: UIControlStateNormal];
    _addAppointBtn.titleLabel.font = kMiddleTextFont;
    [_addAppointBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    _addAppointBtn.layer.cornerRadius = kRadius;
    _addAppointBtn.layer.masksToBounds = YES;
    [_addAppointBtn addTarget:self action:@selector(clickAddAppointButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _addAppointBtn];
    
    _addReportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addReportBtn.frame = CGRectMake(ButtonX, kLargeMargin + kDefaultMargin + kButtonHeight, ButtonWidth, kButtonHeight);
    [_addReportBtn setBackgroundColor:kGrayTextColor];
    [_addReportBtn setTitle: StringReport forState: UIControlStateNormal];
    _addReportBtn.titleLabel.font = kMiddleTextFont;
    [_addReportBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    _addReportBtn.layer.cornerRadius = kRadius;
    _addReportBtn.layer.masksToBounds = YES;
    [_addReportBtn addTarget:self action:@selector(clickAddReportButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _addReportBtn];
}

- (void)setIsFriend:(NSInteger)isFriend andIsRequest:(NSInteger)isRequest
{
    _isFriend = isFriend;
    _isRequest = isRequest;
    
    if (_isFriend == 1)
    {
        _addFriendBtn.hidden = YES;
        _addAppointBtn.hidden = NO;
        _addReportBtn.hidden = NO;
    }
    else
    {
        _addFriendBtn.hidden = NO;
        _addAppointBtn.hidden = YES;
        _addReportBtn.hidden = YES;
        
        if (_isRequest)
        {
            [self.addFriendBtn setBackgroundColor:kColorGrayLight];
            [self.addFriendBtn setTitle:StringAdded forState:UIControlStateNormal];
        }
        else
        {
            [self.addFriendBtn setBackgroundColor:kMainStyleColor];
            [self.addFriendBtn setTitle:StringAddFriend forState:UIControlStateNormal];
        }
    }
}


- (void)clickAddFriendButton:(UIButton *)button
{
    __unsafe_unretained CXUserDetailFunctionCell *weak_self = self;
    if (weak_self.addFriendBtnBlk) {
        weak_self.addFriendBtnBlk();
    }
}

- (void)clickAddAppointButton:(UIButton *)button
{
    __unsafe_unretained CXUserDetailFunctionCell *weak_self = self;
    if (weak_self.addAppointBtnBlk) {
        weak_self.addAppointBtnBlk();
    }
}

- (void)clickAddReportButton:(UIButton *)button
{
    __unsafe_unretained CXUserDetailFunctionCell *weak_self = self;
    if (weak_self.addReportBtnBlk) {
        weak_self.addReportBtnBlk();
    }
}
@end
