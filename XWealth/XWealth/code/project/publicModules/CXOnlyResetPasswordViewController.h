//
//  CXOnlyResetPasswordViewController.h
//  XWealth
//
//  Created by gsycf on 16/1/6.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXOnlyResetPasswordView.h"
@interface CXOnlyResetPasswordViewController :  XViewController<UITextFieldDelegate,UIActionSheetDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) CXOnlyResetPasswordView *findPwdView;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *captchas;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *password2;

@end
