//
//  CXFunctionsButtonBar.h
//  Link
//  首页上3个大按钮
//  Created by chx on 14-11-6.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXFunctionsButtonBar : UIView

@property (strong, nonatomic) UIButton *firstButton;
@property (strong, nonatomic) UIButton *secondButton;
@property (strong, nonatomic) UIButton *thirdButton;
@property (strong, nonatomic) UIButton *fourButton;
//@property (strong, nonatomic) UIButton *fiveButton;
//@property (strong, nonatomic) UIButton *sixButton;
//@property (strong, nonatomic) UIButton *sevenButton;
//@property (strong, nonatomic) UIButton *eightButton;

@property (strong, nonatomic) UIImageView *firstImageView;
@property (strong, nonatomic) UIImageView *secondImageView;
@property (strong, nonatomic) UIImageView *thirdImageView;
@property (strong, nonatomic) UIImageView *fourImageView;
//@property (strong, nonatomic) UIImageView *fiveImageView;
//@property (strong, nonatomic) UIImageView *sixImageView;
//@property (strong, nonatomic) UIImageView *sevenImageView;
//@property (strong, nonatomic) UIImageView *eightImageView;

@property (strong, nonatomic) UILabel *firstText;
@property (strong, nonatomic) UILabel *secondText;
@property (strong, nonatomic) UILabel *thirdText;
@property (strong, nonatomic) UILabel *fourText;
//@property (strong, nonatomic) UILabel *fiveText;
//@property (strong, nonatomic) UILabel *sixText;
//@property (strong, nonatomic) UILabel *sevenText;
//@property (strong, nonatomic) UILabel *eightText;

@property (strong, nonatomic) UIImageView *unreadImageView;
@property (strong, nonatomic) UILabel *unreadLabel;

- (void) setUnreadItem:(NSInteger) count;

@property (strong, nonatomic) ActionClickBlk firstBtnBlk;
@property (strong, nonatomic) ActionClickBlk secondBtnBlk;
@property (strong, nonatomic) ActionClickBlk thirdBtnBlk;
@property (strong, nonatomic) ActionClickBlk fourBtnBlk;
//@property (strong, nonatomic) ActionClickBlk fiveBtnBlk;
//@property (strong, nonatomic) ActionClickBlk sixBtnBlk;
//@property (strong, nonatomic) ActionClickBlk sevenBtnBlk;
//@property (strong, nonatomic) ActionClickBlk eightBtnBlk;

@end
