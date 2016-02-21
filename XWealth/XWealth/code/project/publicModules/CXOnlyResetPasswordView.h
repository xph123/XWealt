//
//  CXOnlyResetPasswordView.h
//  XWealth
//
//  Created by gsycf on 16/1/6.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXOnlyResetPasswordView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *captchas;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *iconfirmPaw;
@property (nonatomic, strong) UIButton *certainBtn;
@property (nonatomic, strong) UIButton *getCaptchasBtn;

@property (nonatomic, copy) ActionClickBlk captchasBlk;
@property (nonatomic, copy) ActionClickBlk certainBlk;


@property(nonatomic,assign)NSInteger CaptchasTime;  //验证码发送完正在计算的时间
-(void)CaptchasTime:(void(^)(void))block;    //获取验证码传过来
-(void)CaptchasTimeState:(void(^)(void))block;   //结束验证码时间计时器的方法
@end
