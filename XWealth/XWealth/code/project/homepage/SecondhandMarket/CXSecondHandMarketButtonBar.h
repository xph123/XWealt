//
//  CXSecondHandMarketButtonBar.h
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSecondHandMarketButtonBar : UIView
@property (strong, nonatomic) UIView  *firstView;
@property (strong, nonatomic) UIImageView *firstImageView;
@property (strong, nonatomic) UILabel *firstTitleLable;
@property (strong, nonatomic) UILabel *firstContentLable;

@property (strong, nonatomic) UIView  *secondView;
@property (strong, nonatomic) UIImageView *secondImageView;
@property (strong, nonatomic) UILabel *secondTitleLable;
@property (strong, nonatomic) UILabel *secondContentLable;

@property (strong, nonatomic) UIView  *thirView;
@property (strong, nonatomic) UIImageView *thirImageView;
@property (strong, nonatomic) UILabel *thirTitleLable;
@property (strong, nonatomic) UILabel *thirContentLable;

@property (strong, nonatomic) UIView  *fourView;
@property (strong, nonatomic) UIImageView *fourImageView;
@property (strong, nonatomic) UILabel *fourTitleLable;
@property (strong, nonatomic) UILabel *fourContentLable;


@property (strong, nonatomic) ActionClickBlk firstBtnBlk;
@property (strong, nonatomic) ActionClickBlk secondBtnBlk;
@property (strong, nonatomic) ActionClickBlk thirdBtnBlk;
@property (strong, nonatomic) ActionClickBlk fourBtnBlk;
@end
