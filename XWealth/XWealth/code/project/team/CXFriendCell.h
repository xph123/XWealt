//
//  CXFriendCell.h
//  Link
//
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CXFriendCell : UITableViewCell

@property (nonatomic, strong) CXUserView *userView;
@property (nonatomic, strong) CXUserModel *userModel;
@property (nonatomic, strong) UIView *line;
@end
