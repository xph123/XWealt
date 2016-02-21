//
//  CXResetPasswordView.m
//  XWealth
//
//  Created by chx on 15/6/29.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXResetPasswordView.h"

@implementation CXResetPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        
        CGFloat width = frame.size.width - 2 * kMiddleMargin;
        CGFloat bgY = kMiddleMargin;
        UIImage *inputBackground = [[UIImage imageNamed:@"bg_multi_line_input"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        UIImageView *textViewBgImageView = [[UIImageView alloc] initWithImage:inputBackground];
        textViewBgImageView.frame = CGRectMake(kMiddleMargin, bgY, width, kTextFieldHeight * 3 + 2);
        textViewBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:textViewBgImageView];
        
        UITextField *passwordOld = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, bgY,  width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [nickNameTxtField setBorderStyle:UITextBorderStyleRoundedRect];
        [passwordOld setClearButtonMode:UITextFieldViewModeWhileEditing];
        [passwordOld setReturnKeyType:UIReturnKeyDone];
        [passwordOld setDelegate:self];
        passwordOld.placeholder = StringOldPassword;
        passwordOld.secureTextEntry = YES;
        [self addSubview:passwordOld];
        self.passwordOld = passwordOld;
        
        CGFloat lineView1Y = bgY + kTextFieldHeight;
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, lineView1Y, width, 0.5)];
        lineView1.backgroundColor = kLineColor;
        [self addSubview:lineView1];
        
        CGFloat userNameY = lineView1Y + 1;
        UITextField *password1 = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, userNameY , width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [userName setBorderStyle:UITextBorderStyleRoundedRect];
        [password1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [password1 setReturnKeyType:UIReturnKeyDone];
        [password1 setDelegate:self];
        password1.placeholder = StringNewPasswrod;
        password1.secureTextEntry = YES;
        [self addSubview:password1];
        self.password1 = password1;
        
        CGFloat lineViewY = userNameY + kTextFieldHeight;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, lineViewY, width, 0.5)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        CGFloat passwordY = lineViewY + 1;
        UITextField *password2 = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, passwordY, width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [password setBorderStyle:UITextBorderStyleRoundedRect];
        [password2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [password2 setReturnKeyType:UIReturnKeyDone];
        [password2 setDelegate:self];
        password2.placeholder = StringCertainPassword;
        password2.secureTextEntry = YES;
        [self addSubview:password2];
        self.password2 = password2;
        
        CGFloat loginBtnY = passwordY + kTextFieldHeight + kMiddleMargin;
        
        UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        certainBtn.frame = CGRectMake(kMiddleMargin, loginBtnY, width, kButtonHeight);
        certainBtn.layer.cornerRadius = kRadius;
        certainBtn.layer.masksToBounds = YES;
        certainBtn.titleLabel.font = kLargeTextFont;
        [certainBtn setTitle: StringCertain forState:UIControlStateNormal];
        [certainBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        certainBtn.backgroundColor = kMainStyleColor;
        [certainBtn addTarget:self action:@selector(certainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:certainBtn];
        self.certainBtn = certainBtn;
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)certainBtnClick:(UIButton *)button
{
    if (self.certainBlk) {
        self.certainBlk();
    }
}

@end
