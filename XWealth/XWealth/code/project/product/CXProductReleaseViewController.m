//
//  CXProductReleaseViewController.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductReleaseViewController.h"


#define TIMESTATE_BUTTON_WIDTH    90

@interface CXProductReleaseViewController ()<CXSelectTableViewControllerDelegate>

@end

@implementation CXProductReleaseViewController
{
    float _textFieldMove;   //记录视图移动的位置
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布产品";
    self.view.backgroundColor = kColorWhite;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _contentHeigth=0;
    _textFieldMove=0;
    self.curCategory = 0;
    self.moneyIntoCurCategory=0;
    [self initCategoryList];
    [self initMoneyIntoList];
    
    [self initRightBarButton];
    [self makeInfoView];
//    [self phoneView];
    
    // 手势，点空白区域，收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    moneyTitle.textAlignment = NSTextAlignmentCenter;
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
    numberTitle.textAlignment = NSTextAlignmentCenter;
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
    profitTitle.textAlignment = NSTextAlignmentCenter;
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
    timeTitle.textAlignment = NSTextAlignmentCenter;
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
    
    
    NSString *strMoneyState;
    if (self.moneyIntoList.count>0) {
        CXListInvestCategoryModel *moneyCategory = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
        strMoneyState = moneyCategory.name;
    }
    //投向
    CGFloat moneyIntoY = lineY5 + kDefaultMargin + 1;
    
    UILabel *moneyIntoTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyIntoY, titleWidth, kTextFieldHeight)];
    moneyIntoTitle.font = kMiddleTextFont;
    moneyIntoTitle.textColor = kTextColor;
    moneyIntoTitle.text = [NSString stringWithFormat:@"%@:",StringProductMoneyInto];
    moneyIntoTitle.backgroundColor = kColorClear;
    moneyIntoTitle.textAlignment = NSTextAlignmentCenter;
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
    [moneyIntoButton setTitle:strMoneyState forState:UIControlStateNormal];
    [moneyIntoButton addTarget:self action:@selector(moneyIntoSelectBegin) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:moneyIntoButton];
    self.moneyIntoBtn = moneyIntoButton;
    
    UIImageView *moneyIntoMore = [[UIImageView alloc] initWithFrame:CGRectMake(titleWidth + 2 * kDefaultMargin + TIMESTATE_BUTTON_WIDTH - 20, moneyIntoY + (kButtonHeight - 16)/2, 16, 16)];
    //CGFloat lineY6 = numberY;
    moneyIntoMore.image = IMAGE(@"showmore");
    [infoView addSubview:moneyIntoMore];
    
    CGFloat lineY6 = lineY5+kDefaultMargin*2 + kButtonHeight;
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

#pragma mark - private methods

- (void) sendSubscribe
{
    //[self hideKeyBoard];
    if (self.nameField.text.length == 0 || [self.nameField.text isEqualToString:StringProductName])
    {
        [self ShowProgressHUB:@"请填写产品名称"];
        return;
    }
    if (self.scaleField.text.length > 0)
    {
        if ([XStringHelper isPureInt:self.scaleField.text] == NO)
        {
            [self ShowProgressHUB:@"产品规模请填写数字"];
            return;
        }
        
        NSInteger scale = [self.scaleField.text integerValue];
        if (scale > 1000000)
        {
            [self ShowProgressHUB:@"产品规模不能超过100亿！"];
            return;
        }
        else if (scale <= 0)
        {
            [self ShowProgressHUB:@"产品规模请填写有效数字！"];
            return;
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写产品规模!"];
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
    
    if (self.profitField.text.length > 0)
    {
        if ([XStringHelper isPureFloat:self.profitField.text] == NO)
        {
            [self ShowProgressHUB:@"最低收益请填写有效的数字"];
            return;
        }
        
        CGFloat profit = [self.profitField.text floatValue];
        if (profit > 1000)
        {
            [self ShowProgressHUB:@"最低收益不能超过1000%！"];
            return;
        }
        else if (profit <= 0)
        {
            [self ShowProgressHUB:@"最低收益请填写有效的数字！"];
            return;
        }
    }
    
    
    if (self.descTxtView.text.length > 200 )
    {
        [self ShowProgressHUB:@"产品简介不能大于200个字"];
        return;
    }
    
    [self sendSubscribeToServer];
}
- (void) sendSubscribeToServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringAdding;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    CXCategoryModel *category = [self.categoryList objectAtIndex:self.curCategory];
    CXListInvestCategoryModel *moneyInto = [self.moneyIntoList objectAtIndex:self.moneyIntoCurCategory];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"name" andStringValue:self.nameField.text];
    [parametersUtil appendParameterWithName:@"scale" andStringValue:self.scaleField.text];
    [parametersUtil appendParameterWithName:@"deadline" andStringValue:self.deadlineField.text];
    [parametersUtil appendParameterWithName:@"profit" andStringValue:self.profitField.text];
    [parametersUtil appendParameterWithName:@"category" andIntValue:category.Id];
    [parametersUtil appendParameterWithName:@"moneyInto" andIntValue:moneyInto.Id];
    
    NSString *intro = [NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief];
    if ([self.descTxtView.text compare:intro] != 0)
    {
        [parametersUtil appendParameterWithName:@"intro" andStringValue:self.descTxtView.text];
    }
    
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_RELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"产品发布成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                //                _RefreshTime=[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeClcick) userInfo:0 repeats:YES];
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

- (void)phoneBtnClick:(UIButton *)button
{
    [self hideKeyBoard];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
}

- (void) hideKeyBoard
{
    [self.scaleField resignFirstResponder];
    [self.deadlineField resignFirstResponder];
    [self.descTxtView resignFirstResponder];
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
    int moveY = 0;
    
    if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
    {
        moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
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
        int moveY = 0;
        if (frame.origin.y+frame.size.height-_alreadyContentHeigth > y)
        {
            moveY = frame.origin.y+frame.size.height -_alreadyContentHeigth- y;
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
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    //回归原位
    [self.descTxtView resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark--UIGestureRecognizerDelegate

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
    [self.scaleField resignFirstResponder];
    [self.descTxtView resignFirstResponder];
    

    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}



@end
