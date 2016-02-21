//
//  CXReleaseBenefitView.m
//  XWealth
//
//  Created by gsycf on 15/8/21.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXReleaseBenefitView.h"

#define TIMESTATE_BUTTON_WIDTH    90

@implementation CXReleaseBenefitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        
        [self initSubviews];
        
    }
    return self;
}
-(void)initSubviews
{
    _contentHeigth=0;

    
    [self makeInfoView];
    //    [self phoneView];
    
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    

}

- (void) makeInfoView
{
    CGRect bounds = self.frame; //  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavAndStatusBarHeight) ;
    bounds.origin.x=0;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.backgroundColor = kControlBgColor;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.delegate=self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *infoView = [[UIView alloc] initWithFrame:bounds];
    infoView.backgroundColor = kColorWhite;
    [self.scrollView addSubview:infoView];
    
    CGFloat width = kScreenWidth - 2 * kDefaultMargin;
    CGFloat titleWidth = 80;
    CGFloat unitWidth  = 30;
    CGFloat inputWidth = width - titleWidth - 4 * kDefaultMargin - unitWidth;

    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, titleWidth, kTextFieldHeight)];
    nameTitle.font = kMiddleTextFont;
    nameTitle.textColor = kTextColor;
    nameTitle.text = [NSString stringWithFormat:@"%@:",StringProductName];
    nameTitle.backgroundColor = kColorClear;
    nameTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:nameTitle];
    
    
    UITextField *myNameField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, kDefaultMargin,  inputWidth, kTextFieldHeight)];
    [myNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [myNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myNameField setReturnKeyType:UIReturnKeyDone];
    [myNameField setDelegate:self];
    myNameField.placeholder = @"名称";
    myNameField.font = kMiddleTextFont;
    myNameField.textColor = kTextColor;
    [infoView addSubview:myNameField];
    self.nameField = myNameField;
    
    CGFloat nameY = kDefaultMargin * 2 + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, nameY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
    
    
    
    CGFloat moneyY = nameY + 1 + kDefaultMargin;
    //产品期限
    UILabel *deadlineTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyY, titleWidth, kTextFieldHeight)];
    deadlineTitle.font = kMiddleTextFont;
    deadlineTitle.textColor = kTextColor;
    deadlineTitle.text = [NSString stringWithFormat:@"%@:",StringProductDeadline];
    deadlineTitle.backgroundColor = kColorClear;
    deadlineTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:deadlineTitle];
    
    
    UITextField *myDeadlineField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, moneyY,  inputWidth, kTextFieldHeight)];
    [myDeadlineField setBorderStyle:UITextBorderStyleRoundedRect];
    [myDeadlineField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myDeadlineField setReturnKeyType:UIReturnKeyDone];
    [myDeadlineField setDelegate:self];
    myDeadlineField.placeholder = @"期限";
    myDeadlineField.font = kMiddleTextFont;
    myDeadlineField.textColor = kTextColor;
    myDeadlineField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:myDeadlineField];
    self.deadlineField = myDeadlineField;
    
    UILabel *deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, moneyY, unitWidth, kTextFieldHeight)];
    deadlineLabel.font = kMiddleTextFont;
    deadlineLabel.textColor = kTextColor;
    deadlineLabel.text =  @"月";
    deadlineLabel.backgroundColor = kColorClear;
    deadlineLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:deadlineLabel];
    
    
    CGFloat lineY2 = moneyY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY2, width, 0.5)];
    lineView2.backgroundColor = kLineColor;
    [infoView addSubview:lineView2];
    
    //认购金额
    CGFloat numberY = lineY2 + 1 + kDefaultMargin;
    
    UILabel *moneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, numberY, titleWidth, kTextFieldHeight)];
    moneyTitle.font = kMiddleTextFont;
    moneyTitle.textColor = kTextColor;
    moneyTitle.text = [NSString stringWithFormat:@"%@:",StringProductSubscribeMoney];
    moneyTitle.backgroundColor = kColorClear;
    moneyTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:moneyTitle];
    
    UITextField *myMoneyField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, numberY,  inputWidth, kTextFieldHeight)];
    [myMoneyField setBorderStyle:UITextBorderStyleRoundedRect];
    [myMoneyField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myMoneyField setReturnKeyType:UIReturnKeyDone];
    [myMoneyField setDelegate:self];
    myMoneyField.placeholder = @"金额";
    myMoneyField.font = kMiddleTextFont;
    myMoneyField.textColor = kTextColor;
    myMoneyField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:myMoneyField];
    self.moneyField = myMoneyField;
    
    UILabel *MoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, numberY, unitWidth, kTextFieldHeight)];
    MoneyLabel.font = kMiddleTextFont;
    MoneyLabel.textColor = kTextColor;
    MoneyLabel.text =  @"万";
    MoneyLabel.backgroundColor = kColorClear;
    MoneyLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:MoneyLabel];
    
    
    CGFloat lineY3 = numberY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY3, width, 0.5)];
    lineView3.backgroundColor = kLineColor;
    [infoView addSubview:lineView3];
    
    //成立日期
    CGFloat timeY = lineY3 + kDefaultMargin + 1;
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, timeY, titleWidth, kTextFieldHeight)];
    timeTitle.font = kMiddleTextFont;
    timeTitle.textColor = kTextColor;
    timeTitle.text = [NSString stringWithFormat:@"%@:",StringProductEstablishDate];
    timeTitle.backgroundColor = kColorClear;
    timeTitle.textAlignment = NSTextAlignmentLeft;
    
    [infoView addSubview:timeTitle];
    
//    CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
//    NSString *strState = category.name;
    UITextField *timeField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, timeY,  inputWidth, kTextFieldHeight)];
    [timeField setBorderStyle:UITextBorderStyleRoundedRect];
    [timeField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [timeField setReturnKeyType:UIReturnKeyDone];
    [timeField setDelegate:self];
    timeField.placeholder =@"日期" ;
    timeField.font = kMiddleTextFont;
    timeField.textColor = kTextColor;
    timeField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:timeField];
    UUDatePicker *datePicker
    = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.frame.size.width, 200)
                             PickerStyle:1
                             didSelected:^(NSString *year,
                                           NSString *month,
                                           NSString *day,
                                           NSString *hour,
                                           NSString *minute,
                                           NSString *weekDay) {
                                 timeField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                             }
       ];
     [datePicker setLeftButton:^{
         [self endEditing:YES];
     }];
    [datePicker setRightButton:^(NSString *year,
                                 NSString *month,
                                 NSString *day,
                                 NSString *hour,
                                 NSString *minute,
                                 NSString *weekDay){
         timeField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        [self endEditing:YES];
    }];
    timeField.inputView = datePicker;
    self.establishDateField = timeField;
    
    
    
    numberY=lineY3+kDefaultMargin*2 + kButtonHeight;
    CGFloat lineY4 = numberY;
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY4, width, 0.5)];
    lineView5.backgroundColor = kLineColor;
    [infoView addSubview:lineView5];
    
    //预期收益
    CGFloat profitY = lineY4 + 1 + kDefaultMargin;
    //CGFloat lineY5 = numberY;
    UILabel *profitTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, profitY, titleWidth, kTextFieldHeight)];
    profitTitle.font = kMiddleTextFont;
    profitTitle.textColor = kTextColor;
    profitTitle.text = [NSString stringWithFormat:@"%@:",StringProductProfit];
    profitTitle.backgroundColor = kColorClear;
    profitTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:profitTitle];
    
    
    UITextField *myProfitField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, profitY,  inputWidth, kTextFieldHeight)];
    [myProfitField setBorderStyle:UITextBorderStyleRoundedRect];
    [myProfitField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myProfitField setReturnKeyType:UIReturnKeyDone];
    [myProfitField setDelegate:self];
    myProfitField.placeholder =@"收益" ;
    myProfitField.font = kMiddleTextFont;
    myProfitField.textColor = kTextColor;
    myProfitField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [infoView addSubview:myProfitField];
    self.profitField = myProfitField;
    
    UILabel *profitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, profitY, unitWidth, kTextFieldHeight)];
    profitLabel.font = kMiddleTextFont;
    profitLabel.textColor = kTextColor;
    profitLabel.text =  @"%";
    profitLabel.backgroundColor = kColorClear;
    profitLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:profitLabel];
    
    
    CGFloat lineY5 = profitY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY5, width, 0.5)];
    lineView4.backgroundColor = kLineColor;
    [infoView addSubview:lineView4];
    
    //姓名
    CGFloat customerY = lineY5 + 1 + kDefaultMargin;
    
    UILabel *customerTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, customerY, titleWidth, kTextFieldHeight)];
    customerTitle.font = kMiddleTextFont;
    customerTitle.textColor = kTextColor;
    customerTitle.text = [NSString stringWithFormat:@"%@:",StringProductUserName];
    customerTitle.backgroundColor = kColorClear;
    customerTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:customerTitle];
    
    UITextField *myUserNameField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, customerY,  inputWidth, kTextFieldHeight)];
    [myUserNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [myUserNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myUserNameField setReturnKeyType:UIReturnKeyDone];
    [myUserNameField setDelegate:self];
    if (![kAppDelegate.currentUserModel.userName isEqualToString:@""]) {
        NSString *userName= kAppDelegate.currentUserModel.nickName;
        myUserNameField.text=userName;
    }
    myUserNameField.placeholder = @"名称(选填)";
    myUserNameField.font = kMiddleTextFont;
    myUserNameField.textColor = kTextColor;
    [infoView addSubview:myUserNameField];
    self.userNameField = myUserNameField;
    
    
    CGFloat lineY6 = customerY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY6, width, 0.5)];
    lineView6.backgroundColor = kLineColor;
    [infoView addSubview:lineView6];
    
    
    
    //手机号码
    CGFloat phoneY = lineY6 + 1 + kDefaultMargin;
    
    UILabel *phoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, phoneY, titleWidth, kTextFieldHeight)];
    phoneTitle.font = kMiddleTextFont;
    phoneTitle.textColor = kTextColor;
    phoneTitle.text = [NSString stringWithFormat:@"%@:",StringProductPhone];
    phoneTitle.backgroundColor = kColorClear;
    phoneTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:phoneTitle];
    
    UITextField *myPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, phoneY,  inputWidth, kTextFieldHeight)];
    [myPhoneField setBorderStyle:UITextBorderStyleRoundedRect];
    [myPhoneField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myPhoneField setReturnKeyType:UIReturnKeyDone];
    [myPhoneField setDelegate:self];
    if (![kAppDelegate.currentUserModel.userName isEqualToString:@""]) {
        NSString *phone= kAppDelegate.currentUserModel.userName;
        myPhoneField.text=phone;
    }
    myPhoneField.placeholder = @"号码（选填）";
    myPhoneField.font = kMiddleTextFont;
    myPhoneField.textColor = kTextColor;
    myPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:myPhoneField];
    self.phoneField = myPhoneField;
    
    
    CGFloat lineY7 = phoneY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY7, width, 0.5)];
    lineView7.backgroundColor = kLineColor;
    [infoView addSubview:lineView7];
    
    
    
    
    //产品简介
    CGFloat lineY8 = lineY7+kDefaultMargin;
    CGRect rect = CGRectMake(kDefaultMargin, lineY8, width, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.tag = 1001;
    textView.font = kMiddleTextFont;
    textView.delegate = self;
    textView.text = [NSString stringWithFormat:@"%@",StringProductOther];
    textView.textColor = kGrayTextColor;
    [textView setBounces:NO];
    //    textView.returnKeyType = UIReturnKeyDone;
    [infoView addSubview:textView];
    self.introTxtView = textView;
    
    
    
    
    //电话4008955056
    
    [self phoneView: lineY8 + kTextViewHeight + kLargeMargin andView:infoView];
    float linY9=lineY8 + kTextViewHeight +kButtonHeight+kLargeMargin;
    CGFloat contentHeigth = linY9 + kLargeMargin;
    if (contentHeigth > bounds.size.height)
    {
        //        NSLog(@"%f",bounds.size.height);
        //        NSLog(@"%f",lineY7 + kTextViewHeight + kLargeMargin);
        //        NSLog(@"%f",self.bounds.size.height);
        _contentHeigth=contentHeigth-bounds.size.height;
        CGRect frame = bounds;
        frame.size.height = contentHeigth;
        infoView.frame = frame;
        scrollView.contentSize = infoView.frame.size;
        
    }
}

- (void) phoneView:(CGFloat) y andView:(UIView*)infoView
{
    _phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, y, kScreenWidth - 40, kButtonHeight)];
    [_phoneBtn setBackgroundColor:kButtonColor];
    _phoneBtn.layer.masksToBounds = YES;
    _phoneBtn.layer.cornerRadius = kRadius;
    _phoneBtn.layer.borderColor = kLineColor.CGColor;
    _phoneBtn.layer.borderWidth = 1;
    [_phoneBtn setTitle: @"0755-26657682" forState: UIControlStateNormal];
    _phoneBtn.titleLabel.font = kExtralLargeTextFont;
    [_phoneBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_phoneBtn setImage:[UIImage imageNamed:@"callphone"] forState:UIControlStateNormal];
    [_phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    _phoneBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [infoView addSubview:_phoneBtn];
}



- (void)phoneBtnClick:(UIButton *)button
{
    [self hideKeyBoard];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://075526657682"]];
}

- (void) hideKeyBoard
{
    [self.moneyField resignFirstResponder];
    [self.profitField resignFirstResponder];
    [self.deadlineField resignFirstResponder];
    [self.introTxtView resignFirstResponder];
    [self.userNameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}




#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int y = kScreenHeight - kKeyboardHeight - 80 - 64;
    CGRect frame = textField.frame;
    int moveY = 30;
    if (frame.origin.y+frame.size.height > y)
    {
        moveY = frame.origin.y+frame.size.height - y;
        
    }
    
    if (textField == _deadlineField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _establishDateField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _moneyField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _profitField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _userNameField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _phoneField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    int y = kScreenHeight - kKeyboardHeight - 80 - 64;
    CGRect frame = textField.frame;
    int moveY = 30;
    
    if (frame.origin.y+frame.size.height > y)
    {
        moveY = frame.origin.y+frame.size.height - y;
    }
    
    
    if (textField == _deadlineField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _establishDateField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _moneyField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _profitField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _userNameField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];

    }
    if (textField == _phoneField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void) moveViewWhentextFieldBeginEdding:(float) moveY
{
    if (_contentHeigth-_alreadyContentHeigth>moveY) {
        [self.scrollView setContentOffset:CGPointMake(0, moveY) animated:YES];
        return;
    }
    else if (moveY<_alreadyContentHeigth)
    {
        return;
    }
    else
    {
        _alreadyContentHeigth=0;
        float ContentNum=moveY-_alreadyContentHeigth-_contentHeigth;
        [self.scrollView setContentOffset:CGPointMake(0, _contentHeigth-_alreadyContentHeigth) animated:NO];
        moveY=ContentNum;
    }
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
    frame.origin.y -= moveY;//view的Y轴上移
    frame.size.height += moveY; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}

- (void) moveViewWhentextFieldEndEdding:(float) moveY
{
    if (_contentHeigth>moveY) {
        //float ContentNum=2*moveY-_alreadyContentHeigth;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _alreadyContentHeigth=0;
        return;
    }
    else
    {
        float ContentNum=moveY-_contentHeigth;
        //[self.scrollView setContentOffset:CGPointMake(0, _contentHeigth) animated:YES];
        moveY=ContentNum;
    }
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
    frame.origin.y += moveY;//view的Y轴上移
    frame.size.height -= moveY; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
    
}

#pragma mark - UIUITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    if ([text isEqualToString:@"\n"]) {
    //        [textView resignFirstResponder];
    //        return NO;
    //    }
    
    if (textView.text.length >= kTaskMaxTextLength && text.length > range.length) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];
    
    if (textView.markedTextRange == nil && number > kTaskMaxTextLength) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:kTaskMaxTextLength];
        number = kTaskMaxTextLength;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1001)
    {
        int y = kScreenHeight - kKeyboardHeight - 80 - 64;
        CGRect frame = textView.frame;
        int moveY = 30;
        if (frame.origin.y+frame.size.height> y)
        {
            moveY = frame.origin.y+frame.size.height - y;
            moveY-=15;
        }
        [self moveViewWhentextFieldBeginEdding:moveY];
        if ([textView.text isEqualToString:[NSString stringWithFormat:@"%@",StringProductOther]]) {
            textView.text = @"";
            textView.textColor = kTextColor; //optional
        }
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1001)
    {
        int y = kScreenHeight - kKeyboardHeight - 80 - 64;
        CGRect frame = textView.frame;
        int moveY = 30;
        if (frame.origin.y+frame.size.height> y)
        {
            moveY = frame.origin.y+frame.size.height - y;
            moveY-=15;
        }
        [self moveViewWhentextFieldEndEdding:moveY];
        if ([textView.text isEqualToString:@""]) {
            textView.text = [NSString stringWithFormat:@"%@",StringProductOther];
            textView.textColor = kGrayTextColor; //optional
        }
    }
    
    [textView resignFirstResponder];
}

#pragma mark - KeyboardDelegate

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.introTxtView resignFirstResponder];
    [self endEditing:YES];
}

#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _alreadyContentHeigth=scrollView.contentOffset.y;
}




@end

