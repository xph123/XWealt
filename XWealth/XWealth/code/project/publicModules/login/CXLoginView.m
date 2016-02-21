//
//  CXLoginView.m
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXLoginView.h"

@implementation CXLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        
        CGFloat width = frame.size.width - 2 * kMiddleMargin;
        
        UIImage *inputBackground = [[UIImage imageNamed:@"bg_multi_line_input"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        UIImageView *textViewBgImageView = [[UIImageView alloc] initWithImage:inputBackground];
        textViewBgImageView.frame = CGRectMake(kMiddleMargin, kMiddleMargin, width, kExtTextFieldHeight * 2 + 1);
        textViewBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:textViewBgImageView];
        
        UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, kMiddleMargin, width - 2 * kDefaultMargin, kExtTextFieldHeight)];
//        [userName setBorderStyle:UITextBorderStyleRoundedRect];
        [userName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [userName setReturnKeyType:UIReturnKeyDone];
        [userName setDelegate:self];
        userName.placeholder = StringPhone;
        userName.keyboardType = UIKeyboardTypePhonePad;
        [self addSubview:userName];
        self.userName = userName;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, kMiddleMargin + kExtTextFieldHeight, width, 0.5)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        CGFloat passwordY = kMiddleMargin + kExtTextFieldHeight + 1;
        UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, passwordY, width - 2 * kDefaultMargin, kExtTextFieldHeight)];
//        [password setBorderStyle:UITextBorderStyleRoundedRect];
        [password setClearButtonMode:UITextFieldViewModeWhileEditing];
        [password setReturnKeyType:UIReturnKeyDone];
        [password setDelegate:self];
        password.placeholder = StringPassword;
        password.secureTextEntry = YES;
        [self addSubview:password];
        self.password = password;
        
//        UIButton *showPassword = [UIButton buttonWithType:UIButtonTypeCustom];
//        showPassword.frame = CGRectMake(frame.size.width - kMiddleMargin - 40, passwordY, 40, 40);
//        showPassword.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,10);
//        [showPassword setImage:IMAGE(@"password_unvisible") forState:UIControlStateNormal];
//        [showPassword addTarget:self action:@selector(passwordShow:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:showPassword];
        
        CGFloat loginBtnY = passwordY + kExtTextFieldHeight + kLargeMargin;
        
        UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
        login.frame = CGRectMake(kMiddleMargin, loginBtnY, width, kButtonHeight);
        login.layer.cornerRadius = kRadius;
        login.layer.masksToBounds = YES;
        login.titleLabel.font = kLargeTextFont;
        [login setTitle: StringLogin forState:UIControlStateNormal];
        [login setTitleColor:kColorWhite forState:UIControlStateNormal];
        login.backgroundColor = kButtonColor;
        [login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:login];
        self.loginBtn = login;
        
        CGFloat registerBtnY = loginBtnY + kButtonHeight + kLargeMargin;
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(kMiddleMargin, registerBtnY, width, kButtonHeight);
        registerBtn.layer.cornerRadius = kRadius;
        registerBtn.layer.masksToBounds = YES;
        registerBtn.titleLabel.font = kLargeTextFont;
        [registerBtn setTitle:StringRegister forState:UIControlStateNormal];
        [registerBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        registerBtn.backgroundColor = kColorWhite;
        [registerBtn addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registerBtn];
        self.registerBtn = registerBtn;
        
        CGFloat forgetY = registerBtnY + kButtonHeight + kLargeMargin;
        UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
        forget.frame = CGRectMake( kMiddleMargin, forgetY, width, kLabelHeight);
        forget.titleLabel.font = kSmallTextFont;
        [forget setTitle:StringForgetPassword forState:UIControlStateNormal];
        [forget setTitleColor:kBlueColor forState:UIControlStateNormal];
        forget.backgroundColor = kControlBgColor;
        [forget addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forget];
        self.forgetBtn = forget;

    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)login:(UIButton *)button
{
    if (self.loginBlk) {
        self.loginBlk();
    }
}

- (void)reg:(UIButton *)button
{
    if (self.regBlk) {
        self.regBlk();
    }
}

- (void)forget:(UIButton *)button
{
    if (self.forgetBlk) {
        self.forgetBlk();
    }
}

#pragma mark - 密码显示或隐藏
//- (void)passwordShow:(UIButton *)button
//{
//    if (self.password.secureTextEntry)
//    {
//        [button setImage:IMAGE(@"password_visible") forState:UIControlStateNormal];
//        self.password.secureTextEntry = NO;
//    }
//    else
//    {
//        [button setImage:IMAGE(@"password_unvisible") forState:UIControlStateNormal];
//        self.password.secureTextEntry = YES;
//    }
//}



@end
