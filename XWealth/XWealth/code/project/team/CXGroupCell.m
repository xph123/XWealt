//
//  CXGroupCell.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupCell.h"

@implementation CXGroupCell

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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, kUserCellHeight-1, kScreenWidth - 2 * kDefaultMargin, 0.5)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

- (void) setGroupModel:(CXGroupModel *)groupModel
{
    _groupModel = groupModel;
    
    [self.userView.headImg sd_setImageWithURL:[NSURL URLWithString:self.groupModel.groupLogo] placeholderImage:[UIImage imageNamed:@"group_default_logo"]];
    
    self.userView.name.text = _groupModel.groupName;
}

@end
