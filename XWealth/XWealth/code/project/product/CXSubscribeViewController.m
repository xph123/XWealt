//
//  CXSubscribeViewController.m
//  XWealth
//
//  Created by chx on 15-3-19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSubscribeViewController.h"
#import "CXSelectTableViewController.h"
#import "CXSearchProductViewController.h"

#define TIMESTATE_BUTTON_WIDTH    90
#define TITLELABEL_WIDTH 80

@interface CXSubscribeViewController ()<CXSelectTableViewControllerDelegate>

@end

@implementation CXSubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写预约资料";
    self.curTimeState = 0;
    [self initTimeStates];

    [self initRightBarButton];
    [self makeInfoView];
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(keyboardChangeFrame:)
                   name:UIKeyboardWillChangeFrameNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initRightBarButton
{
    UIButton *sendTradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendTradeBtn.frame = CGRectMake(0, 0, 60, 30);
    [sendTradeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [sendTradeBtn setTitle:StringSubmit forState:UIControlStateNormal];
    [sendTradeBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}


- (void) makeInfoView
{
    CGRect bounds = self.view.frame;// CGRectMake(0, 0, kScreenWidth, kScreenHeight - kButtomBarHeight) ;
    bounds.origin.y=0;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.backgroundColor = kControlBgColor;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *infoView = [[UIView alloc] initWithFrame:bounds];
    infoView.backgroundColor = kColorWhite;
    [scrollView addSubview:infoView];
    
    CGFloat productY = kDefaultMargin;
    [self makeProductView:productY andParentView:infoView];
//    [self makeTextField:projectY andText:@"产品名称：" andHolder:@"" andUnit:@"" andHasUint:NO andParentView:infoView andPublicView:1];
    
    CGFloat nameY = productY + [self inputLineHeight];
    [self makeTextField:nameY andText:@"姓名：" andHolder:@"必填" andUnit:@"" andHasUint:NO andParentView:infoView andPublicView:1];
    
    CGFloat idcardY = nameY + [self inputLineHeight];
    [self makeTextField:idcardY andText:@"身份证：" andHolder:@"选填" andUnit:@"" andHasUint:NO andParentView:infoView andPublicView:2];
    
    CGFloat money1Y = idcardY + [self inputLineHeight];
    [self makeTextField:money1Y andText:@"预约金额：" andHolder:@"金额" andUnit:@"万" andHasUint:YES andParentView:infoView andPublicView:3];

    CGFloat timeY = money1Y + [self inputLineHeight];
    
    [self makeTimeView:timeY andParentView:infoView];
    
    
    CGFloat width = kScreenWidth - 2 * kDefaultMargin;
    
    CGFloat moreY = timeY + kDefaultMargin + 1 + kTextFieldHeight;
    CGRect moreRect = CGRectMake(kDefaultMargin, moreY, width, kTextViewHeight);
    UITextView *moreTxtView = [[UITextView alloc] initWithFrame:moreRect];
    moreTxtView.tag = 1002;
    moreTxtView.font = kMiddleTextFont;
    moreTxtView.delegate = self;
    moreTxtView.text = StringMoreDesc;
    moreTxtView.textColor = kGrayTextColor;
    [moreTxtView setBounces:NO];
//    moreTxtView.returnKeyType = UIReturnKeyDone;
    [infoView addSubview:moreTxtView];
    self.moreTxtView = moreTxtView;
    
    CGFloat lineY = moreY + kTextViewHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
    
    [self phoneView: lineY + kLargeMargin andView:infoView];
    
    CGFloat contentHeigth = lineY + kButtonHeight + kLargeMargin;
    
    if (contentHeigth > (bounds.size.height - kNavAndStatusBarHeight))
    {
        CGRect frame = bounds;
        frame.size.height = contentHeigth;
        //        infoView.frame = frame;
        scrollView.contentSize = infoView.frame.size;
    }
}

- (void) makeProductView:(NSInteger)y andParentView:(UIView*)infoView
{
    CGFloat width = kScreenWidth - 2 * kDefaultMargin;
    CGFloat btnWidth = width - TITLELABEL_WIDTH - 2 * kDefaultMargin;
    
    UILabel *productTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, y, TITLELABEL_WIDTH, kTextFieldHeight)];
    productTitle.font = kMiddleTextFont;
    productTitle.textColor = kTextColor;
    productTitle.text =  @"产品名称：";
    productTitle.backgroundColor = kColorClear;
    productTitle.textAlignment = NSTextAlignmentRight;
    [infoView addSubview:productTitle];
    
    CGFloat productBtnX = TITLELABEL_WIDTH + 2 * kDefaultMargin;
    CGRect frame = CGRectMake(productBtnX, y, btnWidth, kButtonHeight);
    UIButton *productBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    productBtn.frame = frame;
    productBtn.layer.borderColor = kLineColor.CGColor;
    productBtn.layer.cornerRadius = kRadius;
    productBtn.layer.borderWidth = 1;
    productBtn.backgroundColor = kColorClear;
    [productBtn addTarget:self action:@selector(selectProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:productBtn];
    
    CGRect nameFrame = CGRectMake(productBtnX + 28, y, btnWidth - 32, kButtonHeight);
    
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:nameFrame];
    productNameLabel.font = kMiddleTextFont;
    productNameLabel.textColor = kTextColor;
    productNameLabel.text = self.productName;
    productNameLabel.backgroundColor = kColorClear;
    productNameLabel.numberOfLines = 2;
    productNameLabel.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:productNameLabel];
    self.productNameLabel = productNameLabel;
    
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(productBtnX+4, y + (kButtonHeight - 20)/2, 20, 20)];
    searchImgView.image = IMAGE(@"search_black");
    [infoView addSubview:searchImgView];
    
    CGFloat lineY = y + kDefaultMargin + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
}

- (void) makeTimeView:(NSInteger)y andParentView:(UIView*)infoView
{
    CGFloat width = kScreenWidth - 2 * kDefaultMargin;
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, y, TITLELABEL_WIDTH, kTextFieldHeight)];
    timeTitle.font = kMiddleTextFont;
    timeTitle.textColor = kTextColor;
    timeTitle.text =  @"打款时间：";
    timeTitle.backgroundColor = kColorClear;
    timeTitle.textAlignment = NSTextAlignmentRight;
    [infoView addSubview:timeTitle];
    
    NSString *strState = [self.timeStateList objectAtIndex:self.curTimeState];
    CGFloat timeBtnX = TITLELABEL_WIDTH + 2 * kDefaultMargin;
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(timeBtnX, y, TIMESTATE_BUTTON_WIDTH, kButtonHeight);
    timeBtn.layer.borderColor = kLineColor.CGColor;
    timeBtn.layer.cornerRadius = kRadius;
    timeBtn.layer.borderWidth = 1;
    timeBtn.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [timeBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [timeBtn setTitle:strState forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(showTimeSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:timeBtn];
    self.timeBtn = timeBtn;
    
    UIImageView *timeMore = [[UIImageView alloc] initWithFrame:CGRectMake(TITLELABEL_WIDTH + 2 * kDefaultMargin + TIMESTATE_BUTTON_WIDTH - 20, y + (kButtonHeight - 16)/2, 16, 16)];
    timeMore.image = IMAGE(@"showmore");
    [infoView addSubview:timeMore];
 
    CGFloat lineY = y + kDefaultMargin + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
}

- (void) makeTextField:(NSInteger) y andText:(NSString*)text andHolder:(NSString*)holder andUnit:(NSString*)unit andHasUint:(BOOL)isHaveUnit andParentView:(UIView*)infoView andPublicView:(NSInteger)index
{
    CGFloat width = kScreenWidth - 2 * kDefaultMargin;
    CGFloat unitWidth  = 30;
    CGFloat inputWidth = 0;
    
    if (isHaveUnit)
    {
        inputWidth = width - TITLELABEL_WIDTH - 4 * kDefaultMargin - unitWidth;
    }
    else
    {
        inputWidth = width - TITLELABEL_WIDTH - 2 * kDefaultMargin;
    }
    
    UILabel *numberTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, y, TITLELABEL_WIDTH, kTextFieldHeight)];
    numberTitle.font = kMiddleTextFont;
    numberTitle.textColor = kTextColor;
    numberTitle.text =  text;
    numberTitle.backgroundColor = kColorClear;
    numberTitle.textAlignment = NSTextAlignmentRight;
    [infoView addSubview:numberTitle];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(TITLELABEL_WIDTH + 2 * kDefaultMargin, y,  inputWidth, kTextFieldHeight)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField setDelegate:self];
    textField.placeholder = holder;
    textField.font = kMiddleTextFont;
    textField.textColor = kTextColor;
    [infoView addSubview:textField];
    switch (index) {
        case 1:
            textField.keyboardType = UIKeyboardTypeDefault;
            self.nameField = textField;
            break;
        case 2:
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.idcardField = textField;
            break;
        case 3:
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.moneyField = textField;
            break;
        default:
            break;
    }
    
    if (isHaveUnit)
    {
        UILabel *numUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, y, unitWidth, kTextFieldHeight)];
        numUnitLabel.font = kMiddleTextFont;
        numUnitLabel.textColor = kTextColor;
        numUnitLabel.text =  unit;
        numUnitLabel.backgroundColor = kColorClear;
        numUnitLabel.textAlignment = NSTextAlignmentCenter;
        [infoView addSubview:numUnitLabel];
    }
    
    CGFloat lineY = y + kDefaultMargin + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
}

- (void) phoneView:(CGFloat) y andView:(UIView*)infoView
{
    _phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, y, kScreenWidth - 40, kButtonHeight)];
    [_phoneBtn setBackgroundColor:kButtonColor];
    _phoneBtn.layer.masksToBounds = YES;
    _phoneBtn.layer.cornerRadius = kRadius;
    _phoneBtn.layer.borderColor = kLineColor.CGColor;
    _phoneBtn.layer.borderWidth = 1;
    [_phoneBtn setTitle: @"400-895-5056" forState: UIControlStateNormal];
    _phoneBtn.titleLabel.font = kExtralLargeTextFont;
    [_phoneBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_phoneBtn setImage:[UIImage imageNamed:@"callphone"] forState:UIControlStateNormal];
    [_phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
    _phoneBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [infoView addSubview:_phoneBtn];
}





- (CGFloat) inputLineHeight
{
    return (kDefaultMargin*2 + kTextFieldHeight + 1);
}


#pragma mark data & network data

- (void) initTimeStates
{
    _timeStateList = [[NSArray alloc] initWithObjects:@"随时", @"三天内", @"三天以上", nil];
}

- (void) sendSubscribeOpToServer:(NSString *)flag
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    NSString *more = [self.moreTxtView.text isEqualToString:StringMoreDesc] ? @"": self.moreTxtView.text;
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [parametersUtil appendParameterWithName:@"productId" andLongValue:self.productId];
    //    [parametersUtil appendParameterWithName:@"requirement" andStringValue:self.descTxtView.text];
    [parametersUtil appendParameterWithName:@"money" andStringValue:self.moneyField.text];
    //    [parametersUtil appendParameterWithName:@"number" andStringValue:self.numberField.text];
    [parametersUtil appendParameterWithName:@"payment" andIntValue:self.curTimeState];
    [parametersUtil appendParameterWithName:@"more" andStringValue:more];
    [parametersUtil appendParameterWithName:@"name" andStringValue:self.nameField.text];
    [parametersUtil appendParameterWithName:@"idno" andStringValue:self.idcardField.text];
    [parametersUtil appendParameterWithName:@"flag" andStringValue:flag];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_SUBSCRIBE_OP result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"预约成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
                if (self.fromMySubscribe)
                {
                    self.fromMySubscribe();
                }
            }
        }
        else
        {
            [self ShowProgressHuD:(NSString*)err];
        }
    }];
}

- (void) sendSubscribeToServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    NSString *more = [self.moreTxtView.text isEqualToString:StringMoreDesc] ? @"": self.moreTxtView.text;
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];

    [parametersUtil appendParameterWithName:@"productId" andLongValue:self.productId];
//    [parametersUtil appendParameterWithName:@"requirement" andStringValue:self.descTxtView.text];
    [parametersUtil appendParameterWithName:@"money" andStringValue:self.moneyField.text];
//    [parametersUtil appendParameterWithName:@"number" andStringValue:self.numberField.text];
    [parametersUtil appendParameterWithName:@"payment" andIntValue:self.curTimeState];
    [parametersUtil appendParameterWithName:@"more" andStringValue:more];
    [parametersUtil appendParameterWithName:@"name" andStringValue:self.nameField.text];
    [parametersUtil appendParameterWithName:@"idno" andStringValue:self.idcardField.text];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_SUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"预约成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
                if (self.fromMySubscribe)
                {
                    self.fromMySubscribe();
                }
            }
        }
        else
        {
            if ([StringProductSubscribed isEqualToString:(NSString*)err])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:StringProductSubscribed delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"替换", @"叠加", nil];
                [alert show];
            }
            else
            {
                [self ShowProgressHuD:(NSString*)err];
            }
        }
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self sendSubscribeOpToServer:@"1"];
    }
    else if (buttonIndex == 2)
    {
        [self sendSubscribeOpToServer:@"2"];
    }
}


#pragma mark - private methods

- (void) sendSubscribe
{
    [self hideKeyBoard];
    
    if (self.productId <= 0)
    {
        [self ShowProgressHuD:@"请选择要预定的产品！"];
        return;
    }
    
    if (self.nameField.text.length == 0)
    {
        [self ShowProgressHuD:@"请输入姓名！"];
        return;
    }
    
    if ([self isMoneyValid:self.moneyField] == NO)
    {
        return ;
    }
    
    [self sendSubscribeToServer];
}

- (BOOL) isMoneyValid:(UITextField*)textField
{
    if (textField.text.length > 0)
    {
        if ([XStringHelper isPureInt:textField.text] == NO)
        {
            [self ShowProgressHuD:@"认购金额请输入数字！"];
            return NO;
        }
        
        NSInteger money = [textField.text integerValue];
        if (money > 20000)
        {
            [self ShowProgressHUB:@"认购金额不能超过2亿！"];
            return NO;
        }
        else if (money <= 0)
        {
            [self ShowProgressHUB:@"认购金额请填写有效数字！"];
            return NO;
        }
    }
    else
    {
        [self ShowProgressHuD:@"请输入认购金额！"];
        return NO;
    }

    return YES;
}


- (void) ShowProgressHuD:(NSString*)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void) selectProductBtnClick
{
    CXSearchProductViewController *searchViewControl = [[CXSearchProductViewController alloc] init];
    searchViewControl.selectProductBlk = ^(NSInteger productId, NSString *productName)
    {
        if (productId > 0 && ![productName isEmpty])
        {
            self.productName = productName;
            self.productId = productId;
            
            self.productNameLabel.text = productName;
        }
    };
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewControl animated:YES];
}

//类型事件
- (void) showTimeSelectBegin
{
    [self hideKeyBoard];
    
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:self.timeStateList andSelect:0];
    modifyControl.delegate = self;
    modifyControl.title = StringWindSubscribe;
    [self.navigationController pushViewController:modifyControl animated:YES];
}


- (void)phoneBtnClick:(UIButton *)button
{
    [self hideKeyBoard];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
}

- (void) hideKeyBoard
{
    [self.nameField resignFirstResponder];
    [self.idcardField resignFirstResponder];
    [self.moneyField resignFirstResponder];
//    [self.descTxtView resignFirstResponder];
    [self.moreTxtView resignFirstResponder];
}

#pragma mark - CXSelectTableViewControllerDelegate
- (void)setSelected:(int)nameId andIndex:(int)index
{
    self.curTimeState = index;
    NSString *strState = [self.timeStateList objectAtIndex:self.curTimeState];
    [self.timeBtn setTitle:strState forState:UIControlStateNormal];
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
    
    if (frame.origin.y > y)
    {
        moveY = frame.origin.y - y;
    }
    
    if (textField == _moneyField)
    {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    int y = kScreenHeight - kKeyboardHeight - 80 - 64;
    CGRect frame = textField.frame;
    int moveY = 30;
    
    if (frame.origin.y > y)
    {
        moveY = frame.origin.y - y;
    }
    
    
    if (textField == _moneyField)
    {
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
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -= moveY;//view的Y轴上移
    frame.size.height += moveY; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}

- (void) moveViewWhentextFieldEndEdding:(float) moveY
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y += moveY;//view的Y轴上移
    frame.size.height -= moveY; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于300" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:kTaskMaxTextLength];
        number = kTaskMaxTextLength;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1001)
    {
        if ([textView.text isEqualToString:StringRequirementDesc]) {
            textView.text = @"";
            textView.textColor = kTextColor; //optional
        }
    }
    else if (textView.tag == 1002)
    {
        if ([textView.text isEqualToString:StringMoreDesc]) {
            textView.text = @"";
            textView.textColor = kTextColor; //optional
        }
        
        NSTimeInterval animationDuration = 0.30f;
        float moveY = kTextViewHeight + kDefaultMargin + 64;
        
        CGRect frame = self.view.frame;
        frame.origin.y -= moveY;//view的Y轴上移
        frame.size.height += moveY; //View的高度增加
        
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];//设置调整界面的动画效果
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1001)
    {
        if ([textView.text isEqualToString:@""]) {
            textView.text = StringRequirementDesc;
            textView.textColor = kGrayTextColor; //optional
        }
    }
    else if (textView.tag == 1002)
    {
        if ([textView.text isEqualToString:@""]) {
            textView.text = StringMoreDesc;
            textView.textColor = kGrayTextColor; //optional
        }
        
        NSTimeInterval animationDuration = 0.30f;
        float moveY = kTextViewHeight + kDefaultMargin + 64;
        
        CGRect frame = self.view.frame;
        frame.origin.y += moveY;//view的Y轴上移
        frame.size.height -= moveY; //View的高度增加
        
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];//设置调整界面的动画效果
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
//    [self.descTxtView resignFirstResponder];
    [self.moreTxtView resignFirstResponder];
    [self.view endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
