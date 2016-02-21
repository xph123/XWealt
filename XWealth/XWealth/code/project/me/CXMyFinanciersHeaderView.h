//
//  CXMyFinanciersHeaderView.h
//  XWealth
//
//  Created by gsycf on 15/11/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageAndLableBtn.h"
@interface CXMyFinanciersHeaderView : UIView
@property (strong, nonatomic) CXUserModel *userModel;

@property (strong, nonatomic)UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *headBgImageView;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIImageView *headGradeView;

@property (strong, nonatomic) UIImageView *praiseBackView;
@property (strong, nonatomic) UIImageView *praiseView;
@property (strong ,nonatomic) UILabel *praiseNumLable;


@property (strong, nonatomic) UIImageView *blackSideView;
@property (strong, nonatomic) UIImageView *gradeView;
@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UILabel *authenticationLabel;
@property (strong, nonatomic) UILabel *tradeLabel;

@property (strong, nonatomic) UILabel *distanceLabel;


@property (strong, nonatomic) UIImageView *downbackView;
@property (strong, nonatomic) UILabel *specialtyLabel;
@property (strong, nonatomic) UILabel *recordLabel;
@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UILabel *numberLabel;



@property (strong, nonatomic) ActionClickBlk praiseBlk;

@end
