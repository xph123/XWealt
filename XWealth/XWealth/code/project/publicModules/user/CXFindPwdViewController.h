//
//  CXFindPwdViewController.h
//  Link
//
//  Created by chx on 15-3-16.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXFindPwdView.h"

@interface CXFindPwdViewController : XViewController<UITextFieldDelegate>

@property (strong, nonatomic) CXFindPwdView *findPwdView;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *captchas;
@property (strong, nonatomic) NSString *password;

@end
