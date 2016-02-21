//
//  CXMeHeaderView.h
//  Link
//  我的头部视图
//  Created by chx on 14-12-2.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageAndLableBtn.h"
@interface CXMeHeaderView : UIView

@property (strong, nonatomic)UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *headBgImageView;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UILabel *nameLabel;


@property (strong, nonatomic) UIImageView *oneVerticalImaView;
@property (strong, nonatomic) UIImageView *twoVerticalImaView;


@property (strong, nonatomic) imageAndLableBtn *leftBtn;
@property (strong, nonatomic) imageAndLableBtn *centerBtn;
@property (strong, nonatomic) imageAndLableBtn *rightBtn;

@property (strong, nonatomic) CXUserModel *userModel;

@property (strong, nonatomic) ActionClickBlk changeHeaderBgImageBlk;
@property (strong, nonatomic) ActionClickBlk changeHeadImageBlk;
@property (strong, nonatomic) ActionClickBlk myInfoBlk;
@property (strong, nonatomic) ActionClickBlk leftBlk;
@property (strong, nonatomic) ActionClickBlk centerBlk;
@property (strong, nonatomic) ActionClickBlk rightBlk;
@end
