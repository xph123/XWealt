//
//  CXRegisterViewController.h
//  Link
//
//  Created by chx on 14-12-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXRegisterStepOneView.h"
#import "CXSelectFinanciersViewController.h"
@interface CXRegisterViewController : XViewController<UITextFieldDelegate,UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) CXRegisterStepOneView *registerStepOneView;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *captchas; // 验证码
@property (strong, nonatomic) NSString *invitationCode; // 邀请码

@property (strong, nonatomic) CXUserModel *userModel;

@end
