//
//  CXSelectFriendCell.h
//  Link
//
//  Created by chx on 14-11-19.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectFriendStruct.h"

@interface CXSelectFriendCell : UITableViewCell

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) CXUserView *userView;
@property (nonatomic, strong) CXSelectFriendStruct *selectModel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, assign) BOOL isSelected;

@end
