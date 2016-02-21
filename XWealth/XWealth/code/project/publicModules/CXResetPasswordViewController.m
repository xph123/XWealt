//
//  CXResetPasswordViewController.m
//  XWealth
//
//  Created by chx on 15/6/29.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXResetPasswordViewController.h"
#import "CXLoginViewController.h"
#import "NSString+MD5.h"
#import "NSString+ThreeDES.h"
@interface CXResetPasswordViewController ()

@end

@implementation CXResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringEditPassword;
    
//    UIImageView *viewBg = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [viewBg setImage:IMAGE(@"allview_bg")];
//    viewBg.alpha = 0.5;
//    viewBg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:viewBg];
    
    
    CGFloat regViewY =  kMiddleMargin + kViewBeginOriginY;
    CGFloat regViewHeight = 200;
    CGRect rect = CGRectMake(kDefaultMargin, regViewY, kScreenWidth - 2 * kDefaultMargin, regViewHeight);
    CXResetPasswordView *resetPwView = [[CXResetPasswordView alloc] initWithFrame:rect];
    [self.view addSubview:resetPwView];
    self.resetPwView = resetPwView;
    
    self.resetPwView.passwordOld.delegate = self;
    self.resetPwView.password1.delegate = self;
    self.resetPwView.password2.delegate = self;
    __unsafe_unretained CXResetPasswordViewController *weak_self = self;
    self.resetPwView.certainBlk = ^{
        [weak_self certainBtnClick];
    };
    //点击空白处 隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)keyboardHide:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self hideKeyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - network data & data

- (void) sendEditPassword
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    NSString *strkey=@"ViaVia";
    strkey=[strkey md5Min];
    NSString *key=[strkey substringToIndex:24];
    NSString* retOld = [NSString TripleDES:self.passwordOld encryptOrDecrypt:kCCEncrypt key:key];
    NSString* retNet = [NSString TripleDES:self.password1 encryptOrDecrypt:kCCEncrypt key:key];
    NSInteger stateNum=1;

    XHttpParameters *parameters = [XHttpParameters parameters];
    //判断是否加密
    [parameters appendParameterWithName:@"state" andLongValue:stateNum];
    [parameters appendParameterWithName:@"oldpwd" andStringValue:retOld];
    [parameters appendParameterWithName:@"newpwd" andStringValue:retNet];
     
    [CXDataCenter queryParamsForLogin:parameters.parameters strURL:GET_EDITPWD result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"sendEditPassword success");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
//            hud.labelText = PromptPraiseSuccess;
            hud.detailsLabelText = PromptPraiseSuccess;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

            [self performSelector:@selector(reLogin) withObject:nil afterDelay:1.1f];
            
        }
        else
        {
            XLog(@"sendEditPassword fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = (NSString*)err;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];

}

#pragma mark - private methods

- (void) reLogin
{
    [kAppDelegate getUserData:NO];
    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
    loginViewController.userName = kAppDelegate.currentUserModel.userName;
    loginViewController.loginWay=1;//重置所有登录
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    kAppDelegate.window.rootViewController = navigationController;
    
//    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//    loginViewController.userName = kAppDelegate.currentUserModel.userName;
//    loginViewController.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void) hideKeyView
{
    [self.resetPwView.passwordOld endEditing:YES];
    [self.resetPwView.passwordOld resignFirstResponder];
    [self.resetPwView.password1 endEditing:YES];
    [self.resetPwView.password1 resignFirstResponder];
    [self.resetPwView.password2 endEditing:YES];
    [self.resetPwView.password2 resignFirstResponder];
}

#pragma mark - action events

- (void)certainBtnClick
{
    [self hideKeyView];
    
    _passwordOld = self.resetPwView.passwordOld.text;
    _password1 = self.resetPwView.password1.text;
    _password2 = self.resetPwView.password2.text;
  
    [self hideKeyView];
    
    if (_passwordOld.length < 6 || _passwordOld.length > 18
        || _password1.length < 6 || _password1.length > 18
        || _password2.length < 6 || _password2.length > 18)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
//        hud.labelText = StringValidPassword;
        hud.detailsLabelText = StringValidPassword;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    if (![_password1 isEqualToString:_password2])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = StringPasswordDiff;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    //    _password = [_password md5];
    
    [self sendEditPassword];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//-(void) textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField == _registerView.password || textField == _registerView.userName)
//    {
//        NSTimeInterval animationDuration = 0.30f;
//        float moveY = kTextFieldHeight + kDefaultMargin;
//        
//        if (textField == _registerView.password)
//        {
//            moveY += kTextFieldHeight + kDefaultMargin;
//        }
//        
//        CGRect frame = self.view.frame;
//        frame.origin.y -= moveY;//view的Y轴上移
//        frame.size.height += moveY; //View的高度增加
//        
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];//设置调整界面的动画效果
//    }
//}
//
//-(void) textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField == _registerView.password || textField == _registerView.userName)
//    {
//        NSTimeInterval animationDuration = 0.30f;
//        float moveY = kTextFieldHeight + kDefaultMargin;
//        
//        if (textField == _registerView.password)
//        {
//            moveY += kTextFieldHeight + kDefaultMargin;
//        }
//        
//        CGRect frame = self.view.frame;
//        frame.origin.y += moveY;//view的Y轴上移
//        frame.size.height -= moveY; //View的高度增加
//        
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];//设置调整界面的动画效果
//        [textField resignFirstResponder];
//    }
//}


@end
