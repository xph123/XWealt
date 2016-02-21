//
//  CXLoginViewController.h
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXLoginView.h"

@interface CXLoginViewController : XViewController

@property (nonatomic, strong) CXLoginView *loginView;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;

@property (assign, nonatomic) NSInteger loginWay;  //登录的方法默认为： 0（或不输入）正常登录，1重置所有登录；

// 用户登录
- (void) loginWithUserName:(NSString*) userName andPassword:(NSString *)password andAutoLogin:(BOOL)isAuto;
- (void) loginWithUserName:(NSString*) userName andPassword:(NSString *)password andIsEntryForeground:(BOOL)isEntryForeground andAutoLogin:(BOOL)isAuto;

@end
