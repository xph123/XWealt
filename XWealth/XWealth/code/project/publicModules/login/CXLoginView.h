//
//  CXLoginView.h
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXLoginView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, copy) ActionClickBlk loginBlk;
@property (nonatomic, copy) ActionClickBlk regBlk;
@property (nonatomic, copy) ActionClickBlk forgetBlk;

@end
