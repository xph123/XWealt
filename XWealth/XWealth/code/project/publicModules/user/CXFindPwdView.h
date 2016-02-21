//
//  CXFindPwdView.h
//  Link
//
//  Created by chx on 15-3-16.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXFindPwdView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *captchas;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *certainBtn;
@property (nonatomic, strong) UIButton *getCaptchasBtn;

@property (nonatomic, copy) ActionClickBlk captchasBlk;
@property (nonatomic, copy) ActionClickBlk certainBlk;

@end
