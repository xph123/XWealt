//
//  CXModifyTextFieldViewController.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXModifyTextFieldViewController.h"

@interface CXModifyTextFieldViewController ()

@end

@implementation CXModifyTextFieldViewController

- (id) initWithType:(NSString*)type andDefaultText:(NSString*)text
{
    self = [super init];
    
    if (self)
    {
        _text = text;
        _type = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _type;
    self.view.backgroundColor = kControlBgColor;
    
    [self initRightBarButton];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, kMiddleMargin + kViewBeginOriginY, kScreenWidth-20, 40)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField becomeFirstResponder];
    textField.font = kMiddleTextFont;
    textField.text = _text;
    textField.delegate = self;
    if ([_type isEqualToString:StringPhone])
    {
        textField.keyboardType = UIKeyboardTypePhonePad;
    }
    else if ([_type isEqualToString:StringMail])
    {
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if ([_type isEqualToString:StringRecommendMe])
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initRightBarButton
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, 60, 30);
    [saveBtn setTitle:StringSave forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kNavBarTextFont;
    [saveBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveModify:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)saveModify:(UIButton *)button
{
    if ([NSString isBlankString:_textField.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写内容";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    if ([_type isEqualToString:StringMail])
    {
        if (![XStringHelper isValidateEmail:_textField.text])
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入有效的邮箱地址！";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0.7];
            
            return;
        }
    }
    
    if ([_type isEqualToString:StringPhone])
    {
        if (![XStringHelper isValidateTelePhone:_textField.text])
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入有效的手机号码！";
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0.7];
            
            return;
        }
    }
    
    [self.textField resignFirstResponder];
    
    _text = _textField.text;
    
    if ([_type isEqualToString:StringRemarksName])
    {
        [self sendEditRemarksName];
    }
    else if ([_type isEqualToString:StringRemarksEmail])
    {
        [self sendEditRemarksEmail];
    }
    else if ([_type isEqualToString:StringRecommendMe])
    {
        [self sendEditRecommentMe];
    }
    else
    {
        [self setModifyToNetwork];
    }
    
}

- (int) getCurrentType
{
    int type = 0;
    
    if ([_type isEqualToString:StringName])
    {
        type = TypeNickName;
    }
    else if ([_type isEqualToString:StringPhone])
    {
        type = TypePhone;
    }
    else if ([_type isEqualToString:StringMail])
    {
        type = TypeMail;
    }
    else if ([_type isEqualToString:StringSex])
    {
        type = TypeSex;
    }
    else if ([_type isEqualToString:StringSignaute])
    {
        type = TypeSignaute;
    }
    else if ([_type isEqualToString:StringAddress])
    {
        type = TypeAddress;
    }
    else if ([_type isEqualToString:StringOccupation])
    {
        type = TypeOccupation;
    }
    
    return type;
}

- (void) setLocalValueAndNotifaction
{
    XFileValue *file = [[XFileValue alloc] initWithFileName:kAppDelegate.currentUserInfoFileName];
    
    if ([_type isEqualToString:StringName])
    {
        [file setValue:_text forKey:kParameterNickName];
        kAppDelegate.currentUserModel.nickName = _text;
    }
    else if ([_type isEqualToString:StringPhone])
    {
        [file setValue:_text forKey:kParameterTelePhone];
        kAppDelegate.currentUserModel.telePhone = _text;
    }
    else if ([_type isEqualToString:StringMail])
    {
        [file setValue:_text forKey:kParameterMail];
        kAppDelegate.currentUserModel.mail = _text;
    }
    else if ([_type isEqualToString:StringSex])
    {
//        [file setValue:_text forKey:kParameterSex];
//        kAppDelegate.currentUserModel.sex = _text;
    }
    else if ([_type isEqualToString:StringSignaute])
    {
        [file setValue:_text forKey:kParameterSignature];
        kAppDelegate.currentUserModel.signature = _text;
    }
    else if ([_type isEqualToString:StringAddress])
    {
        [file setValue:_text forKey:kParameterAddress];
        kAppDelegate.currentUserModel.address = _text;
    }
    else if ([_type isEqualToString:StringOccupation])
    {
        [file setValue:_text forKey:kParameterOccupation];
        kAppDelegate.currentUserModel.occupation = _text;
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NOTIFICATION_ME_MODIFY_USERINFO object:nil userInfo:nil];
    
    [self goBack];
}

#pragma mark - network data center

- (void) setModifyToNetwork
{
    int type = [self getCurrentType];
    NSString *value = _text;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"type" andIntValue:type];
    [parametersUtil appendParameterWithName:@"value" andStringValue:value];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:POST_ME_MODIFY_USERINFO result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify my info success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                [self setLocalValueAndNotifaction];
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PromptEditError;
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"modify my info fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];

}

- (void) sendEditRemarksName
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:self.userModel.userId];
    [parametersUtil appendParameterWithName:@"remarksName" andStringValue:_text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_EDIT_REMARKSNAME result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify remarksname success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                _userModel.remarksName = _text;
                [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUser:_userModel];
                // 成功
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_EDIT_REMARKSNAME object:_text userInfo:nil];
                
                [self goBack];
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PromptEditError;
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"modify my info fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
    
}

- (void) sendEditRemarksEmail
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:self.userModel.userId];
    [parametersUtil appendParameterWithName:@"remarksEmail" andStringValue:_text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_EDIT_REMARKSEMAIL result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify remarksEmail success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                _userModel.remarksEmail = _text;
                [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUser:_userModel];
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_EDIT_REMARKSEMAIL object:_text userInfo:nil];
                
                [self goBack];
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PromptEditError;
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"modify my info fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
    
}

- (void) sendEditRecommentMe
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"recomment" andStringValue:_text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_RECOMMENT result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify recomment success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置成功！";
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            // 失败
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
