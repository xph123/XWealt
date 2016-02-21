//
//  CXClassroomFunctionsButtonBar.h
//  XWealth
//
//  Created by gsycf on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXClassroomFunctionsButtonBar : UIView
@property (strong, nonatomic) UIButton *firstButton;
@property (strong, nonatomic) UIButton *secondButton;
@property (strong, nonatomic) UIButton *thirdButton;
@property (strong, nonatomic) UIButton *fourButton;

@property (strong, nonatomic) UIImageView *firstImageView;
@property (strong, nonatomic) UIImageView *secondImageView;
@property (strong, nonatomic) UIImageView *thirdImageView;
@property (strong, nonatomic) UIImageView *fourImageView;

@property (strong, nonatomic) CXCategoryModel *firstIModel;
@property (strong, nonatomic) CXCategoryModel *secondModel;
@property (strong, nonatomic) CXCategoryModel *thirdModel;
@property (strong, nonatomic) CXCategoryModel *fourModel;
-(void)getData:(NSMutableArray *)arrData;
@property(nonatomic, strong)NSMutableArray  *arrayImages;          //存放图片的数组

@property (strong, nonatomic) ActionClickBlk firstBtnBlk;
@property (strong, nonatomic) ActionClickBlk secondBtnBlk;
@property (strong, nonatomic) ActionClickBlk thirdBtnBlk;
@property (strong, nonatomic) ActionClickBlk fourBtnBlk;
@end
