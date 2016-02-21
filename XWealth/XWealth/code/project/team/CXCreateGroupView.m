//
//  CXCreateGroupView.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCreateGroupView.h"

@implementation CXCreateGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.clipsToBounds=YES;
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    UITextField *titleTxtField = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin, kLargeMargin, kScreenWidth - 2 * kDefaultMargin, kLabelHeight)];
    titleTxtField.placeholder = StringInputGroupName;
    titleTxtField.font = kMiddleTextFont;
    titleTxtField.backgroundColor = kColorWhite;
    [titleTxtField setReturnKeyType:UIReturnKeyDone];
    [titleTxtField setBorderStyle:UITextBorderStyleRoundedRect];
    [titleTxtField setClearButtonMode:UITextFieldViewModeWhileEditing];
    titleTxtField.delegate = self;
    [self addSubview:titleTxtField];
    _nameTextField = titleTxtField;
    
    
    CGRect rect = CGRectMake(kDefaultMargin, kLargeMargin + kLabelHeight + kDefaultMargin, kScreenWidth - 2 * kDefaultMargin, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.font = kMiddleTextFont;
    textView.layer.cornerRadius = kRadius;
    textView.layer.masksToBounds = YES;
    textView.delegate = self;
    textView.text = StringInputGroupInfo;
    textView.textColor = kAssistTextColor;
    textView.returnKeyType = UIReturnKeyDone;
    [self addSubview:textView];
    self.textView = textView;
    
    _groupLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kLargeMargin + kLabelHeight + kDefaultMargin * 2 + kTextViewHeight, kIconLargeWidth, kIconLargeHeight)];
    [_groupLogoImageView setImage:IMAGE(@"add_picture")];
    _groupLogoImageView.contentMode = UIViewContentModeScaleAspectFit;// UIViewContentModeScaleAspectFill;
    _groupLogoImageView.clipsToBounds  = YES;
    _groupLogoImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLogoImageView:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    [_groupLogoImageView addGestureRecognizer:singleFingerOne];
    [self addSubview:_groupLogoImageView];
    
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(logoImageLongPress:)];
    longPressGesture.minimumPressDuration = 0.7;
    [_groupLogoImageView addGestureRecognizer:longPressGesture];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_nameTextField];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_nameTextField];
}

// 点击添加的图片
- (void) clickLogoImageView:(UIButton*)button
{
    __unsafe_unretained CXCreateGroupView *weak_self = self;
    if (weak_self.clickAddPictureBlk) {
        weak_self.clickAddPictureBlk();
    }
}

- (void)logoImageLongPress:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan){
        __unsafe_unretained CXCreateGroupView *weak_self = self;
        if (weak_self.longPressAddPictureBlk) {
            weak_self.longPressAddPictureBlk();
        }
    }
}

#pragma mark - UIUITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView.text.length >= kTaskMaxTextLength && text.length > range.length) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];

    if (textView.markedTextRange == nil && number > kTaskMaxTextLength) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于300" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:kTaskMaxTextLength];
        number = kTaskMaxTextLength;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:StringInputGroupInfo]) {
        textView.text = @"";
        textView.textColor = kTextColor; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = StringInputGroupInfo;
        textView.textColor = kAssistTextColor; //optional
    }
    
    [textView resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([string isEqualToString:@"\n"])
//    {
//        return YES;
//    }
//    
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    
//    if (self.nameTextField == textField)
//    {
//        if ([toBeString length] > 20)
//        {
//            textField.text = [toBeString substringToIndex:20];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"团队名称不能超过20个字符。" delegate:nil cancelButtonTitle:StringCertain otherButtonTitles:nil, nil];
//            [alert show];
//            return NO;
//        }
//    }
//    
//    return YES;
//}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kSmallInputTextLimit) {
                textField.text = [toBeString substringToIndex:kSmallInputTextLimit];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kSmallInputTextLimit) {
            textField.text = [toBeString substringToIndex:kSmallInputTextLimit];
        }
    }
}
@end
