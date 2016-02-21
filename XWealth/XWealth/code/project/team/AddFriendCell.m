//
//  AddFriendCell.m
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kUserHeadImgWidth, kUserHeadImgHeight)];
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius = kRadius;
        [self.contentView addSubview:headImg];
        self.headImgView = headImg;
        
        int contentX = kDefaultMargin * 2 + kUserHeadImgWidth;
        int nameHeight = 16;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(contentX, kDefaultMargin, 120, nameHeight)];
        name.font = kMiddleTextFont;
        name.textColor = kTextColor;
        name.backgroundColor = kColorClear;
        [self.contentView addSubview:name];
        self.name = name;
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(contentX, kDefaultMargin * 2 + nameHeight, 250, 14)];
        message.font = kSmallTextFont;
        message.textColor = kAssistTextColor;
        message.backgroundColor = kColorClear;
        [self.contentView addSubview:message];
        self.message = message;
        
        UIImage *image = [kColorWhite translateIntoImage];
        UIButton *refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refuseBtn.frame = CGRectMake(192, 6, 56, 25);
        refuseBtn.layer.masksToBounds = YES;
        refuseBtn.layer.cornerRadius = kRadius;
        refuseBtn.layer.borderWidth = 1;
        refuseBtn.layer.borderColor = kMainStyleColor.CGColor;
        [refuseBtn setTitle:StringRefuse forState:UIControlStateNormal];
        refuseBtn.titleLabel.font = kMiddleTextFont;
        [refuseBtn setTitleColor:kMainStyleColor forState:UIControlStateNormal];
        [refuseBtn setBackgroundImage:image forState:UIControlStateNormal];
        [refuseBtn addTarget:self action:@selector(refuse:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:refuseBtn];
        self.refuseBtn = refuseBtn;
        
        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreeBtn.frame = CGRectMake(258, 6, 56, 25);
        agreeBtn.layer.masksToBounds = YES;
        agreeBtn.layer.cornerRadius = kRadius;
        agreeBtn.layer.borderWidth = 1;
        agreeBtn.layer.borderColor = kMainStyleColor.CGColor;
        [agreeBtn setTitle:StringAgree forState:UIControlStateNormal];
        agreeBtn.titleLabel.font = kMiddleTextFont;
        [agreeBtn setTitleColor:kMainStyleColor forState:UIControlStateNormal];
        [agreeBtn setBackgroundImage:image forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:agreeBtn];
        self.agreeBtn = agreeBtn;
        
        UILabel *action = [[UILabel alloc] initWithFrame:CGRectMake(270, 24, 44, 16)];
        action.font = kMiddleTextFont;
        action.textColor = kAssistTextColor;
        action.backgroundColor = kColorClear;
        action.hidden = YES;
        [self.contentView addSubview:action];
        self.action = action;

        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kAddFriendCellHeight - 1, kScreenWidth, 0.5)];
        line.backgroundColor = kLineColor;
        [self.contentView addSubview:line];
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


- (void)refuse:(UIButton *)button
{
    if (self.refuseBlk) {
        self.refuseBlk();
    }
}

- (void)agree:(UIButton *)button
{
    if (self.agreeBlk) {
        self.agreeBlk();
    }
}

- (void) setAddFriendModel:(CXAddFriendModel *)addFriendModel
{
    _addFriendModel = addFriendModel;
    
    NSString *name = [NSObject isEmpty1:self.addFriendModel.user.nickName] ? self.addFriendModel.user.nickName : self.addFriendModel.user.userName;
    self.name.text = name;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.addFriendModel.user.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    if (self.addFriendModel.applyInfo.length > 0)
    {
        self.message.text = self.addFriendModel.applyInfo;
    }
    else
    {
        self.message.text = StringApplyInfo;
    }
    
    switch (self.addFriendModel.isFriend)
    {
        case FRIEND_NO:
            self.action.hidden = YES;
            self.agreeBtn.hidden = NO;
            self.refuseBtn.hidden = NO;
            break;
        case FRIEND_YES:
            self.action.hidden = NO;
            self.action.text = StringAgreed;
            self.agreeBtn.hidden = YES;
            self.refuseBtn.hidden = YES;
            break;
        case FRIEND_REFUSE:
            self.action.hidden = NO;
            self.action.text = StringRefused;
            self.agreeBtn.hidden = YES;
            self.refuseBtn.hidden = YES;
            break;
        default:
            break;
    }
}


@end
