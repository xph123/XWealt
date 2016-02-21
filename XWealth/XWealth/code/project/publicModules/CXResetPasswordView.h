//
//  CXResetPasswordView.h
//  XWealth
//
//  Created by chx on 15/6/29.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXResetPasswordView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordOld;
@property (nonatomic, strong) UITextField *password1;
@property (nonatomic, strong) UITextField *password2;
@property (nonatomic, strong) UIButton *certainBtn;

@property (nonatomic, copy) ActionClickBlk certainBlk;


@end
