//
//  FasongView.m
//  Link
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XInputCommentView.h"

@implementation XInputCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorWhite;
        
        _baseFrame = frame;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        line.backgroundColor = kLineColor;
        [self addSubview:line];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 6, 240, 32)];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont fontWithName:@"Arial" size:14.0];
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 4;
        _textView.layer.borderColor = kLineColor.CGColor;
        _textView.layer.borderWidth = 1;
        _textView.delegate = self;
        _textView.scrollEnabled = YES;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//自适应高度
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        [self addSubview: _textView];
        
        UILabel *placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, 100, 20)];
        placeHolder.text = StringComment;
        placeHolder.textColor = kAssistTextColor;
        placeHolder.font = kMiddleTextFont;
        //placeHolder.enabled = NO;//lable必须设置为不可用
        placeHolder.backgroundColor = [UIColor clearColor];
        [_textView addSubview:placeHolder];
        self.placeHolder = placeHolder;
        
        UIImage *image = [kColorWhite translateIntoImage];
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBtn.frame = CGRectMake(260, 6, 50, 32);
        sendBtn.layer.masksToBounds = YES;
        sendBtn.layer.cornerRadius = kRadius;
        sendBtn.layer.borderColor = kLineColor.CGColor;
        sendBtn.layer.borderWidth = 1;
        [sendBtn setTitle:StringSend forState:UIControlStateNormal];
        sendBtn.titleLabel.font = kLargeTextFont;
        [sendBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        [sendBtn setBackgroundImage:image forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendBtn];
        self.sendBtn = sendBtn;        
    }
    return self;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    __unsafe_unretained XInputCommentView *weak_self = self;
    if (weak_self.risingView) {
        weak_self.risingView();
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    __unsafe_unretained XInputCommentView *weak_self = self;
    if (weak_self.fallingView) {
        weak_self.fallingView();
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (![textView.text isEqualToString:@""])
    {
        self.placeHolder.text = @"";
    }
    else
    {
        self.placeHolder.text = StringComment;
    }

    NSInteger number = [textView.text length];
    if (number > kInputTextLimit) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于300" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:kInputTextLimit];
        number = kInputTextLimit;
    }
    
    CGSize contentSize = self.textView.contentSize;
    if (contentSize.height > 100) {
        return;
    }
    
    CGRect viewFrame = self.frame;
    CGRect textViewFrame = self.textView.frame;
    
    if (contentSize.height > textViewFrame.size.height)
    {
        CGFloat viewHeight = viewFrame.size.height - textViewFrame.size.height + contentSize.height;
        CGFloat viewOriginY = viewFrame.origin.y - (contentSize.height - textViewFrame.size.height);
        
        viewFrame.origin.y = viewOriginY;
        viewFrame.size.height = viewHeight;
        
        self.frame = viewFrame;
        
        textViewFrame.size.height = contentSize.height;
        self.textView.frame = textViewFrame;
    }

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    if (textView.text.length >= kInputTextLimit && text.length > range.length) {
        return NO;
    }
    
    return YES;
}


- (void)send:(UIButton *)button
{
    if ([NSString isBlankString:_textView.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
//        hud.labelText =StringCommentNoContent;
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabelText = StringCommentNoContent;
        [hud hide:YES afterDelay:1];
    }
    else
    {
        [_textView resignFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            self.center = CGPointMake(160, kScreenHeight-self.frame.size.height/2);
        }];
        __unsafe_unretained XInputCommentView *weak_self = self;
        if (weak_self.sendBlk) {
            weak_self.sendBlk();
        }

    }
}

// 点发送后，调用这个函数复原
- (void) recover
{
    _textView.text = @"";
    self.placeHolder.text = StringComment;

    CGRect viewFrame = self.frame;
    
    if (viewFrame.size.height > _baseFrame.size.height)
    {
        self.frame = _baseFrame;
        self.textView.frame = CGRectMake(10, 6, 240, 32);
    }
}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.center = CGPointMake(self.center.x, self.center.y+kKeyboardHeight);
//    }];
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
