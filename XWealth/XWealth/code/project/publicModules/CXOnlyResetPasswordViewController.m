//
//  CXOnlyResetPasswordViewController.m
//  XWealth
//
//  Created by gsycf on 16/1/6.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import "CXOnlyResetPasswordViewController.h"
#import "CXOnlyResetPasswordView.h"
#import "NSString+MD5.h"
#import "NSString+ThreeDES.h"
@interface CXOnlyResetPasswordViewController ()

@end

@implementation CXOnlyResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringResetPwd;
    
    //    UIImageView *viewBg = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    [viewBg setImage:IMAGE(@"allview_bg")];
    //    viewBg.alpha = 0.5;
    //    viewBg.contentMode = UIViewContentModeScaleAspectFit;
    //    [self.view addSubview:viewBg];
    
    CGFloat regViewY = kViewBeginOriginY + kDefaultMargin;
    CGFloat regViewHeight = self.view.frame.size.height-regViewY;
    CGRect rect = CGRectMake(kDefaultMargin, regViewY, kScreenWidth - 2 * kDefaultMargin, regViewHeight);
    CXOnlyResetPasswordView *findPwdView = [[CXOnlyResetPasswordView alloc] initWithFrame:rect];
    if ([XStringHelper isValidateEmail:_userName])
    {
        findPwdView.userName.text = _userName;
    }
    [self.view addSubview:findPwdView];
    self.findPwdView = findPwdView;
    
//    self.findPwdView.userName.delegate = self;
//    self.findPwdView.password.delegate = self;
//    self.findPwdView.captchas.delegate = self;
    
    
    __unsafe_unretained CXOnlyResetPasswordViewController *weak_self = self;
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
    _password2=_findPwdView.iconfirmPaw.text;
    if (![_password2 isEqualToString:_password]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"两次输入的密码不同";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
     [self sendVerifyAuthcode];
    
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
            [_findPwdView CaptchasTime:^{
                
            }];
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
//验证验证码
- (void) sendVerifyAuthcode
{
    XHttpParameters *parameters = [XHttpParameters parameters];
    [parameters appendParameterWithName:@"authcode" andStringValue:_captchas];
    [parameters appendParameterWithName:@"phone" andStringValue:_userName];
    
    [CXDataCenter queryParamsForLogin:parameters.parameters strURL:GET_VERIFY_AUTHCODE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"authcode success");
            if (mainPlate.service && mainPlate.service.length > 0)
            {
                kAppDelegate.sessionId = mainPlate.service;
            }
            
            [self registerBtnClick];
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
    
    NSString *pwdStr=[NSString stringWithFormat:@"key=#$%%#**((>>{Oo0^_^MM]@%%&phone=%@&newpwd=%@",self.userName,ret];
    pwdStr=[pwdStr md5];
    
    XHttpParameters *parameters = [XHttpParameters parameters];

    //判断是否加密
  
    [parameters appendParameterWithName:@"sign"  andStringValue:pwdStr];
    [parameters appendParameterWithName:@"phone" andStringValue:_userName];
    [parameters appendParameterWithName:@"newpwd"  andStringValue:ret];
    
    [CXDataCenter queryParams:parameters.parameters strURL:GET_RESET_USERPWD result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"find password success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                [self ShowProgressHUB:@"密码修改成功，请用新密码登录！"];
                
//                [self goBack];
                [self loginWithUserName:_userName andPassword:_password andAutoLogin:YES];
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
                    [self updateUserInfo:userModel];
                    [kAppDelegate EnterMainView];
                    [kAppDelegate getUserData:YES];

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
                    CXUserModel *userModel = mainPlate.anyModels[0];
                    [self updateUserInfo:userModel];
                    NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:kAppDelegate.currentUserInfoFileName];
                    CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
                    kAppDelegate.currentUserModel = model;
                    [self.navigationController popViewControllerAnimated:YES];
                    [kAppDelegate getUserData:YES];
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
- (void)registerBtnClick
{
    [self hideKeyView];
    
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
    
    _captchas = _findPwdView.captchas.text;
    
    
    [self sendFindPwd];
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
    //    msgiIdStr=@"b09b1a87-2475-4f95-9cb8-c3fd89092164";
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
-(void)viewDidDisappear:(BOOL)animated
{
    //结束计时器
    [_findPwdView CaptchasTimeState:^{
        
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
