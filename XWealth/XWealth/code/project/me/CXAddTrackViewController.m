//
//  CXAddTrackViewController.m
//  XWealth
//
//  Created by 12345 on 15-8-23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXAddTrackViewController.h"
#import "CXSelectTableViewController.h"
#import "CXSearchMyTrackViewController.h"

#define TIMESTATE_BUTTON_WIDTH    90

@interface CXAddTrackViewController ()<CXSelectTableViewControllerDelegate>

@end

@implementation CXAddTrackViewController
{
    NSMutableArray *_moneyIntoArray;  //获取到的投资类型数据
    float _textFieldMove;   //记录视图移动的位置
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kControlBgColor;
    _moneyIntoArray=[[NSMutableArray alloc]init];
    _contentHeigth=0;
    _textFieldMove=0;
    self.curCategory = 0;
    self.payTypeCategory=0;
    self.title=StringMyTrack;
    [self initRightBarButton];
    [self initCategoryList];
    [self inipPayTypeList];
    [self makeInfoView];
    //    [self phoneView];
    
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initRightBarButton
{
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 30, 30);
    [releaseBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = kMiddleTextFont;
    [releaseBtn setTitle:@"提交" forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];

    
}

- (void) makeInfoView
{
    CGRect bounds = self.view.frame; //  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavAndStatusBarHeight) ;
    bounds.origin.y=0;
    bounds.origin.y=kViewBeginOriginY;
    bounds.size.height-=kViewBeginOriginY;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.backgroundColor = kControlBgColor;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollView.frame.size.height)];
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
    
    UIButton *nameSearchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    nameSearchbtn.frame=CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, kDefaultMargin,unitWidth, kTextFieldHeight);
    [nameSearchbtn setImage:IMAGE(@"search_black") forState:UIControlStateNormal];
    [nameSearchbtn addTarget:self action:@selector(nameSearchbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:nameSearchbtn];

    
    
    CGFloat nameY = kDefaultMargin * 2 + kTextFieldHeight;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, nameY, width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [infoView addSubview:lineView];
    
    CGFloat moneyY = nameY + 1 + kDefaultMargin;
    
    
    
    //认购时间
    UILabel *payDateTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyY, titleWidth, kTextFieldHeight)];
    payDateTitle.font = kMiddleTextFont;
    payDateTitle.textColor = kTextColor;
    payDateTitle.text = [NSString stringWithFormat:@"%@:",StringMePayDate];
    payDateTitle.backgroundColor = kColorClear;
    payDateTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:payDateTitle];
    
    
    UITextField *myPayDateField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, moneyY,  inputWidth, kTextFieldHeight)];
    [myPayDateField setBorderStyle:UITextBorderStyleRoundedRect];
    [myPayDateField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myPayDateField setReturnKeyType:UIReturnKeyDone];
    [myPayDateField setDelegate:self];
    myPayDateField.placeholder = @"时间";
    myPayDateField.font = kMiddleTextFont;
    myPayDateField.textColor = kTextColor;
    myPayDateField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:myPayDateField];
    UUDatePicker *datePicker
    = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.view.frame.size.width, 200)
                             PickerStyle:1
                             didSelected:^(NSString *year,
                                           NSString *month,
                                           NSString *day,
                                           NSString *hour,
                                           NSString *minute,
                                           NSString *weekDay) {
                                 myPayDateField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                             }
       ];
    [datePicker setLeftButton:^{
        [self.view endEditing:YES];
    }];
    [datePicker setRightButton:^(NSString *year,
                                 NSString *month,
                                 NSString *day,
                                 NSString *hour,
                                 NSString *minute,
                                 NSString *weekDay){
        myPayDateField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        [self.view endEditing:YES];
    }];
    myPayDateField.inputView = datePicker;
    self.payDateField = myPayDateField;
    
    CGFloat lineY2 = moneyY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY2, width, 0.5)];
    lineView2.backgroundColor = kLineColor;
    [infoView addSubview:lineView2];
    
    //认购金额
    CGFloat numberY = lineY2 + 1 + kDefaultMargin;
    
    UILabel *numberTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, numberY, titleWidth, kTextFieldHeight)];
    numberTitle.font = kMiddleTextFont;
    numberTitle.textColor = kTextColor;
    numberTitle.text = [NSString stringWithFormat:@"%@:",StringProductSubscribeMoney];
    numberTitle.backgroundColor = kColorClear;
    numberTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:numberTitle];
    
    UITextField *myAmountField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, numberY,  inputWidth, kTextFieldHeight)];
    [myAmountField setBorderStyle:UITextBorderStyleRoundedRect];
    [myAmountField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myAmountField setReturnKeyType:UIReturnKeyDone];
    [myAmountField setDelegate:self];
    myAmountField.placeholder = @"金额";
    myAmountField.font = kMiddleTextFont;
    myAmountField.textColor = kTextColor;
    myAmountField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [infoView addSubview:myAmountField];
    self.amountField = myAmountField;
    
    UILabel *deadlineUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, numberY, unitWidth, kTextFieldHeight)];
    deadlineUnitLabel.font = kMiddleTextFont;
    deadlineUnitLabel.textColor = kTextColor;
    deadlineUnitLabel.text =  @"万";
    deadlineUnitLabel.backgroundColor = kColorClear;
    deadlineUnitLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:deadlineUnitLabel];
    
    
    CGFloat lineY3 = numberY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY3, width, 0.5)];
    lineView3.backgroundColor = kLineColor;
    [infoView addSubview:lineView3];
    
    //封闭期限
    CGFloat lockAreaY = lineY3 + 1 + kDefaultMargin;
    //CGFloat lineY5 = numberY;
    UILabel *lockAreaTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, lockAreaY, titleWidth, kTextFieldHeight)];
    lockAreaTitle.font = kMiddleTextFont;
    lockAreaTitle.textColor = kTextColor;
    lockAreaTitle.text = [NSString stringWithFormat:@"%@:",StringMeLockArea];
    lockAreaTitle.backgroundColor = kColorClear;
    lockAreaTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:lockAreaTitle];
    
    
    UITextField *myLockAreaField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, lockAreaY,  inputWidth, kTextFieldHeight)];
    [myLockAreaField setBorderStyle:UITextBorderStyleRoundedRect];
    [myLockAreaField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myLockAreaField setReturnKeyType:UIReturnKeyDone];
    [myLockAreaField setDelegate:self];
    myLockAreaField.placeholder =@"期限" ;
    myLockAreaField.font = kMiddleTextFont;
    myLockAreaField.textColor = kTextColor;
    myLockAreaField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [infoView addSubview:myLockAreaField];
    self.lockAreaField = myLockAreaField;
    
    UILabel *lockAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, lockAreaY, unitWidth, kTextFieldHeight)];
    lockAreaLabel.font = kMiddleTextFont;
    lockAreaLabel.textColor = kTextColor;
    lockAreaLabel.text =  @"月";
    lockAreaLabel.backgroundColor = kColorClear;
    lockAreaLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:lockAreaLabel];
    
    
    CGFloat lineY4 = lockAreaY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY4, width, 0.5)];
    lineView4.backgroundColor = kLineColor;
    [infoView addSubview:lineView4];
    
    //收益
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
    
    UILabel *ProfitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * kDefaultMargin - unitWidth, profitY, unitWidth, kTextFieldHeight)];
    ProfitLabel.font = kMiddleTextFont;
    ProfitLabel.textColor = kTextColor;
    ProfitLabel.text =  @"%";
    ProfitLabel.backgroundColor = kColorClear;
    ProfitLabel.textAlignment = UIKeyboardTypeNumberPad;
    [infoView addSubview:ProfitLabel];
    
    
    CGFloat lineY5 = profitY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY5, width, 0.5)];
    lineView5.backgroundColor = kLineColor;
    [infoView addSubview:lineView5];
    


    
    
    
    //购买人（选填)
    CGFloat payerY = lineY5 + 1 + kDefaultMargin;
    //CGFloat lineY5 = numberY;
    UILabel *payerTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, payerY, titleWidth, kTextFieldHeight)];
    payerTitle.font = kMiddleTextFont;
    payerTitle.textColor = kTextColor;
    payerTitle.text = [NSString stringWithFormat:@"%@:",StringMePayer];
    payerTitle.backgroundColor = kColorClear;
    payerTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:payerTitle];
    
    
    UITextField *myPayerField = [[UITextField alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin, payerY,  inputWidth, kTextFieldHeight)];
    [myPayerField setBorderStyle:UITextBorderStyleRoundedRect];
    [myPayerField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myPayerField setReturnKeyType:UIReturnKeyDone];
    [myPayerField setDelegate:self];
    myPayerField.placeholder =@"购买人(选填)" ;
    myPayerField.font = kMiddleTextFont;
    myPayerField.textColor = kTextColor;
    [infoView addSubview:myPayerField];
    self.payerField = myPayerField;
    

    
    CGFloat lineY6 = payerY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY6, width, 0.5)];
    lineView6.backgroundColor = kLineColor;
    [infoView addSubview:lineView6];
    
    
    //付息方式
    NSString *strPaymentAccrual;
    if (self.payTypeList.count>0) {
        CXListInvestCategoryModel *category = [self.payTypeList objectAtIndex:self.payTypeCategory];
        strPaymentAccrual = category.name;
    }
    CGFloat paymentAccrualY = lineY6 + kDefaultMargin + 1;
    
    UILabel *paymentAccrualTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, paymentAccrualY, titleWidth, kTextFieldHeight)];
    paymentAccrualTitle.font = kMiddleTextFont;
    paymentAccrualTitle.textColor = kTextColor;
    paymentAccrualTitle.text = [NSString stringWithFormat:@"%@:",StringpaymentAccrual];
    paymentAccrualTitle.backgroundColor = kColorClear;
    paymentAccrualTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:paymentAccrualTitle];
    
    CGFloat paymentAccrualButtonX = titleWidth + 2 * kDefaultMargin;
    UIButton *paymentAccrualButton = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentAccrualButton.frame = CGRectMake(paymentAccrualButtonX, paymentAccrualY, inputWidth, kButtonHeight);
    paymentAccrualButton.layer.borderColor = kLineColor.CGColor;
    paymentAccrualButton.layer.borderWidth = 1;
    paymentAccrualButton.layer.cornerRadius = kRadius;
    paymentAccrualButton.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [paymentAccrualButton setTitleColor:kTextColor forState:UIControlStateNormal];
    [paymentAccrualButton setTitle:strPaymentAccrual forState:UIControlStateNormal];
    [paymentAccrualButton addTarget:self action:@selector(payTypeListSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:paymentAccrualButton];
    self.payTypeBtn = paymentAccrualButton;
    
    UIImageView *paymentAccrualMore = [[UIImageView alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin + inputWidth - 20, paymentAccrualY + (kButtonHeight - 16)/2, 16, 16)];
    //CGFloat lineY6 = numberY;
    paymentAccrualMore.image = IMAGE(@"showmore");
    [infoView addSubview:paymentAccrualMore];
    
    CGFloat lineY7 = lineY6+kDefaultMargin*2 + kButtonHeight;
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY7, width, 0.5)];
    lineView7.backgroundColor = kLineColor;
    [infoView addSubview:lineView7];
    
    
    //产品类型
    CGFloat timeY = lineY7 + kDefaultMargin + 1;
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, timeY, titleWidth, kTextFieldHeight)];
    timeTitle.font = kMiddleTextFont;
    timeTitle.textColor = kTextColor;
    timeTitle.text = [NSString stringWithFormat:@"%@:",StringProductCategory];
    timeTitle.backgroundColor = kColorClear;
    timeTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:timeTitle];
    
    CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
    NSString *strState = category.name;
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
    
    
    numberY=lineY7+kDefaultMargin*2 + kButtonHeight;
    CGFloat lineY8 = numberY;
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY8, width, 0.5)];
    lineView8.backgroundColor = kLineColor;
    [infoView addSubview:lineView8];
    
    //记录
    CGFloat lineY9 = lineY8+kDefaultMargin;
    CGRect rect = CGRectMake(kDefaultMargin, lineY9, width, kTextViewHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.tag = 1001;
    textView.font = kMiddleTextFont;
    textView.delegate = self;
    textView.text = [NSString stringWithFormat:@"选填，200字以内"];
    textView.textColor = kGrayTextColor;
    [textView setBounces:NO];
    //    textView.returnKeyType = UIReturnKeyDone;
    [infoView addSubview:textView];
    self.descTxtView = textView;

    
   
    CGFloat contentHeigth = lineY9+kTextViewHeight+60;
    if (contentHeigth > bounds.size.height)
    {
        _contentHeigth=contentHeigth-bounds.size.height;
        CGRect frame = bounds;
        frame.size.height = contentHeigth;
        frame.origin.y=0;
        infoView.frame = frame;
        self.scrollView.contentSize = infoView.frame.size;
        
    }

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
- (void) inipPayTypeList
{
    _payTypeList = [[NSMutableArray alloc] init];
    if (kAppDelegate.productPayTypeList&& kAppDelegate.productPayTypeList.count > 0)
    {
        
        for (int i = 0; i < kAppDelegate.productPayTypeList.count; i++)
        {
            CXListInvestCategoryModel *ListInvestCategory = [kAppDelegate.productPayTypeList objectAtIndex:i];
            
            [_payTypeList addObject:ListInvestCategory];
        }
    }
}

- (void) sendSubscribeToServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringAdding;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];

    CXCategoryModel *category = [_categoryList objectAtIndex:self.curCategory];
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"name" andStringValue:self.nameField.text];
    [parametersUtil appendParameterWithName:@"payDate" andStringValue:self.payDateField.text];
    [parametersUtil appendParameterWithName:@"amount" andStringValue:self.amountField.text];
    [parametersUtil appendParameterWithName:@"lockArea" andStringValue:self.lockAreaField.text];
    [parametersUtil appendParameterWithName:@"profit" andStringValue:self.profitField.text];
    [parametersUtil appendParameterWithName:@"payer" andStringValue:self.payerField.text];
    [parametersUtil appendParameterWithName:@"category" andIntValue:category.Id];
    
    NSString *intro = [NSString stringWithFormat:@"选填，200字以内"];
    if ([self.descTxtView.text compare:intro] != 0)
    {
        [parametersUtil appendParameterWithName:@"remark" andStringValue:self.descTxtView.text];
    }
    
    if (self.payTypeList!=nil&&self.payTypeList.count>0) {
        CXListInvestCategoryModel *payTypeInto = [self.payTypeList objectAtIndex:self.payTypeCategory];
        [parametersUtil appendParameterWithName:@"payType" andIntValue:payTypeInto.Id];
        
    }

    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_TRACK_RELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];

        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"添加成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
                //发送通知
                NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_TRACK_UPDATA object:nil];
                
            }
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

- (void) sendSubscribe
{
    [self hideKeyBoard];

    if (self.nameField.text.length == 0)
    {
        [self ShowProgressHUB:@"请填写产品名称"];
        return;
    }
    else if (self.nameField.text.length >= 30)
    {
        [self ShowProgressHUB:@"产品名称不可高于30个字符"];
        return;
    }
    if (self.payDateField.text.length == 0) {
        [self ShowProgressHUB:@"请填写购买时间!"];
        return;
    }
    if (self.amountField.text.length > 0)
    {
        if ([XStringHelper isPureInt:self.amountField.text] == NO)
        {
            [self ShowProgressHUB:@"购买金额请填写数字"];
            return;
        }

        NSInteger scale = [self.amountField.text integerValue];
        if (scale > 1000000)
        {
            [self ShowProgressHUB:@"购买金额不能超过100亿！"];
            return;
        }
        else if (scale <= 0)
        {
            [self ShowProgressHUB:@"购买金额请填写有效数字！"];
            return;
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写购买金额!"];
        return;
    }

    if (self.lockAreaField.text.length == 0)
    {
        [self ShowProgressHUB:@"请填写封闭期限"];
        return;
    }
    
    if (self.profitField.text.length == 0)
    {
        [self ShowProgressHUB:@"请填写收益!"];
        return;
    }
    if (self.descTxtView.text.length > 200 )
    {
        [self ShowProgressHUB:@"记录不能大于200个字"];
        return;
    }

    [self sendSubscribeToServer];
}

- (void) showTimeSelectBegin
{
    [self hideKeyBoard];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_categoryList.count];
    
    for (CXCategoryModel *category in _categoryList)
    {
        [arr addObject:category.name];
    }
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:arr andSelect:self.curCategory];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    [self.navigationController pushViewController:modifyControl animated:YES];
}


- (void)phoneBtnClick:(UIButton *)button
{
    [self hideKeyBoard];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://075526657682"]];
}

- (void) hideKeyBoard
{
    [self.payDateField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.lockAreaField resignFirstResponder];
    [self.profitField resignFirstResponder];
    [self.payerField resignFirstResponder];
    [self.descTxtView resignFirstResponder];
}

-(void)nameSearchbtnClick:(UIButton *)btn
{
    CXSearchMyTrackViewController *searchViewControl = [[CXSearchMyTrackViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [searchViewControl getModel:^(CXProductModel *model) {
        if (model!=nil) {
            self.nameField.text=model.title;
            self.profitField.text=model.profit;
            self.lockAreaField.text=model.deadline;
            for (int i=0; i<self.categoryList.count; i++) {
                CXCategoryModel *category = [self.categoryList objectAtIndex:i];
                if (category.Id==model.category) {
                    self.curCategory = i;
                    NSString *strState = category.name;
                    [self.categoryBtn setTitle:strState forState:UIControlStateNormal];
                }
            }
            
        }
    }];
    
    [self.navigationController pushViewController:searchViewControl animated:YES];
}
-(void)payTypeListSelectBegin
{
    [self hideKeyBoard];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_payTypeList.count];
    
    for (CXCategoryModel *category in _payTypeList)
    {
        [arr addObject:category.name];
    }
    [self.view endEditing:YES];
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:arr andSelect:self.payTypeCategory];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=2;
    [self.navigationController pushViewController:modifyControl animated:YES];
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%f,%f",kScreenHeight,kKeyboardHeight);
    int y = kScreenHeight - kKeyboardHeight -80-64;
    CGRect frame = textField.frame;
    int moveY = 0;
    if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
    {
        NSLog(@"%f",frame.origin.y+frame.size.height-_alreadyContentHeigth);
        moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
        
    }
    if (textField == _payDateField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _amountField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _lockAreaField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _profitField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    if (textField == _payerField) {
        [self moveViewWhentextFieldBeginEdding:moveY];
    }
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    int y = kScreenHeight - kKeyboardHeight - 80 - 64;
    CGRect frame = textField.frame;
    int moveY = 0;
    
    if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
    {
        moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
    }
    
    
    if (textField == _payDateField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    
    if (textField == _amountField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _lockAreaField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _profitField) {
        [self moveViewWhentextFieldEndEdding:moveY];
        [textField resignFirstResponder];
    }
    if (textField == _payerField) {
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
    
    //先移动ScrollerView
    if (_contentHeigth-_alreadyContentHeigth>moveY) {
        [self.scrollView setContentOffset:CGPointMake(0, moveY) animated:YES];
        return;
    }
    
    //先移动scrollerview里面可以移动的，再移动视图
    else
    {
        //_alreadyContentHeigth=0;
        float ContentNum=moveY-(_contentHeigth-_alreadyContentHeigth);
        [self.scrollView setContentOffset:CGPointMake(0, _contentHeigth) animated:YES];
        _textFieldMove=ContentNum;
    }
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -= _textFieldMove;//view的Y轴上移
    frame.size.height += _textFieldMove; //View的高度增加
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}

- (void) moveViewWhentextFieldEndEdding:(float) moveY
{
    if (_contentHeigth-_alreadyContentHeigth>=moveY) {
        //float ContentNum=2*moveY-_alreadyContentHeigth;
        //float *contentNUm=
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _alreadyContentHeigth=0;
        
        return;
    }
    else if (_contentHeigth==_alreadyContentHeigth)
    {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        float ContentNum=moveY;
        _textFieldMove=ContentNum;
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        float ContentNum=moveY-(_contentHeigth-_alreadyContentHeigth);
        //[self.scrollView setContentOffset:CGPointMake(0, _contentHeigth) animated:YES];
        _textFieldMove=ContentNum;
    }
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y += _textFieldMove;//view的Y轴上移
    frame.size.height -= _textFieldMove; //View的高度增加
    
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
        int moveY = 0;
        
        if (frame.origin.y+frame.size.height-_alreadyContentHeigth> y)
        {
            moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
            moveY-=15;
        }
        [self moveViewWhentextFieldBeginEdding:moveY];
        if ([textView.text isEqualToString:[NSString stringWithFormat:@"选填，200字以内"]]) {
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
        int moveY = 0;
        if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
        {
            moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
            moveY-=15;
        }
        [self moveViewWhentextFieldEndEdding:moveY];
        if ([textView.text isEqualToString:@""]) {
            textView.text = [NSString stringWithFormat:@"选填，200字以内"];
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
#pragma mark - CXSelectTableViewControllerDelegate
- (void)setSelected:(int)nameId andIndex:(int)index;
{
    if (nameId==0) {
        self.curCategory=index;
        CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
        NSString *strState = category.name;
        [self.categoryBtn setTitle:strState forState:UIControlStateNormal];
    }
    else if (nameId==2)
    {
        self.payTypeCategory=index;
        CXListInvestCategoryModel *ListInvestCategory = [self.payTypeList objectAtIndex:self.payTypeCategory];
        NSString *strListInvestCategory = ListInvestCategory.name;
        [self.payTypeBtn setTitle:strListInvestCategory forState:UIControlStateNormal];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{   [super viewWillDisappear:YES];
    //[self.ReleaseProduct resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.payDateField resignFirstResponder];
    [self.amountField resignFirstResponder];
    [self.lockAreaField resignFirstResponder];
    [self.profitField resignFirstResponder];
    [self.payerField resignFirstResponder];
    [self.descTxtView resignFirstResponder];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _alreadyContentHeigth=scrollView.contentOffset.y;

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
@end
