//
//  AddFriendCell.h
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *message;
@property (nonatomic, strong) UIButton *refuseBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UILabel *action;

@property (nonatomic, copy) ActionClickBlk refuseBlk;
@property (nonatomic, copy) ActionClickBlk agreeBlk;

@property (nonatomic, strong) CXAddFriendModel *addFriendModel;
@end
