//
//  CXMyAccountViewController.m
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyAccountViewController.h"
#import "CXmyAccountItemView.h"
#import "CXXtbBillViewController.h"
#import "CXXtbInvestViewController.h"
#import "CXWebViewController.h"

#define ITEMVIEW_HEIGHT     (20 + kLabelHeight)

@interface CXMyAccountViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *accountView;
@property (nonatomic, strong) CXmyAccountItemView *totalFundView;// 总资产
@property (nonatomic, strong) CXmyAccountItemView *availableFundView;// 可用金额
@property (nonatomic, strong) CXmyAccountItemView *freezeFundView;// 冻结金额
@property (nonatomic, strong) CXmyAccountItemView *dueFundView;// 待收资产
//@property (nonatomic, strong) CXProductItemView *addIncomeView;// 累计收益
@property (nonatomic,strong) UILabel *addIncomeLabel; // 累计收益

@end

@implementation CXMyAccountViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的信托宝";
    self.view.backgroundColor = kColorWhite;
    
    [self initSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadUserFundFromServer];
}


- (void) initSubviews
{
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    frame.size.height -= kViewEndSizeHeight;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.backgroundColor = kColorWhite;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.bounces=NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    CGFloat buttonWidth = (kScreenWidth - 2) / 3;
    CGFloat buttonHeight = buttonWidth *3 / 4;
    
    CGRect accountFrame = frame;
    accountFrame.origin.y = 0;
    accountFrame.size.height = 140 + 2 * ITEMVIEW_HEIGHT + buttonHeight * 3 + 6 * kDefaultMargin;
    self.accountView = [[UIView alloc] initWithFrame:accountFrame];
    self.accountView.backgroundColor = kColorWhite;
    [scrollView addSubview:self.accountView];
    scrollView.contentSize = accountFrame.size;
    
    UILabel *addIncomeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, kLabelHeight)];
    addIncomeTitleLabel.font = kMiddleTextFont;
    addIncomeTitleLabel.textColor = kxintuoGrayTextColor;
    addIncomeTitleLabel.text = @"累计收益（元）";
    addIncomeTitleLabel.numberOfLines = 1;
    addIncomeTitleLabel.textAlignment = NSTextAlignmentCenter;
    addIncomeTitleLabel.backgroundColor = [UIColor clearColor];
    [self.accountView addSubview:addIncomeTitleLabel];
    
    UILabel *addIncomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-8, 20 + kLabelHeight, kScreenWidth, 60)];
    addIncomeLabel.font = [UIFont systemFontOfSize:46.0];
    addIncomeLabel.textColor = kxintuoOrangeColor;
    addIncomeLabel.text = @"0.00";
    addIncomeLabel.numberOfLines = 1;
    addIncomeLabel.textAlignment = NSTextAlignmentCenter;
    addIncomeLabel.backgroundColor = [UIColor clearColor];
    [self.accountView addSubview:addIncomeLabel];
    self.addIncomeLabel = addIncomeLabel;
    
    CGFloat lineH1Y = 140;
    UIView *lineH1 = [[UIView alloc] initWithFrame:CGRectMake(0, lineH1Y, kScreenWidth, 0.5)];
    lineH1.backgroundColor = kLineColor;
    [self.accountView addSubview:lineH1];
    
    CGFloat bgHeight = kDefaultMargin*4 + 2 * ITEMVIEW_HEIGHT;
    CGRect bgFrame = CGRectMake(0, lineH1Y, kScreenWidth, bgHeight);
    UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
    bgView.backgroundColor = UIColorFromRGB(0xf5f5f9);
    [self.accountView addSubview:bgView];
    
    
    CGRect totalFrame = CGRectMake(0, lineH1Y + kDefaultMargin*2, kScreenWidth / 2, ITEMVIEW_HEIGHT);
    _totalFundView = [[CXmyAccountItemView alloc] initWithFrame:totalFrame];
    _totalFundView.titleLabel.text = @"总资产（元）";
    _totalFundView.valueLabel.text = @"0";
    [self.accountView addSubview:_totalFundView];
    
    CGRect line1Frame = CGRectMake(kScreenWidth / 2, lineH1Y + kDefaultMargin*3, 1, ITEMVIEW_HEIGHT - 2 * kDefaultMargin);
    UIView *line1 = [[UIView alloc] initWithFrame:line1Frame];
    line1.backgroundColor = kLineColor;
    [self.accountView addSubview: line1];
    
    CGRect availableFrame = CGRectMake(kScreenWidth / 2, lineH1Y + kDefaultMargin*2, kScreenWidth / 2, ITEMVIEW_HEIGHT);
    _availableFundView = [[CXmyAccountItemView alloc] initWithFrame:availableFrame];
    _availableFundView.titleLabel.text = @"可用金额（元）";
    _availableFundView.valueLabel.text = @"0";
    [self.accountView addSubview:_availableFundView];
    
    CGRect freezeFrame = CGRectMake(0, lineH1Y + kDefaultMargin*3 + ITEMVIEW_HEIGHT, kScreenWidth / 2, ITEMVIEW_HEIGHT);
    _freezeFundView = [[CXmyAccountItemView alloc] initWithFrame:freezeFrame];
    _freezeFundView.titleLabel.text = @"冻结金额（元）";
    _freezeFundView.valueLabel.text = @"0";
    [self.accountView addSubview:_freezeFundView];
    
    CGRect line2Frame = CGRectMake(kScreenWidth / 2, lineH1Y + kDefaultMargin*4 + ITEMVIEW_HEIGHT, 1, ITEMVIEW_HEIGHT - 2 * kDefaultMargin);
    UIView *line2 = [[UIView alloc] initWithFrame:line2Frame];
    line2.backgroundColor = kLineColor;
    [self.accountView addSubview: line2];
    
    CGRect dueFrame = CGRectMake(kScreenWidth / 2, lineH1Y + kDefaultMargin*3 + ITEMVIEW_HEIGHT, kScreenWidth / 2, ITEMVIEW_HEIGHT);
    _dueFundView = [[CXmyAccountItemView alloc] initWithFrame:dueFrame];
    _dueFundView.titleLabel.text = @"待收资产（元）";
    _dueFundView.valueLabel.text = @"0";
    [self.accountView addSubview:_dueFundView];
    
    CGFloat lineH2Y = lineH1Y + bgHeight;
    UIView *lineH2 = [[UIView alloc] initWithFrame:CGRectMake(0, lineH2Y, kScreenWidth, 0.5)];
    lineH2.backgroundColor = kLineColor;
    [self.accountView addSubview:lineH2];
    
    CGFloat btnViewY = lineH2Y+1;
    [self initBtnViews:btnViewY];
}

- (void) initBtnViews:(CGFloat)baseY
{
    CGFloat buttonWidth = (kScreenWidth - 2) / 3;
    CGFloat buttonHeight = buttonWidth *3 / 4;
    CGFloat y = baseY;
    
    // 充值
    CGRect addFundFrame = CGRectMake(0, y, buttonWidth, buttonHeight);
    UIButton *addFundBtn = [self createBtn:addFundFrame andImage:@"topup" andString:@"充值"];
    [addFundBtn addTarget:self action:@selector(addFundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    // 提现
    CGRect getFundFrame = CGRectMake(1 + buttonWidth, y, buttonWidth, buttonHeight);
    UIButton *getFundBtn = [self createBtn:getFundFrame andImage:@"cash" andString:@"提现"];
    [getFundBtn addTarget:self action:@selector(getFundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 资金流水
    CGRect billFrame = CGRectMake(2 + buttonWidth * 2, y, buttonWidth, buttonHeight);
    UIButton *billBtn = [self createBtn:billFrame andImage:@"bill" andString:@"资金流水"];
    [billBtn addTarget:self action:@selector(billBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat lineY = baseY + buttonHeight + 1;
    UIView *lineH1 = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, kScreenWidth, 0.5)];
    lineH1.backgroundColor = kLineColor;
    [self.accountView addSubview:lineH1];
    
    // 交易记录
    CGRect investFrame = CGRectMake(0, lineY + 1, buttonWidth, buttonHeight);
    UIButton *investBtn = [self createBtn:investFrame andImage:@"invest" andString:@"交易记录"];
    [investBtn addTarget:self action:@selector(investBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 自动投标
    CGRect autoInvestFrame = CGRectMake(1 + buttonWidth, lineY + 1, buttonWidth, buttonHeight);
    UIButton *autoInvestBtn = [self createBtn:autoInvestFrame andImage:@"autoInvest" andString:@"自动投标"];
    [autoInvestBtn addTarget:self action:@selector(autoInvestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 资金托管账号
    CGRect cashAccountFrame = CGRectMake(2 + buttonWidth*2, lineY + 1, buttonWidth, buttonHeight);
    UIButton *cashAccountBtn = [self createBtn:cashAccountFrame andImage:@"cashAccount" andString:@"资金托管账号"];
    [cashAccountBtn addTarget:self action:@selector(cashAccountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat line2Y = baseY + (buttonHeight + 1)*2;
    UIView *lineH2 = [[UIView alloc] initWithFrame:CGRectMake(0, line2Y, kScreenWidth, 0.5)];
    lineH2.backgroundColor = kLineColor;
    [self.accountView addSubview:lineH2];
    
    // 重置支付密码
    CGRect resetXtbPwdFrame = CGRectMake(0, line2Y+1, buttonWidth, buttonHeight);
    UIButton *resetXtbPwdBtn = [self createBtn:resetXtbPwdFrame andImage:@"resetXtbPwd" andString:@"重置支付密码"];
    [resetXtbPwdBtn addTarget:self action:@selector(resetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 常见问题
    CGRect xtbFaqFrame = CGRectMake(1 + buttonWidth, line2Y+1, buttonWidth, buttonHeight);
    UIButton *xtbFaqBtn = [self createBtn:xtbFaqFrame andImage:@"xtbFaq" andString:@"常见问题"];
    [xtbFaqBtn addTarget:self action:@selector(faqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect line1Frame = CGRectMake(buttonWidth + 1, y, 0.5, buttonHeight*3+2);
    UIView *line1 = [[UIView alloc] initWithFrame:line1Frame];
    line1.backgroundColor = kLineColor;
    [self.accountView addSubview: line1];
    
    CGRect line2Frame = CGRectMake(buttonWidth*2 + 2, y, 0.5, buttonHeight*3+2);
    UIView *line2 = [[UIView alloc] initWithFrame:line2Frame];
    line2.backgroundColor = kLineColor;
    [self.accountView addSubview: line2];
    
    CGFloat line3Y = baseY + (buttonHeight + 1)*3;
    UIView *lineH3 = [[UIView alloc] initWithFrame:CGRectMake(0, line3Y, kScreenWidth, 0.5)];
    lineH3.backgroundColor = kLineColor;
    [self.accountView addSubview:lineH3];
}

- (UIButton*)createBtn:(CGRect)frame andImage:(NSString*)imageName andString:(NSString*)title
{
    CGRect btnFrame = frame;
    btnFrame.origin.y += 10;
    btnFrame.size.height -= kLabelHeight + 10;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnFrame;
    btn.layer.masksToBounds = YES;
    //    btn.layer.cornerRadius = kRadius;
    //    btn.layer.borderWidth = 1;
    //    btn.layer.borderColor = kLineColor.CGColor;
    [btn setImage:IMAGE(imageName) forState:UIControlStateNormal];
    [self.accountView addSubview:btn];
    
    CGRect titleFrame = frame;
    titleFrame.origin.y += titleFrame.size.height - kLabelHeight;
    titleFrame.size.height = kLabelHeight;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.font = kSmallTextFont;
    titleLabel.textColor = kTextColor;
    titleLabel.numberOfLines = 1;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.accountView addSubview:titleLabel];
    
    return btn;
}

#pragma mark - network data

- (void) loadUserFundFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_XINTUOBAO_FINDUSERFUND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadUserFundFromServer success");
            if ([mainPlate.anyModels count] > 0)
            {
                CXXtbAccountModel *model = [mainPlate.anyModels objectAtIndex:0];
                _accountModel = model;
                
                _totalFundView.valueLabel.text = [self changeRMBformat:model.totalFund];
                _availableFundView.valueLabel.text = [self changeRMBformat:model.availableFund];
                _freezeFundView.valueLabel.text = [self changeRMBformat: model.freezeFund];
                _dueFundView.valueLabel.text = [self changeRMBformat: model.dueFund];
                _addIncomeLabel.text = [self changeRMBformat:model.addIncome];
            }
        }
        else
        {
            XLog(@"loadUserFundFromServer fail");
        }
    }];
}

- (NSString *) changeRMBformat:(CGFloat )value
{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *str = [currencyFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
    
    if (str.length > 1)
    {
        str = [str substringFromIndex:1];
    }
    
    return str;
}


#pragma mark - private function

- (void) faqBtnClick:(UIButton*)btn
{
    // 常见问题
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.hidesBottomBarWhenPushed = YES;
    NSString *aboutUrl=@"/util/commonQuestion.action";
    NSString *problemUrl=[kBaseURLString stringByAppendingString:aboutUrl];
    webControl.url = problemUrl;
    webControl.titleName=@"常见问题";
    [self.navigationController pushViewController:webControl animated:YES];
}

- (void) resetPwdBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.updatePayPwd;
    webControl.titleName=@"重置支付密码";
    [self.navigationController pushViewController:webControl animated:YES];
}

- (void) cashAccountBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.fundCustodyUrl;
    webControl.titleName=@"资金托管账户";
    [self.navigationController pushViewController:webControl animated:YES];
}

- (void) autoInvestBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.autoBidUrl;
    webControl.titleName=@"自动投标";
    [self.navigationController pushViewController:webControl animated:YES];
}

- (void) billBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.gsbInvestStream;
    webControl.titleName=@"资金流水";
    [self.navigationController pushViewController:webControl animated:YES];
    
    //    CXXtbBillViewController *billControl=[[CXXtbBillViewController alloc]init];
    //    [self.navigationController pushViewController:billControl animated:YES];
}


- (void) investBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.gsbInvestRecord;
    webControl.titleName=@"交易记录";
    [self.navigationController pushViewController:webControl animated:YES];}

- (void) addFundBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.addFundUrl;
    webControl.titleName=@"充值";
    [self.navigationController pushViewController:webControl animated:YES];
}

- (void) getFundBtnClick:(UIButton*)btn
{
    CXWebViewController *webControl=[[CXWebViewController alloc]init];
    webControl.url = _accountModel.getFundUrl;
    webControl.titleName=@"提现";
    [self.navigationController pushViewController:webControl animated:YES];
}


@end
