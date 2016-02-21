//
//  CXAddFriendCell.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXAddFriendCell.h"
#import "CXAddFriendFrame.h"

@implementation CXAddFriendCell

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
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 4;
    [_cellView addSubview:headImg];
    self.headImg = headImg;
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = kTextColor;
    name.backgroundColor = kColorClear;
    name.font = kLargeTextFont;
    name.numberOfLines = 1;
    [_cellView addSubview:name];
    self.name = name;
    
    UILabel *signature = [[UILabel alloc] initWithFrame:CGRectZero];
    signature.textColor = kAssistTextColor;
    signature.backgroundColor = kColorClear;
    signature.font = kMiddleTextFont;
    signature.numberOfLines = 0;
    [_cellView addSubview:signature];
    self.signature = signature;

    UIButton *addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriendBtn.frame = CGRectZero;
    addFriendBtn.layer.masksToBounds = YES;
    addFriendBtn.layer.cornerRadius = kRadius;
    addFriendBtn.layer.borderColor = kLineColor.CGColor;
    addFriendBtn.layer.borderWidth = 1;
    [addFriendBtn setBackgroundColor:kMainStyleColor];
    [addFriendBtn setTitle:StringAdd forState:UIControlStateNormal];
    addFriendBtn.titleLabel.font = kMiddleTextFont;
    [addFriendBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
//    [addFriendBtn setImage:IMAGE(@"friend_add") forState:UIControlStateNormal];
    [addFriendBtn addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cellView addSubview:addFriendBtn];
    self.addFriendBtn = addFriendBtn;

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = kLineColor;
    [_cellView addSubview:line];
    self.line = line;
}

- (void) setApplyModel:(CXApplyModel *)applyModel
{
    _applyModel = applyModel;
    
    CXAddFriendFrame *layout = [[CXAddFriendFrame alloc] initWithDataModel:_applyModel];
    
    self.cellView.frame = [layout cellViewRect];
    
    self.headImg.frame = [layout headImgRect];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.applyModel.logo] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    self.name.frame = [layout nameRect];
    self.name.text = _applyModel.name;
    
    self.signature.frame = [layout signatureRect];
    self.signature.text = _applyModel.signature;
    
    self.addFriendBtn.frame = [layout addFriendBtnRect];
    if (self.applyModel.isFriend)
    {
        [self.addFriendBtn setBackgroundColor:kColorGrayLight];
        [self.addFriendBtn setTitle:StringAdded forState:UIControlStateNormal];
    }
    else
    {
        [self.addFriendBtn setBackgroundColor:kMainStyleColor];
        [self.addFriendBtn setTitle:StringAdd forState:UIControlStateNormal];
    }
    
    self.line.frame = [layout lineRect];
}

- (void)addFriendAction:(UIButton *)button
{
    if (self.addFriendBtnBlk) {
        self.addFriendBtnBlk();
    }
}

@end
