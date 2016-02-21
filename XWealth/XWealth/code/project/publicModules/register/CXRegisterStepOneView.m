//
//  CXRegisterView.m
//  Link
//
//  Created by chx on 15-3-14.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import "CXRegisterStepOneView.h"

@implementation CXRegisterStepOneView
{
    NSTimer *_time;   //定时器
    float _textFieldMove;   //记录视图移动的位置
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        
        CGFloat width = frame.size.width - 2 * kMiddleMargin;
        
        NSString *promptTitle = @"高手一账通";
        UILabel *promptTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, 0, width, kLabelHeight)];
        promptTitleLabel.font = kLargeTextFontBold;
        promptTitleLabel.textColor = kTextColor;
        promptTitleLabel.numberOfLines = 1;
        promptTitleLabel.textAlignment = NSTextAlignmentCenter;
        promptTitleLabel.backgroundColor = [UIColor clearColor];
        promptTitleLabel.text = promptTitle;
        [self addSubview:promptTitleLabel];
        
        NSString *prompt = @"在掌富宝注册的账号，可以登录信托宝、高手帮等高搜易平台开发的产品！";
        UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, kLabelHeight, width, kTwoLineLabelHeight)];
        promptLabel.font = kMiddleTextFont;
        promptLabel.textColor = kAssistTextColor;
        promptLabel.numberOfLines = 2;
        promptLabel.textAlignment = NSTextAlignmentLeft;
        promptLabel.backgroundColor = [UIColor clearColor];
        promptLabel.text = prompt;
        [self addSubview:promptLabel];

        
        
        CGFloat bgY = kMiddleMargin + kLabelHeight + kTwoLineLabelHeight;
        UIImage *inputBackground = [[UIImage imageNamed:@"bg_multi_line_input"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        UIImageView *textViewBgImageView = [[UIImageView alloc] initWithImage:inputBackground];
        textViewBgImageView.frame = CGRectMake(kMiddleMargin, bgY, width, kExtTextFieldHeight * 4 + 3);
//        textViewBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:textViewBgImageView];
 
        UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, bgY + 1,  width - 2 * kDefaultMargin, kExtTextFieldHeight - 2)];
        //        [userName setBorderStyle:UITextBorderStyleRoundedRect];
        [userName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [userName setReturnKeyType:UIReturnKeyDone];
        userName.delegate=self;
        userName.placeholder = StringPhone;
        userName.backgroundColor = kColorWhite;
        userName.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:userName];
        self.userName = userName;
        
        CGFloat captchasLineViewY = bgY + kExtTextFieldHeight;
        UIView *captchasLineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, captchasLineViewY, width, 0.5)];
        captchasLineView.backgroundColor = kLineColor;
        [self addSubview:captchasLineView];
        
        CGFloat captchasY = captchasLineViewY + 1;
        UITextField *captchas = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, captchasY + 1, width - 2 * kDefaultMargin - 100, kExtTextFieldHeight - 2)];
        //        [captchas setBorderStyle:UITextBorderStyleRoundedRect];
        [captchas setClearButtonMode:UITextFieldViewModeWhileEditing];
        [captchas setReturnKeyType:UIReturnKeyDone];
        //[captchas setDelegate:self];
        captchas.placeholder = StringCaptchas;
        captchas.backgroundColor = kColorWhite;
        captchas.keyboardType = UIKeyboardTypeNumberPad;
        captchas.delegate=self;
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
        
        CGFloat passwordLineViewY = captchasY + kExtTextFieldHeight;
        UIView *passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, passwordLineViewY, width, 0.5)];
        passwordLineView.backgroundColor = kLineColor;
        [self addSubview:passwordLineView];
        
        
        
        UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, passwordLineViewY + 1,  width - 2 * kDefaultMargin, kExtTextFieldHeight - 2)];
        //        [password setBorderStyle:UITextBorderStyleRoundedRect];
        [password setClearButtonMode:UITextFieldViewModeWhileEditing];
        [password setReturnKeyType:UIReturnKeyDone];
        password.placeholder = StringPassword;
        password.backgroundColor = kColorWhite;
        password.secureTextEntry = YES;
        password.keyboardType = UIKeyboardTypeAlphabet;
        password.delegate=self;
        [self addSubview:password];
        self.password = password;
        
        CGFloat invitationCodeLineViewY = passwordLineViewY + kExtTextFieldHeight;
        UIView *invitationCodeLineView = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, invitationCodeLineViewY, width, 0.5)];
        invitationCodeLineView.backgroundColor = kLineColor;
        [self addSubview:invitationCodeLineView];
        
        CGFloat invitationCodeY = invitationCodeLineViewY + 1;
        UITextField *invitationCode = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, invitationCodeY + 1, width - 2 * kDefaultMargin - kIconMiddleWidth, kExtTextFieldHeight - 2)];
        //        [invitationCode setBorderStyle:UITextBorderStyleRoundedRect];
        [invitationCode setClearButtonMode:UITextFieldViewModeWhileEditing];
        [invitationCode setReturnKeyType:UIReturnKeyDone];
        invitationCode.delegate=self;
        invitationCode.placeholder = StringInvitationCode;
        invitationCode.backgroundColor = kColorWhite;
        invitationCode.keyboardType = UIKeyboardTypeAlphabet;
        [self addSubview:invitationCode];
        self.invitationCode = invitationCode;
        
        
        UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        infoBtn.frame = CGRectMake(width - kIconMiddleWidth, invitationCodeY, kIconMiddleWidth, kButtonHeight);
        infoBtn.layer.masksToBounds = YES;
        infoBtn.backgroundColor = kColorClear;
        [infoBtn setImage:IMAGE(@"info_icon") forState:UIControlStateNormal];
        [infoBtn addTarget:self action:@selector(getInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:infoBtn];
        self.infoBtn = infoBtn;
        
        
        //是否同意掌富宝协议
        CGFloat discountBoolY = bgY +kExtTextFieldHeight * 4 + 3+kDefaultMargin;
        UIButton *cceptDisCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cceptDisCountButton.frame = CGRectMake(kMiddleMargin + kDefaultMargin, discountBoolY+2, 13, 13);
        [cceptDisCountButton setImage:[UIImage imageNamed:@"confirmType_back"] forState:UIControlStateNormal];
        [cceptDisCountButton setImage:[UIImage imageNamed:@"confirm_type"] forState:UIControlStateSelected];
        [cceptDisCountButton addTarget:self action:@selector(acceptDisCountBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cceptDisCountButton.layer.borderColor = kLineColor.CGColor;
        cceptDisCountButton.selected=YES;
        [self addSubview:cceptDisCountButton];
        self.acceptDisCountBtn = cceptDisCountButton;
        
        CGFloat judgeLabX=kMiddleMargin + kDefaultMargin*2 + 15;
        UILabel *judgelab=[[UILabel alloc]initWithFrame:CGRectMake(judgeLabX, discountBoolY-3, 30, 22)];
        judgelab.text=@"同意";
        judgelab.textColor=kTextColor;
        judgelab.font=kSmallTextFont;
        judgelab.textAlignment=NSTextAlignmentLeft;
        [self addSubview:judgelab];
        
        CGFloat discountBoolButtonX = judgeLabX+30+3;
        UIButton *discountBoolTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        discountBoolTitle.frame=CGRectMake(discountBoolButtonX, discountBoolY-3, 200, 22);
        [discountBoolTitle setTitle:[NSString stringWithFormat:@"《 %@ 》",StringUseAgreement] forState:UIControlStateNormal];
        [discountBoolTitle setTitleColor:kBlueColor forState:UIControlStateNormal];
        discountBoolTitle.titleLabel.font = [UIFont systemFontOfSize:kSmallTextFontSize];
        [discountBoolTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [discountBoolTitle addTarget:self action:@selector(getDiscountBool:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:discountBoolTitle];
        self.discountBoolBtn = discountBoolTitle;
        
        
        
        CGFloat loginBtnY = discountBoolY  +self.acceptDisCountBtn.frame.size.height+ kDefaultMargin;
        
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(kMiddleMargin, loginBtnY, width, kButtonHeight);
        registerBtn.layer.cornerRadius = kRadius;
        registerBtn.layer.masksToBounds = YES;
        registerBtn.titleLabel.font = kLargeTextFont;
        [registerBtn setTitle: StringRegisterComplate forState:UIControlStateNormal];
        [registerBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        registerBtn.backgroundColor = kButtonColor;
        [registerBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registerBtn];
        self.registerBtn = registerBtn;

    }
    return self;
}
//发送手机验证码成功，调用方法
-(void)CaptchasTime:(void (^)(void))block
{
    [_time invalidate];
    _getCaptchasBtn.enabled=NO;
    _CaptchasTime=30;
    [self getCaptchasTimeClick:_CaptchasTime];
}
-(void)CaptchasTimeState:(void (^)(void))block
{
    [_time invalidate];
}
-(void)getCaptchasTimeClick:(NSInteger)time
{
    _time=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeClick) userInfo:0 repeats:YES];
}
-(void)timeClick
{
    if (_CaptchasTime==1) {
        [_time invalidate];
        _getCaptchasBtn.enabled=YES;
        _CaptchasTime=30;
    }
    NSLog(@"%d",_CaptchasTime);
    NSInteger middleTime=_CaptchasTime;
    middleTime--;
    _CaptchasTime=middleTime;
    [_getCaptchasBtn setTitle:[NSString stringWithFormat:@"%d s",_CaptchasTime] forState:UIControlStateDisabled];
    
}



#pragma mark - private methods

- (void)getCaptchas:(UIButton *)button
{
    if (self.captchasBlk) {
        self.captchasBlk();
    }
}
- (void)next:(UIButton *)button
{
    if (self.registerBtnBlk) {
        self.registerBtnBlk();
    }
}

- (void)getInfo:(UIButton *)button
{
    if (self.infoBtnBlk) {
        self.infoBtnBlk();
    }
}
- (void)getDiscountBool:(UIButton *)button
{
    if (self.discountBoolBtnBlk) {
        self.discountBoolBtnBlk();
    }
}
-(void)acceptDisCountBtnClick
{
    if(self.acceptDisCountBtn.selected)
    {
        [self.acceptDisCountBtn setSelected:NO];
    }else{
        [self.acceptDisCountBtn setSelected:YES];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"%f,%f",kScreenHeight,kKeyboardHeight);
    int y = kScreenHeight - kKeyboardHeight -80-64;
    CGRect frame = textField.frame;
    int moveY = 0;
    if (frame.origin.y+frame.size.height > y)
    {
        NSLog(@"%f",frame.origin.y+frame.size.height);
        moveY = frame.origin.y+frame.size.height - y;
        
    }
    
        [self moveViewWhentextFieldBeginEdding:moveY];


}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    int y = kScreenHeight - kKeyboardHeight - 80 - 64;
    CGRect frame = textField.frame;
    int moveY = 0;
    
    if (frame.origin.y+frame.size.height > y)
    {
        moveY = frame.origin.y+frame.size.height - y;
    }
    
    
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void) moveViewWhentextFieldBeginEdding:(float) moveY
{
    
    _textFieldMove=moveY;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
    frame.origin.y -= _textFieldMove;//view的Y轴上移
    frame.size.height += _textFieldMove; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}

- (void) moveViewWhentextFieldEndEdding:(float) moveY
{

    _textFieldMove=moveY;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
    frame.origin.y += _textFieldMove;//view的Y轴上移
    frame.size.height -= _textFieldMove; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
    
}
@end
