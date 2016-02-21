//
//  CXGroupMemberCell.h
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface CXGroupMemberCell : UIGridViewCell

@property (strong, nonatomic) CXUserModel *userModel;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *userName;



@end
