//
//  CXLoginViewController.m
//  Link
//
//  Created by chx on 14-11-7.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXLoginViewController.h"
#import "CXRegisterViewController.h"
#import "CXFindPwdViewController.h"
#import "NSString+MD5.h"
#import "NSString+ThreeDES.h"
#import "CXOnlyResetPasswordViewController.h"

@interface CXLoginViewController ()

@end

@implementation CXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringLogin;
    
//    UIImageView *viewBg = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [viewBg setImage:IMAGE(@"allview_bg")];
//    viewBg.alpha = 0.5;
//    viewBg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:viewBg];
    
    NSString *promptTitle = @"高手一账通";
    UILabel *promptTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin, kViewBeginOriginY + kDefaultMargin, kScreenWidth - 2 * kMiddleMargin, kLabelHeight)];
    promptTitleLabel.font = kLargeTextFontBold;
    promptTitleLabel.textColor = kTextColor;
    promptTitleLabel.numberOfLines = 1;
    promptTitleLabel.textAlignment = NSTextAlignmentCenter;
    promptTitleLabel.backgroundColor = [UIColor clearColor];
    promptTitleLabel.text = promptTitle;
    [self.view addSubview:promptTitleLabel];
    
    NSString *prompt = @"您可以使用掌富宝、信托宝、高手帮等高搜易平台注册的账号登录！";
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMiddleMargin + kDefaultMargin, kViewBeginOriginY + kDefaultMargin + kLabelHeight, kScreenWidth - 2 * (kMiddleMargin + kDefaultMargin), kTwoLineLabelHeight)];
    promptLabel.font = kMiddleTextFont;
    promptLabel.textColor = kAssistTextColor;
    promptLabel.numberOfLines = 2;
    promptLabel.textAlignment = NSTextAlignmentLeft;
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.text = prompt;
    [self.view addSubview:promptLabel];
  
    
    CGFloat loginViewY = kViewBeginOriginY + kDefaultMargin + kLabelHeight + kTwoLineLabelHeight;
    CGFloat loginViewHeight = self.view.frame.size.height - 2 * kDefaultMargin;
    CGRect rect = CGRectMake(kDefaultMargin, loginViewY, kScreenWidth - 2 * kDefaultMargin, loginViewHeight);
    CXLoginView *loginView = [[CXLoginView alloc] initWithFrame:rect];
    if (self.userName && self.userName.length > 0)
    {
        loginView.userName.text = self.userName;
    }
    [self.view addSubview:loginView];
    self.loginView = loginView;
    
    __unsafe_unretained CXLoginViewController *weak_self = self;
    self.loginView.loginBlk = ^{
        [weak_self loginBtnClick];
    };
    
    self.loginView.regBlk = ^{
        [weak_self registerBtnClick];
    };

    self.loginView.forgetBlk = ^{
        [weak_self forgotBtnClick];
    };
    //手势点击，缩回键盘
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
//    [_loginView.userName becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self hideKeyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) hideKeyView
{
    [_loginView.userName endEditing:YES];
    [_loginView.userName resignFirstResponder];
    [_loginView.password endEditing:YES];
    [_loginView.password resignFirstResponder];
}


#pragma mark - action events
//注册按钮
- (void)registerBtnClick
{
    [self hideKeyView];
    CXRegisterViewController *registerControl = [[CXRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerControl animated:YES];
}

- (void)loginBtnClick
{
    _userName = _loginView.userName.text;
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
    
    _password = _loginView.password.text;
    
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
    
    if (self.loginWay==1) {
        [self loginWithUserName:_userName andPassword:_password andAutoLogin:YES];
    }
    else
    {
        [self loginWithUserName:_userName andPassword:_password andAutoLogin:NO];
    }
    
}

- (void)forgotBtnClick
{
    _userName = _loginView.userName.text;
    [self hideKeyView];
    CXFindPwdViewController *findPwdControl = [[CXFindPwdViewController alloc] init];
    if ([XStringHelper isValidateEmail:_userName])
    {
        findPwdControl.userName = _userName;
    }
    [self.navigationController pushViewController:findPwdControl animated:YES];

}

// 用户登录
- (void) loginWithUserName:(NSString*) userName andPassword:(NSString *)password andAutoLogin:(BOOL)isAuto
{
    [self loginWithUserName:userName andPassword:password andIsEntryForeground:false andAutoLogin:isAuto];
}

// 用户登录
- (void) loginWithUserName:(NSString*) userName andPassword:(NSString *)password andIsEntryForeground:(BOOL)isEntryForeground andAutoLogin:(BOOL)isAuto
{
    _userName = userName;
    _password = password;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringLogining;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    // 获取设备信息
    UIDevice *device_=[[UIDevice alloc] init];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"username" andStringValue:_userName];
    
    
     NSString *strkey=@"ViaVia";
     strkey=[strkey md5Min];
     NSString *key=[strkey substringToIndex:24];
     NSString* ret = [NSString TripleDES:_password encryptOrDecrypt:kCCEncrypt key:key];
     NSInteger stateNum=1;
    //判断是否加密
    [parametersUtil appendParameterWithName:@"state" andLongValue:stateNum];
    
    [parametersUtil appendParameterWithName:@"userPwd" andStringValue:ret];
    // 设备识别码
    [parametersUtil appendParameterWithName:@"identification" andStringValue:device_.identifierForVendor.UUIDString];
    // 设备运行的系统
    [parametersUtil appendParameterWithName:@"system" andStringValue:device_.systemName];
    // 当前系统的版本
    [parametersUtil appendParameterWithName:@"version" andStringValue:device_.systemVersion];
    // 设备的的本地化版本
    [parametersUtil appendParameterWithName:@"model" andStringValue:device_.localizedModel];
    // 设备的类别
    [parametersUtil appendParameterWithName:@"brand" andStringValue:device_.model];
    
    [CXDataCenter queryParamsForLogin:parametersUtil.parameters strURL:GET_LOGIN result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {

            
            XLog(@"login success");
            if (mainPlate.service && mainPlate.service.length > 0)
            {
                kAppDelegate.sessionId = mainPlate.service;
            }
            
            kAppDelegate.hasLogined = YES;
            
            
            if (isAuto == YES) {
                // 从后台进入前台自动登录时，发送通知给任务，更新任务数据
                if (isEntryForeground == true)
                {
                   
                    CXUserModel *myCurrentUserModel=kAppDelegate.currentUserModel;
                    if ([myCurrentUserModel.userName isEqualToString:@""]) {
                        [[CXDBHelper sharedDBHelper] createDB:kAppDelegate.currentUserDBFileName];
                        // 在这里重新读一次，因为在后台进入时出现已登录，却没有数据的情况
                        NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:kAppDelegate.currentUserInfoFileName];
                        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
                        kAppDelegate.currentUserModel = model;
                    }
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:NOTIFICATION_ENTRY_FOREGROUND object:nil];
                }
                else
                {
                    CXUserModel *userModel = mainPlate.anyModels[0];
//                    userModel.pwdupdstate=0;
                    if (userModel.pwdupdstate==0) {
                        kAppDelegate.hasLogined = NO;
 
                        
                        [kAppDelegate EnterResePassword];
                    }
                    else
                    {
                        [self updateUserInfo:userModel];
                        [kAppDelegate EnterMainView];
                        [kAppDelegate getUserData:YES];
                    }
                }

            }
            else
            {
                // 从后台进入前台自动登录时，发送通知给任务，更新任务数据
                if (isEntryForeground == true)
                {
                    CXUserModel *myCurrentUserModel=kAppDelegate.currentUserModel;
                    if ([myCurrentUserModel.userName isEqualToString:@""]) {
                        [[CXDBHelper sharedDBHelper] createDB:kAppDelegate.currentUserDBFileName];
                        // 在这里重新读一次，因为在后台进入时出现已登录，却没有数据的情况
                        NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:kAppDelegate.currentUserInfoFileName];
                        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
                        kAppDelegate.currentUserModel = model;
                    }
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:NOTIFICATION_ENTRY_FOREGROUND object:nil];
                }
                else
                {
                    //手动登录
                    CXUserModel *userModel = mainPlate.anyModels[0];
                    if (userModel.pwdupdstate==0) {
                        kAppDelegate.hasLogined = NO;
                        [kAppDelegate EnterResePassword];
                    }
                    else
                    {
                        [self updateUserInfo:userModel];
                        NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:kAppDelegate.currentUserInfoFileName];
                        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
                        kAppDelegate.currentUserModel = model;
                        [self.navigationController popViewControllerAnimated:YES];
                        [kAppDelegate getUserData:YES];
                    }
                   
                }

            }
            [self loadDataFromServer];
        }
        else
        {
            if (isAuto == YES)
            {
                kAppDelegate.hasLogined = NO;
                // 自动登录不成功，直接让他进入
                [kAppDelegate EnterMainView];
            }
            else
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = (NSString*)err;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
    }];
}

- (void)checkCurrentUserFolder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *userFolder = [kAppDelegate.userFolder stringByAppendingPathComponent:_userName];
    kAppDelegate.currentUserFolder = userFolder;
    
    // 若不存在userFolder，则建立该文件夹
    if (![fileManager fileExistsAtPath:userFolder])
    {
        [fileManager createDirectoryAtPath:userFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


- (void)updateUserInfo:( CXUserModel *)userModel
{
    [self checkCurrentUserFolder];
    
    // user/XXXXXXXX/XXXXX.plist
    NSString *fileName = [NSString stringWithFormat:@"%@.plist", _userName];
    NSString *path = [kAppDelegate.currentUserFolder stringByAppendingPathComponent:fileName];
    kAppDelegate.currentUserInfoFileName = path;
    
    // user/XXXXXXXX/XXXXX.db
    NSString *dbFileName = [NSString stringWithFormat:@"%@.db", _userName];
    NSString *dbPath = [kAppDelegate.currentUserFolder stringByAppendingPathComponent:dbFileName];
    kAppDelegate.currentUserDBFileName = dbPath;
    
    // user/user.plist
    if (kAppDelegate.userPlistFileName || kAppDelegate.userPlistFileName.length == 0)
    {
        kAppDelegate.userPlistFileName = [kAppDelegate.userFolder stringByAppendingPathComponent:@"user.plist"];
    }
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [userInfoDic setObject:_userName forKey:kParameterUserName];
    [userInfoDic setObject:_password forKey:kParameterPassword];
    [userInfoDic writeToFile:kAppDelegate.userPlistFileName atomically:YES];
    
    // 登录成功后，返回用户数据，把用户数据赋值给kAppDelegate.currentUserModel，并写入到kAppDelegate.currentUserInfoFileName
//    CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
//    kAppDelegate.currentUserModel = model;
    
    
    NSDictionary *userDic = [userModel saveToNSDictionary];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:userDic];
    [dictionary writeToFile:kAppDelegate.currentUserInfoFileName atomically:YES];
    
    [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUser:userModel];
    
}
//获取服务器上离线数据
- (void) loadDataFromServer
{
    NSString *msgiIdStr;
    if (kAppDelegate.hasLogined) {
        msgiIdStr=[CXReceiveMessages queryLastDatatable:kAppDelegate.currentUserModel.userName];
    }
    if ([msgiIdStr isEqualToString:@"(null)"]||[msgiIdStr isEqualToString:@""]) {
        msgiIdStr=@"";
    }
    XHttpParameters *parametersUtil=[XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"msgId" andStringValue:msgiIdStr];
     [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_LISTMESSAGE result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get data list success");
            NSMutableArray *sourceDatas=[[NSMutableArray alloc]init];
            [sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [CXReceiveMessages creatFile:kAppDelegate.currentUserModel.userName];
            [CXReceiveMessages updateLocalData:sourceDatas andfileName:kAppDelegate.currentUserModel.userName];
            
        }
        else
        {
            XLog(@"get data list fail");
        }
    }];
}

@end
