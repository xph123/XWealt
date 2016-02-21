//
//  CXOnlyResetPasswordView.m
//  XWealth
//
//  Created by gsycf on 16/1/6.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import "CXOnlyResetPasswordView.h"

@implementation CXOnlyResetPasswordView
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
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        
        
        CGFloat nameY = 0;
        CGFloat nameHeight = kLabelHeight;
        UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, nameY, frame.size.width - 2*kDefaultMargin, nameHeight)];
        namelab.font = kLargeTextFont;
        namelab.text = @"关于《提升账户安全》的公告";
        namelab.numberOfLines = 1;
        namelab.textColor=[UIColor redColor];
        namelab.backgroundColor = kColorClear;
        namelab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:namelab];

        
        CGFloat titleY = namelab.frame.origin.y+namelab.frame.size.height;
        CGFloat titleHeight = kLabelHeight*2;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, titleY, frame.size.width - 50, titleHeight)];
        title.font = kMiddleTextFont;
        title.textColor = kTextColor;
        title.text = @"您的账户存在异常，为保障账户安全，请重置密码！";
        title.numberOfLines = 3;
        title.backgroundColor = kColorClear;
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        CGFloat width = frame.size.width - 2 * kMiddleMargin;
        CGFloat y = titleY + titleHeight + kMiddleMargin;
        
        UIImage *inputBackground = [[UIImage imageNamed:@"bg_multi_line_input"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        UIImageView *textViewBgImageView = [[UIImageView alloc] initWithImage:inputBackground];
        textViewBgImageView.frame = CGRectMake(kMiddleMargin, y, width, kTextFieldHeight * 4 + 3);
//        textViewBgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:textViewBgImageView];
        
        UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, y, width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [userName setBorderStyle:UITextBorderStyleRoundedRect];
        [userName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [userName setReturnKeyType:UIReturnKeyDone];
        userName.placeholder = StringPhone;
        userName.delegate=self;
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
        captchas.placeholder = StringCaptchas;
        captchas.backgroundColor = kColorWhite;
        captchas.delegate=self;
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
        password.delegate=self;
        password.placeholder = StringPassword;
        password.secureTextEntry = YES;
        [self addSubview:password];
        self.password = password;
        
        CGFloat lineViewY3 = passwordY + kTextFieldHeight;
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kMiddleMargin, lineViewY3, width, 0.5)];
        lineView3.backgroundColor = kLineColor;
        [self addSubview:lineView3];
        
        CGFloat iconfirmPawY = lineViewY3 + 1;
        UITextField *iconfirmPaw = [[UITextField alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, iconfirmPawY, width - 2 * kDefaultMargin, kTextFieldHeight)];
        //        [invitationCode setBorderStyle:UITextBorderStyleRoundedRect];
        [iconfirmPaw setClearButtonMode:UITextFieldViewModeWhileEditing];
        [iconfirmPaw setReturnKeyType:UIReturnKeyDone];
        iconfirmPaw.delegate=self;
        iconfirmPaw.placeholder = StringCertainPassword;
        iconfirmPaw.secureTextEntry = YES;
        [self addSubview:iconfirmPaw];
        self.iconfirmPaw = iconfirmPaw;
        
        
        CGFloat certainBtnY = iconfirmPawY + kTextFieldHeight + kLargeMargin;
        
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
        
        
        CGFloat PromptlabY = certainBtn.frame.origin.y+certainBtn.frame.size.height+kMiddleMargin;
        CGFloat PromptlabHeight = kLabelHeight*2;
        UILabel *Promptlab = [[UILabel alloc] initWithFrame:CGRectMake(25, PromptlabY, frame.size.width - 50, PromptlabHeight)];
        Promptlab.font = kSmallTextFont;
        Promptlab.textColor = kAssistTextColor;
        Promptlab.text = @"完成验证可参与手机邀请有礼活动，积分换取奖品";
        Promptlab.numberOfLines = 3;
        Promptlab.backgroundColor = kColorClear;
        Promptlab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:Promptlab];

        
        
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
