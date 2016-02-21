//
//  CXReleaseViewController.m
//  XWealth
//
//  Created by gsycf on 15/8/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXReleaseViewController.h"

//4008955056
@interface CXReleaseViewController ()

@end

@implementation CXReleaseViewController
{
    NSTimer *_RefreshTime;
    NSInteger _timeNum;
}
-(instancetype)init
{
    if (self) {
        self=[super init];
        self.view.backgroundColor=kControlBgColor;
        self.title = @"发布产品";
        _timeNum=0;
        [self initRightBarButton];
        [self setViewButton];
        [self setScrollerView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    [sendTradeBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sendTradeBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
    
}
-(void)setViewButton
{
   
    UIView *buttonBackView=[[UIView alloc]initWithFrame:CGRectMake(0, kViewBeginOriginY, self.view.frame.size.width, kButtonHeight)];
    buttonBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:buttonBackView];
    
    CGRect CentreBackViewFram=CGRectMake(self.view.frame.size.width/2, kButtonHeight/4, 1, kButtonHeight/2);
    UIView *CentreBackView=[[UIView alloc]initWithFrame:CentreBackViewFram];
    CentreBackView.backgroundColor=kGrayColor;
    [buttonBackView addSubview:CentreBackView];
    
    //右边的按钮
    CGRect leftFrame=CGRectMake(0, kViewBeginOriginY, self.view.frame.size.width/2-1, kButtonHeight);
    _leftBtn=[[UIButton alloc]initWithFrame:leftFrame];
    _leftBtn.tag=101;
    [_leftBtn setTitle:StringReleaseProduct forState:UIControlStateNormal];
    [_leftBtn setBackgroundColor:[UIColor whiteColor]];
    [_leftBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:KReleaseButtonColor forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(LeftRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.selected=YES;
    [self.view addSubview:_leftBtn];
    //左边的按钮
    CGRect RightFrame=CGRectMake(self.view.frame.size.width/2+1, kViewBeginOriginY, self.view.frame.size.width/2-1, kButtonHeight);
    _rightBtn=[[UIButton alloc]initWithFrame:RightFrame];
    _rightBtn.tag=102;
    [_rightBtn setTitle:StringTrustTransfer forState:UIControlStateNormal];
    [_rightBtn setBackgroundColor:[UIColor whiteColor]];
    [_rightBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:KReleaseButtonColor forState:UIControlStateSelected];
    [_rightBtn addTarget:self action:@selector(LeftRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBtn];
    
}
-(void)setScrollerView
{
    CGRect ScrollFrame=CGRectMake(0, kButtonHeight+kDefaultMargin+kViewBeginOriginY, self.view.frame.size.width, self.view.frame.size.height);
    
    ScrollFrame.size.height -= kDefaultMargin +kButtonHeight+kNavAndStatusBarHeight;
    _scrView=[[UIScrollView alloc]initWithFrame:ScrollFrame];
    _scrView.contentSize=CGSizeMake(self.view.frame.size.width*2, 0);
    _scrView.showsHorizontalScrollIndicator=NO;
    _scrView.showsVerticalScrollIndicator=NO;
    _scrView.bounces=NO;
    _scrView.pagingEnabled=YES;
    _scrView.delegate=self;
    [self.view addSubview:_scrView];
    
    CGRect ReleaseProductFram=CGRectMake(0, 0, self.view.frame.size.width, ScrollFrame.size.height);
    self.ReleaseProduct=[[CXReleaseProductView alloc]initWithFrame:ReleaseProductFram];
    self.ReleaseProduct.delegate=self;
    _ReleaseProduct.userInteractionEnabled=YES;
    [_scrView addSubview:self.ReleaseProduct];
    
    CGRect ReleaseBenefitFram=CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, ScrollFrame.size.height);
    _ReleaseBenefit=[[CXReleaseBenefitView alloc]initWithFrame:ReleaseBenefitFram];
    //_ReleaseProduct.delegate=self;
    _ReleaseBenefit.userInteractionEnabled=YES;
    [_scrView addSubview:_ReleaseBenefit];
}

#pragma mark - button methods
-(void)LeftRightButtonClick:(UIButton *)btn
{
    if (btn.tag==101) {
        _rightBtn.selected=NO;
        [btn setSelected:YES];
        [self.ReleaseBenefit endEditing:YES];
        [self textToNil:1];
        [_scrView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (btn.tag==102)
    {
        _leftBtn.selected=NO;
        btn.selected=YES;
        [self.ReleaseProduct endEditing:YES];
        [self textToNil:0];
        [_scrView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    }
    
}





#pragma mark - private UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int contenOffer=scrollView.contentOffset.x/self.view.frame.size.width;
    switch (contenOffer) {
        case 0:
            _rightBtn.selected=NO;
            _leftBtn.selected=YES;
            [self.ReleaseProduct endEditing:YES];
            [self textToNil:1];
            break;
        case 1:
            _rightBtn.selected=YES;
            _leftBtn.selected=NO;
            [self.ReleaseBenefit endEditing:YES];
            [self textToNil:0];
            break;
        default:
            break;
    }
}
#pragma mark - textToNil
-(void)textToNil:(int)index
{
    switch (index) {
        case 0:
            self.ReleaseProduct.nameField.text=nil;
            self.ReleaseProduct.profitField.text=nil;
            self.ReleaseProduct.descTxtView.text=nil;
            self.ReleaseProduct.scaleField.text=nil;
            self.ReleaseProduct.deadlineField.text=nil;
            self.ReleaseProduct.descTxtView.text = [NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief];
            self.ReleaseProduct.descTxtView.textColor = kGrayTextColor;
            break;
        case 1:
            self.ReleaseBenefit.nameField.text=nil;
            self.ReleaseBenefit.deadlineField.text=nil;
            self.ReleaseBenefit.moneyField.text=nil;
            self.ReleaseBenefit.profitField.text=nil;
            self.ReleaseBenefit.introTxtView.text = [NSString stringWithFormat:@"%@",StringProductOther];
            self.ReleaseBenefit.introTxtView.textColor = kGrayTextColor;
            break;
        default:
            break;
    }
    
}
#pragma mark - private methods

- (void) sendSubscribe
{
    if (self.leftBtn.selected) {
        [self LeftSendSubscribe];
        [self.ReleaseProduct endEditing:YES];
    }
    else if (self.rightBtn.selected)
    {
        [self.ReleaseBenefit endEditing:YES];
        [self RightSendSubscribe];
    }
    
}
-(void)setCategory:(NSArray *)categoryData andIndex:(int)index
{
    [self.ReleaseProduct endEditing:YES];
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:categoryData andSelect:index];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=0;
    [self.navigationController pushViewController:modifyControl animated:YES];
}
-(void)setmoneyInto:(NSArray *)categoryData andIndex:(int)index
{
    [self.ReleaseBenefit endEditing:YES];
    CXSelectTableViewController *moneyIntoControl = [[CXSelectTableViewController alloc] initWithSourceData:categoryData andSelect:index];
    moneyIntoControl.delegate = self;
    moneyIntoControl.title = StringProductMoneyInto;
    moneyIntoControl.nameId=1;
    [self.navigationController pushViewController:moneyIntoControl animated:YES];
    
}
#pragma mark - CXSelectTableViewControllerDelegate
- (void)setSelected:(int)nameId andIndex:(int)index;
{
    if (nameId==0) {
        
        _ReleaseProduct.curCategory=index;
        CXCategoryModel *category = [_ReleaseProduct.categoryList objectAtIndex:_ReleaseProduct.curCategory];
        NSString *strState = category.name;
        [_ReleaseProduct.categoryBtn setTitle:strState forState:UIControlStateNormal];
    }
    else if (nameId==1)
    {
        _ReleaseProduct.moneyIntoCurCategory=index;
        CXListInvestCategoryModel *ListInvestCategory = [_ReleaseProduct.moneyIntoList objectAtIndex:_ReleaseProduct.moneyIntoCurCategory];
        NSString *strListInvestCategory = ListInvestCategory.name;
        [_ReleaseProduct.moneyIntoBtn setTitle:strListInvestCategory forState:UIControlStateNormal];
        
    }
    
}
#pragma mark - private methods

- (void) LeftSendSubscribe
{
    //[self hideKeyBoard];
    if (_ReleaseProduct.nameField.text.length == 0 || [_ReleaseProduct.nameField.text isEqualToString:StringProductName])
    {
        [self ShowProgressHUB:@"请填写产品名称"];
        return;
    }
    if (_ReleaseProduct.scaleField.text.length > 0)
    {
        if ([XStringHelper isPureInt:_ReleaseProduct.scaleField.text] == NO)
        {
            [self ShowProgressHUB:@"产品规模请填写数字"];
            return;
        }
        
        NSInteger scale = [_ReleaseProduct.scaleField.text integerValue];
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
    
    if (_ReleaseProduct.deadlineField.text.length > 0)
    {
        if ([XStringHelper isPureInt:_ReleaseProduct.deadlineField.text] == NO)
        {
            [self ShowProgressHUB:@"产品期限请填写数字"];
            return;
        }
        
        NSInteger deadline = [_ReleaseProduct.deadlineField.text integerValue];
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
    
    if (_ReleaseProduct.profitField.text.length > 0)
    {
        if ([XStringHelper isPureFloat:_ReleaseProduct.profitField.text] == NO)
        {
            [self ShowProgressHUB:@"最低收益请填写有效的数字"];
            return;
        }
        
        CGFloat profit = [_ReleaseProduct.profitField.text floatValue];
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


    if (_ReleaseProduct.descTxtView.text.length > 200 )
    {
        [self ShowProgressHUB:@"产品简介不能大于200个字"];
        return;
    }
    
    [self LeftSendSubscribeToServer];
}
- (void) LeftSendSubscribeToServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringAdding;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    CXCategoryModel *category = [_ReleaseProduct.categoryList objectAtIndex:_ReleaseProduct.curCategory];
    CXListInvestCategoryModel *moneyInto = [_ReleaseProduct.moneyIntoList objectAtIndex:_ReleaseProduct.moneyIntoCurCategory];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"name" andStringValue:_ReleaseProduct.nameField.text];
    [parametersUtil appendParameterWithName:@"scale" andStringValue:_ReleaseProduct.scaleField.text];
    [parametersUtil appendParameterWithName:@"deadline" andStringValue:_ReleaseProduct.deadlineField.text];
    [parametersUtil appendParameterWithName:@"profit" andStringValue:_ReleaseProduct.profitField.text];
    [parametersUtil appendParameterWithName:@"category" andIntValue:category.Id];
    [parametersUtil appendParameterWithName:@"moneyInto" andIntValue:moneyInto.Id];
    
    NSString *intro = [NSString stringWithFormat:@"%@:(选填，200字以内)",StringProductBrief];
    if ([_ReleaseProduct.descTxtView.text compare:intro] != 0)
    {
        [parametersUtil appendParameterWithName:@"intro" andStringValue:_ReleaseProduct.descTxtView.text];
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
- (void) RightSendSubscribe
{
    //[self hideKeyBoard];
    if (_ReleaseBenefit.nameField.text.length == 0 || [_ReleaseBenefit.nameField.text isEqualToString:StringProductName])
    {
        [self ShowProgressHUB:@"请填写产品名称"];
        return;
    }
    
    
    if (_ReleaseBenefit.deadlineField.text.length > 0)
    {
        if ([XStringHelper isPureInt:_ReleaseBenefit.deadlineField.text] == NO)
        {
            [self ShowProgressHUB:@"产品期限请填写数字"];
            return;
        }
        
        NSInteger deadline = [_ReleaseBenefit.deadlineField.text integerValue];
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
    
    if (_ReleaseBenefit.moneyField.text.length > 0)
    {
        if ([XStringHelper isPureInt:_ReleaseBenefit.moneyField.text] == NO)
        {
            [self ShowProgressHUB:@"认购金额请填写数字"];
            return;
        }
        
        NSInteger scale = [_ReleaseBenefit.moneyField.text integerValue];
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
    
    if (_ReleaseBenefit.establishDateField.text.length == 0)
    {
        [self ShowProgressHUB:@"请填写成立日期!"];
        return;
    }
    
    if (_ReleaseBenefit.profitField.text.length > 0)
    {
        if ([XStringHelper isPureFloat:_ReleaseBenefit.profitField.text] == NO)
        {
            [self ShowProgressHUB:@"预期收益请填写数字"];
            return;
        }
        
        NSInteger scale = [_ReleaseBenefit.profitField.text integerValue];
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
    if (_ReleaseBenefit.introTxtView.text.length > 200 )
    {
        [self ShowProgressHUB:@"其他说明不能大于200个字"];
        return;
    }
    [self RightSendSubscribeToServer];
}
- (void) RightSendSubscribeToServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringAdding;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"name" andStringValue:_ReleaseBenefit.nameField.text];
    [parametersUtil appendParameterWithName:@"deadline" andStringValue:_ReleaseBenefit.deadlineField.text];
    [parametersUtil appendParameterWithName:@"money" andStringValue:_ReleaseBenefit.moneyField.text];
    [parametersUtil appendParameterWithName:@"establishDate" andStringValue:_ReleaseBenefit.establishDateField.text];
    
    [parametersUtil appendParameterWithName:@"profit" andStringValue:_ReleaseBenefit.profitField.text];
    [parametersUtil appendParameterWithName:@"userName" andStringValue:_ReleaseBenefit.userNameField.text];
    [parametersUtil appendParameterWithName:@"phone" andStringValue:_ReleaseBenefit.phoneField.text];
    if ([_ReleaseBenefit.introTxtView.text compare:StringProductOther] != 0)
    {
        [parametersUtil appendParameterWithName:@"intro" andStringValue:_ReleaseBenefit.introTxtView.text];
    }
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_RELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            XLog(@"subscribe success");
            if ([mainPlate.code integerValue] == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"信托转让发布成功";
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
//                _RefreshTime=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeClcick) userInfo:0 repeats:YES];
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
-(void)viewWillDisappear:(BOOL)animated
{   [super viewWillDisappear:YES];
    //[self.ReleaseProduct resignFirstResponder];
    [self.ReleaseProduct.scaleField resignFirstResponder];
    [self.ReleaseProduct.deadlineField resignFirstResponder];
    [self.ReleaseProduct.profitField resignFirstResponder];
    [self.ReleaseProduct.descTxtView resignFirstResponder];
    
    [self.ReleaseBenefit.deadlineField resignFirstResponder];
    [self.ReleaseBenefit.moneyField resignFirstResponder];
    [self.ReleaseBenefit.establishDateField resignFirstResponder];
    [self.ReleaseBenefit.profitField resignFirstResponder];
    [self.ReleaseBenefit.introTxtView resignFirstResponder];

}

-(void)selectView:(NSInteger)index
{
    if (index==0) {
        _rightBtn.selected=NO;
        _leftBtn.selected=YES;
        [self.ReleaseBenefit endEditing:YES];
        [self textToNil:1];
        [_scrView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (index==1)
    {
        _leftBtn.selected=NO;
        _rightBtn.selected=YES;
        [self.ReleaseProduct endEditing:YES];
        [self textToNil:0];
        [_scrView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    }
}
//#pragma mark - timeClick
//-(void)timeClcick
//{
//    _timeNum++;
//    NSLog(@"%ld",_timeNum);
//    if (_timeNum==1) {
//        _timeNum=0;
//        //[_RefreshTime invalidate];
//        [_RefreshTime setFireDate:[NSDate distantFuture]];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
@end
