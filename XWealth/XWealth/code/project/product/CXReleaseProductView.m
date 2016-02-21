//
//  CXReleaseProductView.m
//  XWealth
//
//  Created by gsycf on 15/8/31.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXReleaseProductView.h"

#define TIMESTATE_BUTTON_WIDTH    90

@implementation CXReleaseProductView
{
    NSMutableArray *_moneyIntoArray;  //获取到的投资类型数据
}
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
    _moneyIntoArray=[[NSMutableArray alloc]init];
    _contentHeigth=0;
    self.curCategory = 0;
    self.moneyIntoCurCategory=0;
    [self initCategoryList];
    [self initMoneyIntoList];
    
    [self makeInfoView];
    //    [self phoneView];
    
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    //    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //    [center addObserver:self
    //               selector:@selector(keyboardChangeFrame:)
    //                   name:UIKeyboardWillChangeFrameNotification
    //                 object:nil];
    //    [center addObserver:self
    //               selector:@selector(keyboardWillHide:)
    //                   name:UIKeyboardWillHideNotification
    //                 object:nil];
}

//- (void)goBack
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:StringExit message:StringExitPrompt delegate:self cancelButtonTitle:StringCencle otherButtonTitles:StringCertain, nil];
//    [alert show];
//
//
//}
//
//#pragma mark - UIAlertViewDelegate
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1)
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}




- (void) makeInfoView
{
    CGRect bounds = self.frame; //  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavAndStatusBarHeight) ;
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
    myNameField.adjustsFontSizeToFitWidth=NO;
    [infoView addSubview:myNameField];
    self.nameField = myNameField;
    
    CGFloat nameY = kDefaultMargin * 2 + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, nameY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
    
    CGFloat moneyY = nameY + 1 + kDefaultMargin;
    
    
    
    //产品规模
    UILabel *moneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyY, titleWidth, kTextFieldHeight)];
    moneyTitle.font = kMiddleTextFont;
    moneyTitle.textColor = kTextColor;
    moneyTitle.text = [NSString stringWithFormat:@"%@:",StringProductScale];
    moneyTitle.backgroundColor = kColorClear;
    moneyTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:moneyTitle];
    
    
    UITextField *moneyField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, moneyY,  inputWidth, kTextFieldHeight)];
    [moneyField setBorderStyle:UITextBorderStyleRoundedRect];
    [moneyField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [moneyField setReturnKeyType:UIReturnKeyDone];
    [moneyField setDelegate:self];
    moneyField.placeholder = @"金额";
    moneyField.font = kMiddleTextFont;
    moneyField.textColor = kTextColor;
    moneyField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:moneyField];
    self.scaleField = moneyField;
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, moneyY, unitWidth, kTextFieldHeight)];
    unitLabel.font = kMiddleTextFont;
    unitLabel.textColor = kTextColor;
    unitLabel.text =  @"万";
    unitLabel.backgroundColor = kColorClear;
    unitLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:unitLabel];
    
    
    CGFloat lineY2 = moneyY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY2, width, 0.5)];
    lineView2.backgroundColor = kLineColor;
    [infoView addSubview:lineView2];
    
    //产品期限
    CGFloat numberY = lineY2 + 1 + kDefaultMargin;
    
    UILabel *numberTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, numberY, titleWidth, kTextFieldHeight)];
    numberTitle.font = kMiddleTextFont;
    numberTitle.textColor = kTextColor;
    numberTitle.text = [NSString stringWithFormat:@"%@:",StringProductDeadline];
    numberTitle.backgroundColor = kColorClear;
    numberTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:numberTitle];
    
    UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, numberY,  inputWidth, kTextFieldHeight)];
    [numberField setBorderStyle:UITextBorderStyleRoundedRect];
    [numberField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [numberField setReturnKeyType:UIReturnKeyDone];
    [numberField setDelegate:self];
    numberField.placeholder = @"期限";
    numberField.font = kMiddleTextFont;
    numberField.textColor = kTextColor;
    numberField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:numberField];
    self.deadlineField = numberField;
    
    UILabel *deadlineUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, numberY, unitWidth, kTextFieldHeight)];
    deadlineUnitLabel.font = kMiddleTextFont;
    deadlineUnitLabel.textColor = kTextColor;
    deadlineUnitLabel.text =  @"月";
    deadlineUnitLabel.backgroundColor = kColorClear;
    deadlineUnitLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:deadlineUnitLabel];
    
    
    CGFloat lineY3 = numberY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY3, width, 0.5)];
    lineView3.backgroundColor = kLineColor;
    [infoView addSubview:lineView3];
    
    //最低收益
    CGFloat profitY = lineY3 + 1 + kDefaultMargin;
    //CGFloat lineY5 = numberY;
    UILabel *profitTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, profitY, titleWidth, kTextFieldHeight)];
    profitTitle.font = kMiddleTextFont;
    profitTitle.textColor = kTextColor;
    profitTitle.text = [NSString stringWithFormat:@"%@:",StringProductLeastProfit];
    profitTitle.backgroundColor = kColorClear;
    profitTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:profitTitle];
    
    
    UITextField *myProfitField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, profitY,  inputWidth, kTextFieldHeight)];
    [myProfitField setBorderStyle:UITextBorderStyleRoundedRect];
    [myProfitField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myProfitField setReturnKeyType:UIReturnKeyDone];
    [myProfitField setDelegate:self];
    myProfitField.placeholder =@"收益(选填)" ;
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
    
    
    CGFloat lineY4 = profitY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY4, width, 0.5)];
    lineView4.backgroundColor = kLineColor;
    [infoView addSubview:lineView4];
    
    
    //产品类型
    CGFloat timeY = lineY4 + kDefaultMargin + 1;
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, timeY, titleWidth, kTextFieldHeight)];
    timeTitle.font = kMiddleTextFont;
    timeTitle.textColor = kTextColor;
    timeTitle.text = [NSString stringWithFormat:@"%@:",StringProductCategory];
    timeTitle.backgroundColor = kColorClear;
    timeTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:timeTitle];
    
    NSString *strState;
    if (self.categoryList.count>0) {
        CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
        strState = category.name;
    }
    
    CGFloat timeBtnX = titleWidth + 2 * kDefaultMargin;
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(timeBtnX, timeY, TIMESTATE_BUTTON_WIDTH, kButtonHeight);
    timeBtn.layer.borderColor = kLineColor.CGColor;
    timeBtn.layer.borderWidth = 1;
    timeBtn.layer.cornerRadius = kRadius;
    timeBtn.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [timeBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [timeBtn setTitle:strState forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(showTimeSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:timeBtn];
    self.categoryBtn = timeBtn;
    
    UIImageView *timeMore = [[UIImageView alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin + TIMESTATE_BUTTON_WIDTH - 20, timeY + (kButtonHeight - 16)/2, 16, 16)];
    timeMore.image = IMAGE(@"showmore");
    [infoView addSubview:timeMore];
    
    
    numberY=lineY4+kDefaultMargin*2 + kButtonHeight;
    CGFloat lineY5 = numberY;
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY5, width, 0.5)];
    lineView5.backgroundColor = kLineColor;
    [infoView addSubview:lineView5];
    
    //投向
    CGFloat moneyIntoY = lineY5 + kDefaultMargin + 1;
    
    UILabel *moneyIntoTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyIntoY, titleWidth, kTextFieldHeight)];
    moneyIntoTitle.font = kMiddleTextFont;
    moneyIntoTitle.textColor = kTextColor;
    moneyIntoTitle.text = [NSString stringWithFormat:@"%@:",StringProductMoneyInto];
    moneyIntoTitle.backgroundColor = kColorClear;
    moneyIntoTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:moneyIntoTitle];
    
    //    CXListInvestCategoryModel *ListInvestCategory = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
    //    NSString *strMoneyInto= ListInvestCategory.name;
    CGFloat moneyIntoButtonX = titleWidth + 2 * kDefaultMargin;
    UIButton *moneyIntoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moneyIntoButton.frame = CGRectMake(moneyIntoButtonX, moneyIntoY, TIMESTATE_BUTTON_WIDTH, kButtonHeight);
    moneyIntoButton.layer.borderColor = kLineColor.CGColor;
    moneyIntoButton.layer.borderWidth = 1;
    moneyIntoButton.layer.cornerRadius = kRadius;
    moneyIntoButton.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [moneyIntoButton setTitleColor:kTextColor forState:UIControlStateNormal];
    [moneyIntoButton setTitle:@"基建" forState:UIControlStateNormal];
    [moneyIntoButton addTarget:self action:@selector(moneyIntoSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:moneyIntoButton];
    self.moneyIntoBtn = moneyIntoButton;
    
    UIImageView *moneyIntoMore = [[UIImageView alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin + TIMESTATE_BUTTON_WIDTH - 20, moneyIntoY + (kButtonHeight - 16)/2, 16, 16)];
    //CGFloat lineY6 = numberY;
    moneyIntoMore.image = IMAGE(@"showmore");
    [infoView addSubview:moneyIntoMore];
    
    CGFloat lineY6 = moneyIntoY+kDefaultMargin*2 + kButtonHeight;
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY6, width, 0.5)];
    lineView6.backgroundColor = kLineColor;
    [infoView addSubview:lineView6];
    
    
    
    
    
    
    
    //产品简介
    CGFloat lineY7 = lineY6+kDefaultMargin;
    CGRect rect = CGRectMake(kDefaultMargin, lineY7, width, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.tag = 1001;
    textView.font = kMiddleTextFont;
    textView.delegate = self;
    textView.text = [NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief];
    textView.textColor = kGrayTextColor;
    [textView setBounces:NO];
    //    textView.returnKeyType = UIReturnKeyDone;
    [infoView addSubview:textView];
    self.descTxtView = textView;
    
    
    
    
    //电话
    
    [self phoneView: lineY7 + kTextViewHeight + kLargeMargin andView:infoView];
    float linY8=lineY7 + kTextViewHeight +kButtonHeight+kLargeMargin;
    CGFloat contentHeigth = linY8 + kLargeMargin;
    if (contentHeigth > bounds.size.height)
    {
        _contentHeigth=contentHeigth-bounds.size.height;
        CGRect frame = bounds;
        frame.size.height = contentHeigth;
        infoView.frame = frame;
        self.scrollView.contentSize = infoView.frame.size;
        
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

#pragma mark data & network data

- (void) initCategoryList
{
    _categoryList = [[NSMutableArray alloc] init];
    
    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 2)
    {
        
        for (int i = 2; i < kAppDelegate.productCategoryList.count; i++)
        {
            CXCategoryModel *category = [kAppDelegate.productCategoryList objectAtIndex:i];
            
            [_categoryList addObject:category];
        }
    }
    //    _categoryList = [[NSArray alloc] initWithObjects:StringTrust, StringFund, StringShibosai, StringOther, nil];
}
- (void) initMoneyIntoList
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTINVESTCATEGORY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            _moneyIntoArray=(NSMutableArray *)mainPlate.anyModels;
            _moneyIntoList = [[NSMutableArray alloc] init];
            
            if (_moneyIntoArray&& _moneyIntoArray.count > 0)
            {
                
                for (int i = 0; i < _moneyIntoArray.count; i++)
                {
                    CXListInvestCategoryModel *ListInvestCategory = [_moneyIntoArray objectAtIndex:i];
                    
                    [_moneyIntoList addObject:ListInvestCategory];
                }
            }
            
            
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }
    }];
}

- (void) showTimeSelectBegin
{
    [self hideKeyBoard];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_categoryList.count];
    
    for (CXCategoryModel *category in _categoryList)
    {
        [arr addObject:category.name];
    }
    [self.delegate setCategory:arr andIndex:self.curCategory];
}
-(void)moneyIntoSelectBegin
{
    [self hideKeyBoard];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_moneyIntoList.count];
    
    for (CXListInvestCategoryModel *ListInvestCategory in _moneyIntoList)
    {
        [arr addObject:ListInvestCategory.name];
    }
    [self.delegate setmoneyInto:arr andIndex:self.moneyIntoCurCategory];
    
}

- (void)phoneBtnClick:(UIButton *)button
{
    [self hideKeyBoard];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://075526657682"]];
}

- (void) hideKeyBoard
{
    [self.scaleField resignFirstResponder];
    [self.deadlineField resignFirstResponder];
    [self.descTxtView resignFirstResponder];
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
    
    if (textField == _scaleField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    
    if (textField == _deadlineField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _profitField) {
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
    
    
    if (textField == _scaleField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    
    if (textField == _deadlineField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _profitField) {
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
        if ([textView.text isEqualToString:[NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief]]) {
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
            textView.text = [NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief];
            textView.textColor = kGrayTextColor; //optional
        }
    }
    
    [textView resignFirstResponder];
}

#pragma mark - KeyboardDelegate

- (void)keyboardChangeFrame:(NSNotification *)notification
{
    // 移动最底部控件
    //    NSValue *keyboardBounds = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGRect keyboardEndRect = [keyboardBounds CGRectValue];
    //    float moveY = kScreenHeight - keyboardEndRect.size.height - self.buttomBar.frame.size.height/2;
    //
    //    [UIView animateWithDuration:0.25 animations:^{
    //        self.buttomBar.center = CGPointMake(self.buttomBar.center.x, moveY);
    //    }];
    
}

-(void)keyboardWillHide:(NSNotification*)notif{
    //    float moveY = kScreenHeight -self.buttomBar.frame.size.height/2;
    //
    //    [UIView animateWithDuration:0.3f animations:^{
    //        self.buttomBar.center = CGPointMake(self.buttomBar.center.x, moveY);
    //    }];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.descTxtView resignFirstResponder];
    [self endEditing:YES];
}

#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
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
-(void)dealloc
{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
