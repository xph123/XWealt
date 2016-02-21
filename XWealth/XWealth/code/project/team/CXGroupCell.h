//
//  CXGroupCell.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXGroupCell : UITableViewCell

@property (nonatomic, strong) CXUserView *userView;
@property (nonatomic, strong) CXGroupModel *groupModel;
@property (nonatomic, strong) UIView *line;

@end
