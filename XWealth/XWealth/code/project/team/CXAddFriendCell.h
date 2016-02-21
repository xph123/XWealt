//
//  CXAddFriendCell.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXAddFriendCell : UITableViewCell

@property (nonatomic, strong) CXApplyModel *applyModel;

@property (strong, nonatomic) UIView *cellView;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *signature;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *addFriendBtn;

@property (strong, nonatomic) ActionClickBlk addFriendBtnBlk;
@end
