//
//  CXUserView.h
//  Link
//  用户头像 + 用户名  的视图
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXUserView : UIView

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UIImageView *tips;
@property (nonatomic, strong) UILabel *numberLabel;

@end
