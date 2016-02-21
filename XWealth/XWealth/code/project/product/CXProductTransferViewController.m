//
//  CXProductTransferViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXProductTransferViewController.h"
#import "CXSearchProductTransferViewController.h"
@interface CXProductTransferViewController ()

@end
#define TIMESTATE_BUTTON_WIDTH    90
@implementation CXProductTransferViewController
{
    float _textFieldMove;   //记录视图移动的位置
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信托转让";
    self.view.backgroundColor = kColorWhite;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _contentHeigth=0;
    _textFieldMove=0;
    self.curCategory = 0;
    self.moneyIntoCurCategory=0;
    self.payTypeCategory=0;
    self.productId=0;
    _sourceDatas=[[NSMutableArray alloc]init];
    [self initCategoryList];
    [self inipPayTypeList];
    [self categoryList];
    [self initMoneyIntoList];
    [self initRightBarButton];
    [self makeInfoView];
    //    [self phoneView];
    
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
}
- (void) initRightBarButton
{
    UIButton *sendTradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendTradeBtn.frame = CGRectMake(0, 0, 60, 30);
    sendTradeBtn.titleLabel.font = kMiddleTextFontBold;
    sendTradeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sendTradeBtn setTitle:StringSubmit forState:UIControlStateNormal];
    [sendTradeBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
    
}
- (void) makeInfoView
{
    CGRect bounds = self.view.frame; //  CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavAndStatusBarHeight) ;
    bounds.origin.y=0;
    bounds.origin.y += kViewBeginOriginY;
    bounds.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight   : 0;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.backgroundColor = kControlBgColor;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGRect infoViewBounds = self.view.frame;
    infoViewBounds.origin.y=0;
    infoViewBounds.size.height=bounds.size.height;
    UIView *infoView = [[UIView alloc] initWithFrame:infoViewBounds];
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
    nameTitle.textAlignment = NSTextAlignmentCenter;
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
    //产品期限
    UILabel *deadlineTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyY, titleWidth, kTextFieldHeight)];
    deadlineTitle.font = kMiddleTextFont;
    deadlineTitle.textColor = kTextColor;
    deadlineTitle.text = [NSString stringWithFormat:@"%@:",StringProductDeadline];
    deadlineTitle.backgroundColor = kColorClear;
    deadlineTitle.textAlignment = NSTextAlignmentCenter;
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
    moneyTitle.textAlignment = NSTextAlignmentCenter;
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
    timeTitle.textAlignment = NSTextAlignmentCenter;
    
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
    = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.view.frame.size.width, 200)
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
        [self.view endEditing:YES];
    }];
    [datePicker setRightButton:^(NSString *year,
                                 NSString *month,
                                 NSString *day,
                                 NSString *hour,
                                 NSString *minute,
                                 NSString *weekDay){
        timeField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        [self.view endEditing:YES];
    }];
    timeField.inputView = datePicker;
    self.establishDateField = timeField;
    
    
    
    numberY=lineY3+kDefaultMargin*2 + kTextFieldHeight;
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
    profitTitle.textAlignment = NSTextAlignmentCenter;
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
    
    //投向
    NSString *strMoneyState;
    if (self.moneyIntoList.count>0) {
        CXListInvestCategoryModel *category = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
        strMoneyState = category.name;
    }
    CGFloat moneyIntoY = lineY5 + kDefaultMargin + 1;
    
    UILabel *moneyIntoTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyIntoY, titleWidth, kTextFieldHeight)];
    moneyIntoTitle.font = kMiddleTextFont;
    moneyIntoTitle.textColor = kTextColor;
    moneyIntoTitle.text = [NSString stringWithFormat:@"%@:",StringProductMoneyInto];
    moneyIntoTitle.backgroundColor = kColorClear;
    moneyIntoTitle.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:moneyIntoTitle];
    
    CGFloat moneyIntoButtonX =titleWidth + 3 * kDefaultMargin+TIMESTATE_BUTTON_WIDTH;
    UIButton *moneyIntoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moneyIntoButton.frame = CGRectMake(moneyIntoButtonX, moneyIntoY, TIMESTATE_BUTTON_WIDTH, kButtonHeight);
    moneyIntoButton.layer.borderColor = kLineColor.CGColor;
    moneyIntoButton.layer.borderWidth = 1;
    moneyIntoButton.layer.cornerRadius = kRadius;
    moneyIntoButton.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [moneyIntoButton setTitleColor:kTextColor forState:UIControlStateNormal];
    [moneyIntoButton setTitle:strMoneyState forState:UIControlStateNormal];
    [moneyIntoButton addTarget:self action:@selector(moneyIntoSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:moneyIntoButton];
    self.moneyIntoBtn = moneyIntoButton;
    
    UIImageView *moneyIntoMore = [[UIImageView alloc] initWithFrame:CGRectMake(moneyIntoButtonX  + TIMESTATE_BUTTON_WIDTH - 20, moneyIntoY + (kButtonHeight - 16)/2, 16, 16)];
    //CGFloat lineY6 = numberY;
    moneyIntoMore.image = IMAGE(@"showmore");
    [infoView addSubview:moneyIntoMore];
    
    
    NSString *strState;
    if (self.categoryList.count>0) {
        CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
        strState = category.name;
    }
    
    CGFloat categoryBtnX = titleWidth + 2 * kDefaultMargin;
    UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryBtn.frame = CGRectMake(categoryBtnX, moneyIntoY, TIMESTATE_BUTTON_WIDTH, kButtonHeight);
    categoryBtn.layer.borderColor = kLineColor.CGColor;
    categoryBtn.layer.borderWidth = 1;
    categoryBtn.layer.cornerRadius = kRadius;
    categoryBtn.titleLabel.font = kMiddleTextFont;
    //    [timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [categoryBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [categoryBtn setTitle:strState forState:UIControlStateNormal];
    [categoryBtn addTarget:self action:@selector(showTimeSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:categoryBtn];
    self.categoryBtn = categoryBtn;
    
    UIImageView *timeMore = [[UIImageView alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin + TIMESTATE_BUTTON_WIDTH - 20, moneyIntoY + (kButtonHeight - 16)/2, 16, 16)];
    timeMore.image = IMAGE(@"showmore");
    [infoView addSubview:timeMore];

    
    CGFloat lineY6 = lineY5+kDefaultMargin*2 + kButtonHeight;
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY6, width, 0.5)];
    lineView6.backgroundColor = kLineColor;
    [infoView addSubview:lineView6];

        //产品类型
//        CGFloat categoryBtnY = lineY6 + kDefaultMargin + 1;
//    
//        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, categoryBtnY, titleWidth, kTextFieldHeight)];
//        categoryTitle.font = kMiddleTextFont;
//        categoryTitle.textColor = kTextColor;
//        categoryTitle.text = [NSString stringWithFormat:@"%@:",StringProductCategory];
//        categoryTitle.backgroundColor = kColorClear;
//        categoryTitle.textAlignment = NSTextAlignmentCenter;
//        [infoView addSubview:categoryTitle];
//    
//    
//    
//        numberY=lineY6+kDefaultMargin*2 + kButtonHeight;
//        CGFloat lineY7 = numberY;
//        UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY7, width, 0.5)];
//        lineView7.backgroundColor = kLineColor;
//        [infoView addSubview:lineView7];

    
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
    paymentAccrualTitle.textAlignment = NSTextAlignmentCenter;
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
    
    CGFloat lineY8 = lineY6+kDefaultMargin*2 + kButtonHeight;
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY8, width, 0.5)];
    lineView8.backgroundColor = kLineColor;
    [infoView addSubview:lineView8];
    
    
    
    
    //姓名
    CGFloat customerY = lineY8 + 1 + kDefaultMargin;
    
    UILabel *customerTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, customerY, titleWidth, kTextFieldHeight)];
    customerTitle.font = kMiddleTextFont;
    customerTitle.textColor = kTextColor;
    customerTitle.text = [NSString stringWithFormat:@"%@:",StringProductUserName];
    customerTitle.backgroundColor = kColorClear;
    customerTitle.textAlignment = NSTextAlignmentCenter;
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
    
    
    CGFloat lineY10 = customerY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY10, width, 0.5)];
    lineView10.backgroundColor = kLineColor;
    [infoView addSubview:lineView10];
    
    
    
    //手机号码
    CGFloat phoneY = lineY10 + 1 + kDefaultMargin;
    
    UILabel *phoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, phoneY, titleWidth, kTextFieldHeight)];
    phoneTitle.font = kMiddleTextFont;
    phoneTitle.textColor = kTextColor;
    phoneTitle.text = [NSString stringWithFormat:@"%@:",StringProductPhone];
    phoneTitle.backgroundColor = kColorClear;
    phoneTitle.textAlignment = NSTextAlignmentCenter;
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
    
    
    CGFloat lineY11 = phoneY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY11, width, 0.5)];
    lineView11.backgroundColor = kLineColor;
    [infoView addSubview:lineView11];
    
    
    //收益权是否接受折扣
    CGFloat discountBoolY = lineY11 + kDefaultMargin + 1;
    UIButton *discountBoolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    discountBoolButton.frame = CGRectMake(kDefaultMargin*2, discountBoolY, 24, 22);
    [discountBoolButton setImage:[UIImage imageNamed:@"confirmType_back"] forState:UIControlStateNormal];
    [discountBoolButton setImage:[UIImage imageNamed:@"confirm_type"] forState:UIControlStateSelected];
    [discountBoolButton addTarget:self action:@selector(acceptDisCountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    discountBoolButton.layer.borderColor = kLineColor.CGColor;
    discountBoolButton.selected=YES;
    [infoView addSubview:discountBoolButton];
    self.acceptDisCountBtn = discountBoolButton;
    
    CGFloat discountBoolButtonX = kDefaultMargin*3 + 24;
    UILabel *discountBoolTitle = [[UILabel alloc] initWithFrame:CGRectMake(discountBoolButtonX, discountBoolY, 200, 22)];
    discountBoolTitle.font = kSmallTextFont;
    discountBoolTitle.textColor = kAssistTextColor;
    discountBoolTitle.text = [NSString stringWithFormat:@"%@",StringdiscountBool];
    discountBoolTitle.backgroundColor = kColorClear;
    discountBoolTitle.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:discountBoolTitle];
    
    CGFloat lineY12 = lineY11+kSmallMargin*2 + 22;
//    UIView *lineView12 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY12, width, 0.5)];
//    lineView12.backgroundColor = kLineColor;
//    [infoView addSubview:lineView12];

    
    //产品简介
    CGFloat lineY13 = lineY12+kDefaultMargin;
    CGRect rect = CGRectMake(kDefaultMargin, lineY13, width, kTextViewHeight);
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
    
    [self phoneView: lineY13 + kTextViewHeight + kLargeMargin andView:infoView];
    float linY14=lineY13 + kTextViewHeight +kButtonHeight+kLargeMargin;
    CGFloat contentHeigth = linY14 + kLargeMargin;
    if (contentHeigth > bounds.size.height)
    {
        //        NSLog(@"%f",bounds.size.height);
        //        NSLog(@"%f",lineY7 + kTextViewHeight + kLargeMargin);
        //        NSLog(@"%f",self.bounds.size.height);
        _contentHeigth=contentHeigth-bounds.size.height;
        CGRect frame = bounds;
        frame.size.height = contentHeigth;
        frame.origin.y=0;
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
    [_phoneBtn setTitle: @"400-895-5056" forState: UIControlStateNormal];
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
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


- (void) sendSubscribe
{
    //[self hideKeyBoard];
    if (self.nameField.text.length == 0 || [self.nameField.text isEqualToString:StringProductName])
    {
        [self ShowProgressHUB:@"请填写产品名称"];
        return;
    }
    
    
    if (self.deadlineField.text.length > 0)
    {
        if ([XStringHelper isPureInt:self.deadlineField.text] == NO)
        {
            [self ShowProgressHUB:@"产品期限请填写数字"];
            return;
        }
        
        NSInteger deadline = [self.deadlineField.text integerValue];
        if (deadline > 240)
        {
            [self ShowProgressHUB:@"产品期限不能超过20年！"];
            return;
        }
        else if (deadline <= 0)
        {
            [self ShowProgressHUB:@"产品期限请填写有效数字！"];
            return;
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写产品期限"];
        return;
    }
    
    if (self.moneyField.text.length > 0)
    {
        if ([XStringHelper isPureInt:self.moneyField.text] == NO)
        {
            [self ShowProgressHUB:@"认购金额请填写数字"];
            return;
        }
        
        NSInteger scale = [self.moneyField.text integerValue];
        if (scale > 1000000)
        {
            [self ShowProgressHUB:@"认购金额不能超过100亿！"];
            return;
        }
        else if (scale <= 0)
        {
            [self ShowProgressHUB:@"认购金额请填写有效数字！"];
            return;
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写认购金额!"];
        return;
    }
    
    if (self.establishDateField.text.length == 0)
    {
        [self ShowProgressHUB:@"请填写成立日期!"];
        return;
    }
    
    if (self.profitField.text.length > 0)
    {
        
        NSInteger scale = [self.profitField.text integerValue];
        if (scale > 1000)
        {
            [self ShowProgressHUB:@"预期收益不能超过1000%！"];
            return;
        }
        else if (scale <= 0)
        {
            [self ShowProgressHUB:@"预期收益请填写有效数字！"];
            return;
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写预期收益!"];
        return;
    }
    if (self.introTxtView.text.length > 200 )
    {
        [self ShowProgressHUB:@"其他说明不能大于200个字"];
        return;
    }
    [self sendSubscribeToServer];
}
- (void) sendSubscribeToServer
{
     [self.view endEditing:YES];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringAdding;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
   
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"productId" andLongValue:self.productId];
    [parametersUtil appendParameterWithName:@"name" andStringValue:self.nameField.text];
    [parametersUtil appendParameterWithName:@"deadline" andStringValue:self.deadlineField.text];
    [parametersUtil appendParameterWithName:@"money" andStringValue:self.moneyField.text];
    [parametersUtil appendParameterWithName:@"establishDate" andStringValue:self.establishDateField.text];
    [parametersUtil appendParameterWithName:@"profit" andStringValue:self.profitField.text];
    [parametersUtil appendParameterWithName:@"userName" andStringValue:self.userNameField.text];
    [parametersUtil appendParameterWithName:@"phone" andStringValue:self.phoneField.text];
    if (self.categoryList!=nil&&self.categoryList.count>0) {
         CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
         [parametersUtil appendParameterWithName:@"categoryId" andIntValue:category.Id];//默认为三信托
        
    }
    if (self.moneyIntoList!=nil&&self.moneyIntoList.count>0) {
        CXListInvestCategoryModel *moneyInto = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
        [parametersUtil appendParameterWithName:@"investTypeId" andIntValue:moneyInto.Id];
        
    }
    
    if (self.payTypeList!=nil&&self.payTypeList.count>0) {
        CXListInvestCategoryModel *payTypeInto = [self.payTypeList objectAtIndex:self.payTypeCategory];
        [parametersUtil appendParameterWithName:@"payType" andIntValue:payTypeInto.Id];

    }
    
    if (_acceptDisCountBtn.selected) {
        [parametersUtil appendParameterWithName:@"acceptDisCount" andIntValue:1];
    }
    else
    {
        [parametersUtil appendParameterWithName:@"acceptDisCount" andIntValue:0];
    }
    
    if ([self.introTxtView.text compare:StringProductOther] != 0)
    {
        [parametersUtil appendParameterWithName:@"intro" andStringValue:self.introTxtView.text];
    }
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_RELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {

                _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
                UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您发布的信托转让信息已经提交，客服会在1-3个工作日与您联系，如您急需转让此信托，请直接联系客服。" delegate:self cancelButtonTitle:@"客服电话" otherButtonTitles:@"确定", nil];
                [alar show];
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
#pragma mark data & network data
- (void) initCategoryList
{
    _categoryList = [[NSMutableArray alloc] init];
    
    if (kAppDelegate.productCategoryList && kAppDelegate.productCategoryList.count > 2)
    {
        
        for (int i = 2; i < kAppDelegate.productCategoryList.count-2; i++)
        {
            CXCategoryModel *category = [kAppDelegate.productCategoryList objectAtIndex:i];
            
            [_categoryList addObject:category];
        }
    }
//        _categoryList = [[NSArray alloc] initWithObjects:StringTrust, StringFund, StringShibosai, StringOther, nil];
}

- (void) initMoneyIntoList
{
    _moneyIntoList = [[NSMutableArray alloc] init];
    if (kAppDelegate.productMoneyIntoList&& kAppDelegate.productMoneyIntoList.count > 0)
    {
        
        for (int i = 0; i < kAppDelegate.productMoneyIntoList.count; i++)
        {
            CXListInvestCategoryModel *ListInvestCategory = [kAppDelegate.productMoneyIntoList objectAtIndex:i];
            
            [_moneyIntoList addObject:ListInvestCategory];
        }
    }
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
#pragma mark - private methods
-(void)moneyIntoSelectBegin
{
    [self hideKeyBoard];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_moneyIntoList.count];
    
    for (CXListInvestCategoryModel *ListInvestCategory in _moneyIntoList)
    {
        [arr addObject:ListInvestCategory.name];
    }
    [self.view endEditing:YES];
    CXSelectTableViewController *moneyIntoControl = [[CXSelectTableViewController alloc] initWithSourceData:arr andSelect:self.moneyIntoCurCategory];
    moneyIntoControl.delegate = self;
    moneyIntoControl.title = StringProductMoneyInto;
    moneyIntoControl.nameId=1;
    [self.navigationController pushViewController:moneyIntoControl animated:YES];
    
}
-(void)showTimeSelectBegin
{
    [self hideKeyBoard];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_categoryList.count];
    
    for (CXCategoryModel *category in _categoryList)
    {
        [arr addObject:category.name];
    }
    [self.view endEditing:YES];
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:arr andSelect:self.curCategory];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=0;
    [self.navigationController pushViewController:modifyControl animated:YES];
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
-(void)acceptDisCountBtnClick
{
    if(self.acceptDisCountBtn.selected)
    {
        [self.acceptDisCountBtn setSelected:NO];
        //[self.acceptDisCountBtn setImage:[UIImage imageNamed:@"confirmType_back"] forState:UIControlStateNormal];
    }else{
        [self.acceptDisCountBtn setSelected:YES];
        //[self.acceptDisCountBtn  setBackgroundImage:[UIImage imageNamed:@"confirm_type"] forState:UIControlStateNormal];
    }
}
#pragma mark - buttonClick
-(void)nameSearchbtnClick:(UIButton *)btn
{
    CXSearchProductTransferViewController *searchViewControl = [[CXSearchProductTransferViewController alloc] init];
    searchViewControl.hidesBottomBarWhenPushed = YES;
    [searchViewControl getModel:^(CXProductModel *model) {
        if (model!=nil) {
            self.productId=model.productId;
            self.nameField.text=model.title;
            self.deadlineField.text=model.deadline;
            self.profitField.text=model.profit;
            if (![model.establishDate isEqualToString:@""]) {
                 self.establishDateField.text=[model.establishDate substringToIndex:10];
            }
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
#pragma mark - CXSelectTableViewControllerDelegate
- (void)setSelected:(int)nameId andIndex:(int)index;
{
    
    if (nameId==0) {
        self.curCategory = index;
        
        CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
        NSString *strState = category.name;
        [self.categoryBtn setTitle:strState forState:UIControlStateNormal];
    }
    else if (nameId==1)
    {
        self.moneyIntoCurCategory=index;
        CXListInvestCategoryModel *ListInvestCategory = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
        NSString *strListInvestCategory = ListInvestCategory.name;
        [self.moneyIntoBtn setTitle:strListInvestCategory forState:UIControlStateNormal];
        
    }
    else if (nameId==2)
    {
        self.payTypeCategory=index;
        CXListInvestCategoryModel *ListInvestCategory = [self.payTypeList objectAtIndex:self.payTypeCategory];
        NSString *strListInvestCategory = ListInvestCategory.name;
        [self.payTypeBtn setTitle:strListInvestCategory forState:UIControlStateNormal];
        
    }

    
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
    int moveY = 0;
    
    if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
    {
        moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
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
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
        case 0:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
        }
        break;
        case 1:
            if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
                CXBuybackTrustCenterRecommendViewController *buybackTrustCenterViewController=[[CXBuybackTrustCenterRecommendViewController alloc]init];
                buybackTrustCenterViewController.sourceDatas=self.sourceDatas;
                [self.navigationController pushViewController:buybackTrustCenterViewController animated:YES];
            }
        break;
        default:
            break;
            }
            

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
        int moveY = 0;
        if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
        {
            moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
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
    [self.view endEditing:YES];
}

#pragma mark--UIGestureRecognizerDelegate
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//
//    if([touch.view isKindOfClass:[UIButton class]])
//    {
//        return NO;
//    }
//    return YES;
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _alreadyContentHeigth=scrollView.contentOffset.y;
    NSLog(@"%f",_alreadyContentHeigth);
}
-(void)viewWillDisappear:(BOOL)animated
{   [super viewWillDisappear:YES];
    //[self.ReleaseProduct resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.profitField resignFirstResponder];
    [self.deadlineField resignFirstResponder];
    [self.introTxtView resignFirstResponder];
    [self.moneyField resignFirstResponder];
    [self.establishDateField resignFirstResponder];
    [self.userNameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}


@end
