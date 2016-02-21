//
//  CXUserDetailHeadView.h
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UserHeadWidth       64
#define UserHeadHeight      64
#define kUserDetailHeadHeight (UserHeadHeight + 3 * kDefaultMargin)   

@interface CXUserDetailHeadView : UIView

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *sexImageView;

@property (strong, nonatomic) CXUserModel *userModel;

@property (strong, nonatomic) ActionClickBlk clickHeadImageBlk;


@end
