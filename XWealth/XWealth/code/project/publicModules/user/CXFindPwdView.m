//
//  CXFindPwdView.m
//  Link
//
//  Created by chx on 15-3-16.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import "CXFindPwdView.h"

@implementation CXFindPwdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        
        CGFloat titleY = 0;
        CGFloat titleHeight = kLabelHeight;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, titleY, frame.size.width - 50, titleHeight)];
        title.font = kMiddleTextFont;
        title.textColor = kTextColor;
        title.text = StringFindPwdInfo;
        title.numberOfLines = 3;
        title.backgroundColor = kColorClear;
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        CGFloat width = frame.size.width - 2 * kMiddleMargin;
        CGFloat y = titleY + titleHeight + kMiddleMargin;
        
        UIImage *inputBackground = [[UIImage imageNamed:@"bg_multi_line_input"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        UIImageView *textViewBgImageView = [[UIImageView alloc] initWithImage:inputBackground];
        textViewBgImageView.frame = CGRectMake(kMiddleMargin, y, width, kTextFieldHeight * 3 + 2);
        textViewBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:textViewBgImageView];
        
        UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, y, width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [userName setBorderStyle:UITextBorderStyleRoundedRect];
        [userName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [userName setReturnKeyType:UIReturnKeyDone];
        [userName setDelegate:self];
        userName.placeholder = StringPhone;
        userName.keyboardType = UIKeyboardTypeEmailAddress;
        [self addSubview:userName];
        self.userName = userName;
        
        CGFloat lineViewY = y + kTextFieldHeight;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, lineViewY, width, 0.5)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        CGFloat captchasY = lineViewY + 1;
        UITextField *captchas = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, captchasY + 1, width - 2 * kDefaultMargin - 100, kExtTextFieldHeight - 2)];
        //        [captchas setBorderStyle:UITextBorderStyleRoundedRect];
        [captchas setClearButtonMode:UITextFieldViewModeWhileEditing];
        [captchas setReturnKeyType:UIReturnKeyDone];
        [captchas setDelegate:self];
        captchas.placeholder = StringCaptchas;
        captchas.backgroundColor = kColorWhite;
        captchas.keyboardType = UIKeyboardTypePhonePad;
        [self addSubview:captchas];
        self.captchas = captchas;
        
        CGFloat getCaptchasX = kMiddleMargin + width - kDefaultMargin - 100;
        CGFloat getCaptachasY = captchasY + (kExtTextFieldHeight - 30) / 2;
        UIButton *getCaptchasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        getCaptchasBtn.frame = CGRectMake(getCaptchasX, getCaptachasY, 100, 30);
        getCaptchasBtn.layer.masksToBounds = YES;
        getCaptchasBtn.layer.cornerRadius = kRadius;
        getCaptchasBtn.titleLabel.font = kMiddleTextFont;
        [getCaptchasBtn setTitle: StringGetCaptchas forState:UIControlStateNormal];
        [getCaptchasBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        getCaptchasBtn.backgroundColor = kLightGrayColor;
        [getCaptchasBtn addTarget:self action:@selector(getCaptchas:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getCaptchasBtn];
        self.getCaptchasBtn = getCaptchasBtn;
        
        CGFloat lineViewY2 = captchasY + kTextFieldHeight;
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, lineViewY2, width, 0.5)];
        lineView2.backgroundColor = kLineColor;
        [self addSubview:lineView2];
        
        CGFloat passwordY = captchasY + kTextFieldHeight + 1;
        UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, passwordY, width - 2 * kDefaultMargin, kTextFieldHeight)];
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
        
        CGFloat certainBtnY = passwordY + kTextFieldHeight + kLargeMargin;
        
        UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        certainBtn.frame = CGRectMake(kMiddleMargin, certainBtnY, width, kButtonHeight);
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

- (void)getCaptchas:(UIButton *)button
{
    if (self.captchasBlk) {
        self.captchasBlk();
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
