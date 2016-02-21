//
//  CXUserCell.m
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXUserCell.h"

@implementation CXUserCell

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
    CGFloat cellWidth = kScreenWidth - 2 * kDefaultMargin;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, cellWidth, kUserCellHeight)];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kUserHeadImgWidth, kUserHeadImgHeight)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = kRadius;
    [_cellView addSubview:headImg];
    self.headImg = headImg;
    
    CGFloat width = cellWidth - 3 * kDefaultMargin - kUserHeadImgWidth;
    CGFloat x = kUserHeadImgWidth + 2 * kDefaultMargin;
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(x, kDefaultMargin, width, kLabelHeight)];
    name.textColor = kTextColor;
    name.backgroundColor = kColorClear;
    name.font = kLargeTextFont;
    [_cellView addSubview:name];
    self.name = name;
    
    UILabel *signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, kDefaultMargin * 2 + kLabelHeight, width, kLabelHeight)];
    signatureLabel.textColor = kAssistTextColor;
    signatureLabel.backgroundColor = kColorClear;
    signatureLabel.font = kMiddleTextFont;
    [_cellView addSubview:signatureLabel];
    self.signatureLabel = signatureLabel;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kUserCellHeight - 1, cellWidth, 1)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    self.line = line;
}

- (void) setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
    
    _name.text = [userModel getDisplayName];
    _signatureLabel.text = userModel.signature;
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:_userModel.headImg] placeholderImage:[UIImage imageNamed:@"head_default"]];
}

@end
