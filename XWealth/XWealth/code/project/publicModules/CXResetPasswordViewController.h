//
//  CXResetPasswordViewController.h
//  XWealth
//
//  Created by chx on 15/6/29.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXResetPasswordView.h"

@interface CXResetPasswordViewController : XViewController<UITextFieldDelegate,UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) CXResetPasswordView *resetPwView;

@property (strong, nonatomic) NSString *passwordOld;
@property (strong, nonatomic) NSString *password1;
@property (strong, nonatomic) NSString *password2;


@end
