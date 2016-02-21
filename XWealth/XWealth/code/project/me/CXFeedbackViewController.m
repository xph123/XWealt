//
//  CXFreebackViewController.m
//  XWealth
//
//  Created by chx on 15/6/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXFeedbackViewController.h"

@interface CXFeedbackViewController ()

@end

@implementation CXFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringFeedback;
    
    [self initRightBarButton];
    
    CGRect rect = CGRectMake(10, kMiddleMargin + kViewBeginOriginY, self.view.frame.size.width-20, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.font = kMiddleTextFont;
    textView.layer.cornerRadius = kRadius;
    textView.layer.masksToBounds = YES;
    textView.delegate = self;
    textView.text = StringFeedbackPrompt;
    textView.textColor = kAssistTextColor;
    textView.returnKeyType = UIReturnKeyDone;
//    [textView becomeFirstResponder];
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
    [saveBtn setTitle:StringSubmit forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kMiddleTextFontBold;
    [saveBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveModifyInfo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)saveModifyInfo:(UIButton *)button
{
    if ([NSString isBlankString:_textView.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringFeedbackPrompt;
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    [self.textView resignFirstResponder];
    
    [self setModifyToNetwork];
}

- (void) setModifyToNetwork
{

    NSString *value = _textView.text;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"content" andStringValue:value];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SYSTEM_FEEDBACK result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"modify my info success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PromptSumbitSuccess;
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:StringFeedbackPrompt]) {
        textView.text = @"";
    }
    textView.textColor = kTextColor; //optional
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = StringFeedbackPrompt;
        textView.textColor = kAssistTextColor; //optional
    }
    
    [textView resignFirstResponder];
}


@end
