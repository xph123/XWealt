//
//  CXRegisterViewController.m
//  Link
//
//  Created by chx on 14-12-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXRegisterViewController.h"
#import "NSString+MD5.h"
#import "NSString+ThreeDES.h"
#import "CXServiceProvisionViewController.h"
#import "CXAboutViewController.h"

@interface CXRegisterViewController ()

@property (nonatomic, strong) NSString *beginTime;
@end

@implementation CXRegisterViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringRegister;
    
//    UIImageView *viewBg = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [viewBg setImage:IMAGE(@"allview_bg")];
//    viewBg.alpha = 0.5;
//    viewBg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:viewBg];
    
    CGFloat regViewY = 0;
    regViewY = kViewBeginOriginY;
    CGFloat regViewHeight = self.view.frame.size.height-regViewY;
    CGRect rect = CGRectMake(0, regViewY, kScreenWidth, regViewHeight);
    CXRegisterStepOneView *registerView = [[CXRegisterStepOneView alloc] initWithFrame:rect];
    [self.view addSubview:registerView];
    self.registerStepOneView = registerView;
    
//    self.registerStepOneView.userName.delegate = self;
//    self.registerStepOneView.captchas.delegate = self;
    __unsafe_unretained CXRegisterViewController *weak_self = self;
    self.registerStepOneView.captchasBlk = ^{
        [weak_self getCaptchasClick];
    };
    self.registerStepOneView.registerBtnBlk = ^{
        [weak_self nextBtnClick];
    };
    self.registerStepOneView.infoBtnBlk = ^{
        [weak_self getInfoClick];
    };
    self.registerStepOneView.discountBoolBtnBlk = ^{
        [weak_self provisionBtnClick];
    };
    //点击空白 缩回键盘
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardDidHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
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

    
    [CXDataCenter queryParamsForLogin:parameters.parameters strURL:GET_AUTHCODE result:^(CXMainPlate *mainPlate, NSError *err) {
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
              //发送验证码成功，传值
            [_registerStepOneView CaptchasTime:^{
                
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
- (void) sendRegister
{
    // 获取设备信息
    UIDevice *device_=[[UIDevice alloc] init];
    
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
    [parameters appendParameterWithName:@"phone" andStringValue:_userName];
    [parameters appendParameterWithName:@"userPwd"  andStringValue:ret];
    [parameters appendParameterWithName:@"recomment"  andStringValue:_invitationCode];
    NSInteger stateNum=1;
    //判断是否加密
    [parameters appendParameterWithName:@"state" andLongValue:stateNum];
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
    
    [CXDataCenter queryParamsForLogin:parameters.parameters strURL:GET_REGBYPHONE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"regbyphone success");
            
            [self loginWithUserName:_userName andPassword:_password andAutoLogin:NO];
            
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
            
            CXUserModel *userModel = mainPlate.anyModels[0];
            [self updateUserInfo:userModel];
            NSDictionary *userDic = [[NSDictionary alloc] initWithContentsOfFile:kAppDelegate.currentUserInfoFileName];
            CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
            kAppDelegate.currentUserModel = model;
            [kAppDelegate getUserData:YES];
            
            //选择专属理财师
//            if ([self.invitationCode isEqualToString:@""]||self.invitationCode==nil) {
//                CXSelectFinanciersViewController *selectfinanciersView=[[CXSelectFinanciersViewController alloc]init];
//                [self.navigationController pushViewController:selectfinanciersView animated:YES];
//            }
//            else
//            {
                 [self.navigationController popToRootViewControllerAnimated:YES];
//            }
            [self loadDataFromServer];
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
    [_registerStepOneView.userName endEditing:YES];
    [_registerStepOneView.userName resignFirstResponder];
    [_registerStepOneView.captchas endEditing:YES];
    [_registerStepOneView.captchas resignFirstResponder];
    [_registerStepOneView.password endEditing:YES];
    [_registerStepOneView.password resignFirstResponder];
    [_registerStepOneView.invitationCode endEditing:YES];
    [_registerStepOneView.invitationCode resignFirstResponder];
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


- (void)updateUserInfo:(CXUserModel *)userModel
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
    //    kAppDelegate.currentUserModel = _userModel;
    
    NSDictionary *userDic = [userModel saveToNSDictionary];
    [userDic writeToFile:kAppDelegate.currentUserInfoFileName atomically:YES];
    
    [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUser:userModel];
}

#pragma mark - action events
//获取验证码
- (void) getCaptchasClick
{
    [self hideKeyView];
    _userName = self.registerStepOneView.userName.text;
    
    //NSLog(@"%@",XStringHelper);
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

- (void) nextBtnClick
{
    [self hideKeyView];
//    CXSelectFinanciersViewController *selectfinanciersView=[[CXSelectFinanciersViewController alloc]init];
//    [self.navigationController pushViewController:selectfinanciersView animated:YES];

    
    _userName = _registerStepOneView.userName.text;
       if (![XStringHelper isValidateTelePhone:_userName])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StirngValidPhone;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    _captchas = _registerStepOneView.captchas.text;
    
    if (_captchas.length != 6)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringValidCaptchas;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    if (_registerStepOneView.acceptDisCountBtn.selected==NO)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StirngProtocolBool;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }

    [self sendVerifyAuthcode];
}
- (void)registerBtnClick
{
    [self hideKeyView];
    
    _password = _registerStepOneView.password.text;
    
    if (_password.length < 6 || _password.length > 18)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringValidPassword;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    _invitationCode = _registerStepOneView.invitationCode.text;
    
    
    
    [self sendRegister];
}


- (void) getInfoClick
{
    [self hideKeyView];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"什么是邀请码" message:@"【邀请码】是高搜易财富理财师的专属号，填写邀请码注册，您将有机会获得理财师专属的免费服务！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
    
}

- (void) provisionBtnClick
{
    CXAboutViewController *aboutControl = [[CXAboutViewController alloc] init];
    NSString *aboutUrl=@"/mobile/public/protocol.jsp";
    aboutControl.connectionUrl=[kBaseURLString stringByAppendingString:aboutUrl];
    aboutControl.hidesBottomBarWhenPushed = YES;
    aboutControl.name=@"软件许可与服务协议";
    [self.navigationController pushViewController:aboutControl animated:YES];
}







-(void)keyboardDidHide:(NSNotification *)not{
    
    [self.view endEditing:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    //结束计时器
    [_registerStepOneView CaptchasTimeState:^{
        
    }];
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
