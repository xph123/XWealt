//
//  CXRegisterView.h
//  Link
//
//  Created by chx on 15-3-14.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXRegisterStepOneView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *captchas;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *getCaptchasBtn;    //获取验证码按钮

@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *invitationCode;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *acceptDisCountBtn;
@property (nonatomic, strong) UIButton *discountBoolBtn;


@property (nonatomic, copy) ActionClickBlk captchasBlk;
@property (nonatomic, copy) ActionClickBlk infoBtnBlk;
@property (nonatomic, copy) ActionClickBlk registerBtnBlk;
@property (nonatomic, copy) ActionClickBlk discountBoolBtnBlk;


@property(nonatomic,assign)NSInteger CaptchasTime;  //验证码发送完正在计算的时间
-(void)CaptchasTime:(void(^)(void))block;    //获取验证码传过来
-(void)CaptchasTimeState:(void(^)(void))block;   //结束验证码时间计时器的方法


@end
