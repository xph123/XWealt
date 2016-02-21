//
//  CXModifyGroupDescViewController.m
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXModifyGroupDescViewController.h"

@interface CXModifyGroupDescViewController ()

@end

@implementation CXModifyGroupDescViewController

- (id) initWithGroupModel:(CXGroupModel*)groupModel
{
    self = [super init];
    
    if (self)
    {
        _groupModel = groupModel;
        _text = _groupModel.groupDesc;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _type;
    self.view.backgroundColor = kControlBgColor;
    
    [self initRightBarButton];
    
    CGRect rect = CGRectMake(10, kNavAndStatusBarHeight + 30, 300, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.font = kMiddleTextFont;
    textView.layer.cornerRadius = kRadius;
    textView.layer.masksToBounds = YES;
    textView.delegate = self;
    textView.text = _text;
    textView.textColor = kAssistTextColor;
    textView.returnKeyType = UIReturnKeyDone;
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView = textView;
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    [saveBtn addTarget:self action:@selector(saveGroupDesc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)saveGroupDesc:(UIButton *)button
{
    if ([NSString isBlankString:_textView.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写内容";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    [self.textView resignFirstResponder];
    
    _text = _textView.text;
    
    [self setModifyToNetwork];
}

- (void) setLocalValueAndNotifaction
{
    _groupModel.groupDesc = _text;
    [[[CXDBHelper sharedDBHelper] getGroupDao] replaceIntoGroup:_groupModel];
    
    //    NSDictionary *userInfo = @{kParameterTaskModel: _text};
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NOTIFICATION_GROUP_MODIFYDESC object:nil userInfo:nil];
    
    [self goBack];
}

- (void) setModifyToNetwork
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"id" andIntValue:_groupModel.groupID];
    [parametersUtil appendParameterWithName:@"intro" andStringValue:_text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:POST_GROUP_MODIFYDESC result:^(CXMainPlate *mainPlate, NSError *err) {
        
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

#pragma mark - UIUITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView.text.length >= kSignatureMaxTextLength && text.length > range.length) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];
    
    if (textView.markedTextRange == nil && number > kSignatureMaxTextLength) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于30" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:kSignatureMaxTextLength];
        number = kSignatureMaxTextLength;
    }
}

@end
