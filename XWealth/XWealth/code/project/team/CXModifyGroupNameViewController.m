//
//  CXModifyGroupNameViewController.m
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXModifyGroupNameViewController.h"

@interface CXModifyGroupNameViewController ()<UITextFieldDelegate>

@end

@implementation CXModifyGroupNameViewController

- (id) initWithGroupModel:(CXGroupModel*)groupModel
{
    self = [super init];
    
    if (self)
    {
        _groupModel = groupModel;
        _text = _groupModel.groupName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改名称";
    self.view.backgroundColor = kControlBgColor;
    
    [self initRightBarButton];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, kNavAndStatusBarHeight + 30, 300, 40)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField becomeFirstResponder];
    textField.font = kMiddleTextFont;
    textField.text = _text;
    textField.delegate = self;
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
    [saveBtn addTarget:self action:@selector(saveGroupName:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)saveGroupName:(UIButton *)button
{
    if ([NSString isBlankString:_textField.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"团队通常都有一个响亮的名字,你的呢？";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    [self.textField resignFirstResponder];
    
    _text = _textField.text;
    
    [self setModifyToNetwork];
}

- (void) setLocalValueAndNotifaction
{
    _groupModel.groupName = _text;
    [[[CXDBHelper sharedDBHelper] getGroupDao] replaceIntoGroup:_groupModel];
    
//    NSDictionary *userInfo = @{kParameterTaskModel: _text};
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NOTIFICATION_GROUP_MODIFYNAME object:nil userInfo:nil];
    
    [self goBack];
}

- (void) setModifyToNetwork
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"id" andIntValue:_groupModel.groupID];
    [parametersUtil appendParameterWithName:@"name" andStringValue:_text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:POST_GROUP_MODIFYNAME result:^(CXMainPlate *mainPlate, NSError *err) {
        
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
                hud.labelText = @"修改失败！";
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
