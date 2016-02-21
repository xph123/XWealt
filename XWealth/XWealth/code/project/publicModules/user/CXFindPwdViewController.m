//
//  CXFindPwdViewController.m
//  Link
//
//  Created by chx on 15-3-16.
//  Copyright (c) 2015年 51sole. All rights reserved.
//

#import "CXFindPwdViewController.h"
#import "NSString+MD5.h"
#import "NSString+ThreeDES.h"

@interface CXFindPwdViewController ()

@end

@implementation CXFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringFindPwd;
    
//    UIImageView *viewBg = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [viewBg setImage:IMAGE(@"allview_bg")];
//    viewBg.alpha = 0.5;
//    viewBg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:viewBg];
    
    CGFloat regViewY = kViewBeginOriginY + kMiddleMargin;
    CGFloat regViewHeight = 350;
    CGRect rect = CGRectMake(kDefaultMargin, regViewY, kScreenWidth - 2 * kDefaultMargin, regViewHeight);
    CXFindPwdView *findPwdView = [[CXFindPwdView alloc] initWithFrame:rect];
    if ([XStringHelper isValidateEmail:_userName])
    {
        findPwdView.userName.text = _userName;
    }
    [self.view addSubview:findPwdView];
    self.findPwdView = findPwdView;
    
    self.findPwdView.userName.delegate = self;
    self.findPwdView.password.delegate = self;
    self.findPwdView.captchas.delegate = self;

    
    __unsafe_unretained CXFindPwdViewController *weak_self = self;
    self.findPwdView.certainBlk = ^{
        [weak_self certainBtnClick];
    };
    self.findPwdView.captchasBlk = ^{
        [weak_self getCaptchasClick];
    };
    //点击空白，隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action events

- (void) getCaptchasClick
{
    [self hideKeyView];
    _userName = self.findPwdView.userName.text;
    
    if (![XStringHelper isValidateTelePhone:_userName])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StirngValidPhone;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    [self sendGetCaptchas];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)certainBtnClick
{
    _userName = _findPwdView.userName.text;
    [self hideKeyView];
    
    if (![XStringHelper isValidateTelePhone:_userName])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StirngValidPhone;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    _captchas = _findPwdView.captchas.text;
    
    if (_captchas.length != 6)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringValidCaptchas;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }

    
    _password = _findPwdView.password.text;
    
    if (_password.length < 6 || _password.length > 18)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringValidPassword;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    //    _password = [_password md5];
    
    
    [self sendFindPwd];
}

#pragma mark - network data & data

- (void) sendGetCaptchas
{
    // 获取设备信息
    UIDevice *device_=[[UIDevice alloc] init];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    
    // 设备识别码
    [parameters appendParameterWithName:@"identification" andStringValue:device_.identifierForVendor.UUIDString];
    // 设备运行的系统
    [parameters appendParameterWithName:@"system" andStringValue:device_.systemName];
    // 当前系统的版本
    [parameters appendParameterWithName:@"version" andStringValue:device_.systemVersion];
    // 设备的的本地化版本
    [parameters appendParameterWithName:@"model" andStringValue:device_.localizedModel];
    // 设备的类别
    [parameters appendParameterWithName:@"brand" andStringValue:device_.model];
    
    NSString *authcode = [NSString stringWithFormat:@"%@%@%@%@%@%@", device_.identifierForVendor.UUIDString, device_.systemName, device_.systemVersion, device_.localizedModel, device_.model, _userName];
    authcode = [authcode md5];
    [parameters appendParameterWithName:@"authcode" andStringValue:authcode];
    [parameters appendParameterWithName:@"phone" andStringValue:_userName];
    
    
    [CXDataCenter queryParams:parameters.parameters strURL:GET_FINDPWDSMS result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"authcode success");
            if (mainPlate.service && mainPlate.service.length > 0)
            {
                kAppDelegate.sessionId = mainPlate.service;
            }
            [self ShowProgressHUB:@"验证码已发送，请注意查收！"];
            //            NSString *authcode = mainPlate.anyModels[0];
            //            self.captchas = authcode;
            //            self.registerStepOneView.captchas.text = authcode;
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}

- (void) sendFindPwd
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    NSString *strkey=@"ViaVia";
    strkey=[strkey md5Min];
    NSString *key=[strkey substringToIndex:24];
    NSString* ret = [NSString TripleDES:_password encryptOrDecrypt:kCCEncrypt key:key];

    XHttpParameters *parameters = [XHttpParameters parameters];
    NSInteger stateNum=1;
    //判断是否加密
    [parameters appendParameterWithName:@"state" andLongValue:stateNum];
    [parameters appendParameterWithName:@"phone" andStringValue:_userName];
    [parameters appendParameterWithName:@"newpwd"  andStringValue:ret];
    [parameters appendParameterWithName:@"authcode"  andStringValue:_captchas];
    
    [CXDataCenter queryParams:parameters.parameters strURL:GET_EDITPWD_BYPHONE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"find password success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                [self ShowProgressHUB:@"密码修改成功，请用新密码登录！"];
                
                [self goBack];
            }
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}

#pragma mark - private methods

- (void) hideKeyView
{
    [_findPwdView.userName endEditing:YES];
    [_findPwdView.userName resignFirstResponder];
    [_findPwdView.password endEditing:YES];
    [_findPwdView.password resignFirstResponder];
}

@end
