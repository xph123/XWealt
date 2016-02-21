//
//  CXProductDetailViewController.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductDetailViewController.h"
#import "CXProductOperatorView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "CXSubscribeViewController.h"
#import "CXProductHeaderView.h"
#import "CXLoginViewController.h"
#import "CXViewDataFileViewController.h"
#import "CXScheduleViewController.h"
#import "CXProductDetailWebViewController.h"
@interface CXProductDetailViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation CXProductDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"产品详情";
    self.isAttentioned = 0;
    
    [self initRightBarButton];
    
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    frame.size.height -=  kViewEndSizeHeight + kButtomBarHeight + kSmallMargin;
    //    frame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    // frame.origin.y += kDefaultMargin;
//    frame.size.height -= kButtomBarHeight + kDefaultMargin;
    
    _tableView = [[CXProductDetailTableView alloc] initWithFrame:frame];
    _tableView.navigationController = self.navigationController;
    [self.view addSubview: _tableView];
    
    CXProductOperatorView *operatorView = [[CXProductOperatorView alloc] initWithFrame:CGRectMake(0, frame.size.height, kScreenWidth, kTabBarHeight)];
    [self.view addSubview:operatorView];
    _operatorView = operatorView;
    
    __unsafe_unretained CXProductDetailViewController *weak_self = self;
    operatorView.attentionBlk = ^{
        [weak_self attention];
    };
    operatorView.mailBlk = ^{
        [weak_self sendMail];
    };
    operatorView.tradeBlk = ^{
        [weak_self trade];
    };
    operatorView.scheduleBlk = ^{
        [weak_self schedule];
    };
    
    _tableView.contractBtnBlk = ^{
        [weak_self viewContract];
    };
    _tableView.instructionsBtnBlk = ^{
        [weak_self viewInstructions];
    };
    _tableView.dataBtnBlk = ^{
        [weak_self viewData];
    };
    _tableView.reportBtnBlk = ^{
        [weak_self viewReport];
    };

    
    

    
    [self getProductDetailFromServer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) markHeadView
{
    CGRect frame = CGRectMake(0, 0, kScreenWidth, 250);
    CXProductHeaderView *headerView = [[CXProductHeaderView alloc] initWithFrame:frame andProduct:self.productModel];
    if (headerView.headViewHeight > 250)
    {
        frame.size.height = headerView.headViewHeight;
        headerView.frame = frame;
    }
    self.tableView.tableView.tableHeaderView = headerView;
    
    __unsafe_unretained CXProductDetailViewController *weak_self = self;
    headerView.costBtnBlk = ^{
        [weak_self costBtnClick];
    };
}

#pragma mark - UI mark

- (void) initRightBarButton
{
    UIButton *addTaskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTaskBtn.frame = CGRectMake(0, 0, 30, 30);
    [addTaskBtn setImage:IMAGE(@"share") forState:UIControlStateNormal];
    [addTaskBtn addTarget:self action:@selector(shareToOtherButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:addTaskBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
    
}

#pragma mark - network data

- (void) getProductDetailFromServer
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在获取数据...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"productId" andLongValue:_productId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_DETAIL result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get product detail success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                _productModel = mainPlate.anyModels[0];
                NSString *attention = mainPlate.service;
                _isAttentioned = [attention intValue];
             
                
                [self markHeadView];
                
                [self makeViewData];
                
                if (_isAttentioned == 1)
                {
                    [_operatorView.attentionButton setTitle: @"已关注" forState: UIControlStateNormal];
                }
                else
                {
                    [_operatorView.attentionButton setTitle: @"我要关注" forState: UIControlStateNormal];
                }
                
                if (self.productModel.state == 2)
                {
                    _operatorView.tradeButton.backgroundColor = kLineColor;
                }
                
                [_tableView configData:_sourceData andSectionData:_sectionData andProduct:self.productModel];
            }
        }
        else
        {
            XLog(@"get product detail fail");
        }
    }];
}

- (void) sendAttention
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"productId" andLongValue:_productId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_ATTENTION result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get product detail success");

            if ([mainPlate.code integerValue] == 0)
            {
                self.isAttentioned = 1;
                [self ShowProgressHUB:StringAttentionSuccess];
                
                [_operatorView.attentionButton setTitle: @"已关注" forState: UIControlStateNormal];
            }
        }
        else
        {
            if ([StringProductAttentioned isEqualToString:(NSString*)err])
            {
                self.isAttentioned = 0;
                [self ShowProgressHUB:@"已取消关注"];
                
                [_operatorView.attentionButton setTitle: @"我要关注" forState: UIControlStateNormal];
            }
            else
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = (NSString*)err;
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
    }];
}


#pragma mark - private methods

// 费用
- (void) costBtnClick
{
    NSString *cost = self.productModel.cost;
    
    if ([NSString isEmpty1:cost])
    {
        cost = @"后台未配置费用信息！";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:cost delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alert show];
}

// 合同
- (void) viewContract
{
    if (![self.productModel.contract isEmpty])
    {
        CXViewDataFileViewController *dataController = [[CXViewDataFileViewController alloc] init];
        dataController.url = self.productModel.contract;
        dataController.viewTitle = StringContract;
        dataController.shareName=[NSString stringWithFormat:@"%@ (合同)",self.productModel.title];
        [self.navigationController pushViewController:dataController animated:YES];
    }
}

// 说明书
- (void) viewInstructions
{
    if (![self.productModel.specification isEmpty])
    {
        CXViewDataFileViewController *dataController = [[CXViewDataFileViewController alloc] init];
        dataController.url = self.productModel.specification;
        dataController.viewTitle = StringSpecification;
        dataController.shareName=[NSString stringWithFormat:@"%@ (说明书)",self.productModel.title];
        [self.navigationController pushViewController:dataController animated:YES];
    }
}

// 基础材料
- (void) viewData
{
    if (![self.productModel.material isEmpty])
    {
        CXViewDataFileViewController *dataController = [[CXViewDataFileViewController alloc] init];
        dataController.url = self.productModel.material;
        dataController.viewTitle = StringMaterial;
        dataController.shareName=[NSString stringWithFormat:@"%@ (基础材料)",self.productModel.title];
        [self.navigationController pushViewController:dataController animated:YES];

    }
}

// 尽调报告
- (void) viewReport
{
    if (![self.productModel.survey isEmpty])
    {
        CXViewDataFileViewController *dataController = [[CXViewDataFileViewController alloc] init];
        dataController.url = self.productModel.survey;
        dataController.viewTitle = StringSurvey;
        dataController.shareName=[NSString stringWithFormat:@"%@ (尽调报告)",self.productModel.title];
        [self.navigationController pushViewController:dataController animated:YES];
    }
}

// 我要关注
- (void) attention
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }

    [self sendAttention];
}

// 转发邮件
- (void) sendMail
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    UIAlertView *mailView=[[UIAlertView alloc]initWithTitle:@"转发邮件" message:@"请填写收件人:" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
    [mailView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField * mailText = [mailView textFieldAtIndex:0];
    mailText.keyboardType = UIKeyboardTypeNumberPad;
    mailText.placeholder=@"请输入邮箱地址";
//    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//    if (!mailClass) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"
//                                                            message:nil
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"确定", nil];
//        alertView.tag = 101;
//        [alertView show];
//        return;
//    }
//    if (![mailClass canSendMail]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您没有设置邮件账户，请到邮件中设置！"
//                                                            message:nil
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"确定", nil];
//        alertView.tag = 102;
//        [alertView show];
//        return;
//    }
//    
//    [self displayMailPicker];

}

- (NSString*) markMailBody
{
    NSString *account = [self makeViewAccount];
    NSString *strScole = [self makeViewScole];

    NSString *html1 = @"<html>"
    "<head>"
    "<meta charset=\"utf-8\">"
    "<meta content=\"yes\" name=\"apple-mobile-web-app-capable\" />"
    "<meta content=\"yes\" name=\"apple-touch-fullscreen\" />"
    "<meta content=\"telephone=no,email=no\" name=\"format-detection\" />"
    "<meta content=\"width=device-width, initial-scale=1, user-scalable=0\" name=\"viewport\">"
//    "<link href=\"http://www.gsycf.com/wealth/console/css/bootstrap.min.css\" rel=\"stylesheet\" type=\"text/css\" />"
//    "<link href=\"http://www.gsycf.com/wealth/console/css/bootstrap-responsive.min.css\" rel=\"stylesheet\" type=\"text/css\" />"
//    "<link href=\"http://www.gsycf.com/wealth/console/css/mystyleproduct.css\" rel=\"stylesheet\" type=\"text/css\" />"
//    "<link href=\"http://www.gsycf.com/wealth/console/css/cssreset.css\" rel=\"stylesheet\" type=\"text/css\" />"
    
    "<title>产品详情</title>"
    "</head>"
    "<style type=\"text/css\">"
    
    "</style>"
    "<body class=\"container-fluid\" >"
    "<style type=\"text/css\">"
    ".tdcommon{"
    "    padding-top:10px;"
    "    text-align:center;"
    "    padding-bottom:10px;"
    "    font-size:15px;"
    "    background-color:#FFCC99;"
    "width:23%;"
    "}"
    ".tdcontent{"
    "    padding-top:10px;"
    "    padding-left:5px;"
    "    padding-bottom:10px;"
    "    font-size:13px;"
    "width:73%;"
    "}"
    "table{"
    "width:100%;"
    "}"
    "</style>";
    
    NSString *html2 = @"</body>"
    "</html>";
    
    NSString *simply = @"";
    NSString *detail = @"";
    // 阳光私募
    if (_productModel.category == 5)
    {
        simply = [NSString stringWithFormat: @
                          "<div id=\"divf\" class=\"container-fluid\">"
                          "<div id=\"div2line\" class=\"container-fluid\"></div>"
                          "<div id=\"menu\">"
                          "<p><label>产品简介</label></p>"
                          "<table border=\"1px\" cellspacing=\"1\" id=\"table2\">"
                          "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                          "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                          "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                          "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>",
                          StringProductName, _productModel.title, StringProductMoneyInto, _productModel.moneyInto, StringProductScale, strScole, StringProductDeadline, _productModel.lockArea
                          ];

        if (![_productModel.financing isEmpty])
        {
            simply = [NSString stringWithFormat: @"%@ <tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>", simply, StringProductFinancing, _productModel.financing];
        }
        if (![_productModel.organization isEmpty])
        {
            simply = [NSString stringWithFormat: @"%@ <tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>", simply, StringProductOrganization, _productModel.organization];
        }
        
        NSString *cost = [self makeViewCost];
        
        if (![cost isEmpty])
        {
            simply = [NSString stringWithFormat: @"%@ <tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>", simply, StringProductCost, cost];
        }
        
        if (![_productModel.reward isEmpty])
        {
            simply = [NSString stringWithFormat: @"%@ <tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>", simply, StringProductRemuneration, _productModel.reward];
        }
        
        simply = [NSString stringWithFormat: @"%@ <tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>", simply, StringProductAccount, account];
        
        simply = [NSString stringWithFormat: @"%@"
                  "</table>"
                  "</div>",
                  simply
                  ];

        detail = [NSString stringWithFormat: @
                  "<div id=\"divf\" class=\"container-fluid\">"
                  "<div id=\"div2line\" class=\"container-fluid\"></div>"
                  "<div id=\"menu\">"
                  "<p><label>扩展信息</label></p>"
                  "<table border=\"1px\" cellspacing=\"1\" id=\"table2\">"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "</table>"
                  "</div>",
                  StringProductRegion, _productModel.region,
                  StringProductOrganizationNote, [self makeViewNote],
                  StringProductBrightSpot, _productModel.brightSpot
                  ];
    }
    else
    {
        // 信托是产品期限，私募是锁定区
        NSString *deadline = [self makeViewDeadline];
        NSString *profit = [self makeViewProfit];
        
        simply = [NSString stringWithFormat: @
                  "<div id=\"divf\" class=\"container-fluid\">"
                  "<div id=\"div2line\" class=\"container-fluid\"></div>"
                  "<div id=\"menu\">"
                  "<p><label>产品简介</label></p>"
                  "<table border=\"1px\" cellspacing=\"1\" id=\"table2\">"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "</table>"
                  "</div>",
                  StringProductName, _productModel.title,
                  StringProductMoneyInto, _productModel.moneyInto,
                  StringProductScale, strScole,
                  StringProductDeadline, deadline,
                  StringProductProfit, profit,
                  StringProductAssign, _productModel.assign,
                  StringProductProportion, _productModel.proportion,
                  StringProductAccount, account
                  ];
        
        detail = [NSString stringWithFormat: @
                  "<div id=\"divf\" class=\"container-fluid\">"
                  "<div id=\"div2line\" class=\"container-fluid\"></div>"
                  "<div id=\"menu\">"
                  "<p><label>%@</label></p>"
                  "<table border=\"1px\" cellspacing=\"1\" id=\"table2\">"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "<tr><td class=\"tdcommon\">%@</td><td class=\"tdcontent\">%@</td></tr>"
                  "</table>"
                  "</div>",
                  StringProductExtern,
                  StringProductSrouce, _productModel.source,
                  StringProductRiskControl, _productModel.riskControl,
                  StringProductIntro, _productModel.intro
                  ];
    }
    
    NSString *file = [self makeEmailFile];
    
    NSString *body = [NSString stringWithFormat:@"%@%@%@%@%@", html1, simply, detail, file, html2];

    return body;
}

- (NSString*) makeEmailFile
{
    NSString *contract = @"";
    if (_productModel.contract.length > 0)
    {
        contract = [NSString stringWithFormat: @"<td><a href=\"%@\">合同</a></td>",
        _productModel.contract ];
    }
    else
    {
        contract = @"<td>合同(尚无)</td>";
    }
    
    NSString *specification = @"";
    if (_productModel.specification.length > 0)
    {
        specification = [NSString stringWithFormat: @"<td><a href=\"%@\">说明书</a></td>",
                    _productModel.specification ];
    }
    else
    {
        specification = @"<td>说明书(尚无)</td>";
    }
    
    NSString *material = @"";
    if (_productModel.material.length > 0)
    {
        material = [NSString stringWithFormat: @"<td><a href=\"%@\">基础材料</a></td>",
                    _productModel.material ];
    }
    else
    {
        material = @"<td>基础材料(尚无)</td>";
    }
    
    NSString *survey = @"";
    if (_productModel.survey.length > 0)
    {
        survey = [NSString stringWithFormat: @"<td><a href=\"%@\">尽调报告</a></td>",
                    _productModel.survey ];
    }
    else
    {
        survey = @"<td>尽调报告(尚无)</td>";
    }
    
    NSString *file = [NSString stringWithFormat:@
                      "<div id=\"div2line\" class=\"container-fluid\"></div>"
                      "<div id=\"menu\">"
                      "<p><label>详细资料</label></p>"
                      "<table id=\"tableziliao\" border=\"1px\" cellspacing=\"1\" class=\"container\">"
                      "<tr>"
                      "%@"
                      "%@"
                      "</tr>"
                      "<tr>"
                      "%@"
                      "%@"
                      "</tr>"
                      "</table>"
                      "</div>",
                      contract, specification, material, survey];
    
    return file;
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: self.productModel.title];
    //添加收件人
    NSString *mail = kAppDelegate.currentUserModel.userName;
  
    
    NSArray *toRecipients = [NSArray arrayWithObject: mail];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailPicker setCcRecipients:ccRecipients];
    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailPicker setBccRecipients:bccRecipients];
    
    // 添加一张图片
    //    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    //    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    //    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件
    //    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
    //    NSData *pdf = [NSData dataWithContentsOfFile:file];
    //    [mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
    
    
//  NSString *emailBody = [NSString stringWithFormat:@"%@ <br> <font color='blue'>项目：</font> ”%@“<br> <font color='green'>已完成</font>", self.productModel.title, self.taskModel.content];
//    NSString *emailBody = [NSString stringWithFormat:@"%@ <br> <br> <a href=\"%@\" >%@</a> <br> <a href=\"%@\" >%@</a><br> <a href=\"%@\" >%@</a><br> <a href=\"%@\" >%@</a>", self.productModel.title, self.productModel.contract, @"合同", self.productModel.specification, @"说明书", self.productModel.material, @"基础材料",self.productModel.survey, @"尽调报告"];
    NSString *emailBody = [self markMailBody];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    //    [self presentModalViewController: mailPicker animated:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

// 我要预约
- (void) trade
{
    if (self.productModel.state == 2)
    {
        return;
    }
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    CXSubscribeViewController * subscribeController=[[CXSubscribeViewController alloc] init];
    subscribeController.productId = self.productId;
    subscribeController.productName = self.productModel.title;
    [ self.navigationController pushViewController:subscribeController animated:YES];
}
// 产品轨迹
- (void) schedule
{

    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    CXScheduleViewController * scheduleViewController=[[CXScheduleViewController alloc] init];
    scheduleViewController.productId = self.productId;
    [ self.navigationController pushViewController:scheduleViewController animated:YES];
}

- (CXTitleValueModel *) makeTitleValueModel:(NSString*)title andValue:(NSString*)value
{
    CXTitleValueModel *model = [[CXTitleValueModel alloc] init];
    model.title = title;
    model.value = value;
    model.imageValue=@"";
    return model;
}
- (CXTitleValueModel *) makeTitleValueAndImagleModel:(NSString*)title andValue:(NSString*)value andImage:(NSString *)image
{
    CXTitleValueModel *model = [[CXTitleValueModel alloc] init];
    model.title = title;
    model.value = value;
    model.imageValue=image;
    return model;
}
// 显示用的期限
- (NSString*) makeViewDeadline
{
    NSString *deadline = @"";
    if (_productModel.fullDeadline!=nil&&![_productModel.fullDeadline isEqualToString:@""]) {
        deadline = _productModel.fullDeadline;
    }
    else
    {
        if (_productModel.deadline.length > 0)
        {
            int deadlineInt = [_productModel.deadline intValue];
            
            if (deadlineInt >= 12)
            {
                if (deadlineInt % 12 == 0)
                {
                    deadline = [NSString stringWithFormat:@"%d年", deadlineInt / 12];
                }
                else
                {
                    deadline = [NSString stringWithFormat:@"%d个月", deadlineInt];
                    //deadline = [NSString stringWithFormat:@"%ld年%ld月", deadlineInt / 12, deadlineInt % 12];
                }
            }
            else
            {
                deadline = [NSString stringWithFormat:@"%d个月", deadlineInt];
            }
        }

    }
    
    return deadline;
}

// 显示用的规模
- (NSString *)makeViewScole
{
    NSString *strScole = @"";
    
    if (_productModel.scale >= 10000)
    {
        int remain = _productModel.scale % 10000;
        if (remain == 0)
        {
            int scale = _productModel.scale / 10000;
            strScole = [NSString stringWithFormat:@"%d亿", scale];
        }
        else
        {
            CGFloat dScale = _productModel.scale / 10000.0;
            int remain2 = remain % 1000;
            if (remain2 == 0)
            {
                strScole = [NSString stringWithFormat:@"%.1f亿", dScale];
            }
            else
            {
                strScole = [NSString stringWithFormat:@"%.2f亿", dScale];
            }
        }
    }
    else
    {
        strScole = [NSString stringWithFormat:@"%@万", [@(_productModel.scale) stringValue] ];
    }

    return strScole;
}

// 显示用的费用
- (NSString *) makeViewCost
{
    NSString *cost = @"";
    
    if (_productModel.buyFee > 0)
    {
        cost = [NSString stringWithFormat:@"认购费：%.1f%@\n", _productModel.buyFee, @"%"];
    }
    
    if (_productModel.mgrFee > 0)
    {
        cost = [NSString stringWithFormat:@"%@管理费：%.1f%@\n", cost, _productModel.mgrFee, @"%"];
    }
    
    if (_productModel.trustteeFee > 0)
    {
        cost = [NSString stringWithFormat:@"%@境内外银行托管费：%.1f%@\n", cost, _productModel.trustteeFee, @"%"];
    }
    
    if (_productModel.qdiiFee > 0)
    {
        cost = [NSString stringWithFormat:@"%@QDII专户费：%.1f%@\n", cost, _productModel.qdiiFee, @"%"];
    }
    
    return cost;
}

- (NSString *) makeViewAccount
{
    NSString *account;
    if (![_productModel.account isEmpty])
    {
        account = [NSString stringWithFormat:@"开户行：%@\n户名：%@\n账号：%@", _productModel.accountBank, _productModel.accountName, _productModel.account];
    }
    else
    {
        account = @"账户未出";
    }
    
    return account;
}

- (NSString *) makeViewProfit
{
    NSString *profit;
    if (![_productModel.earningNote isEmpty])
    {
        profit = _productModel.earningNote;
    }
    else
    {
        profit = [NSString stringWithFormat:@"%@%@", _productModel.profit, @"%"];
    }
    
    return profit;
}

- (NSString *) makeViewNote
{
    NSString *note = @"";
    if (![_productModel.finacingNote isEmpty])
    {
        note = _productModel.finacingNote;
    }
    else  if(![_productModel.organizationNote isEmpty])
    {
        note = _productModel.organizationNote;
    }
    
    return note;
}


- (void) makeViewData
{
    NSString *account = [self makeViewAccount];
    NSString *strScole = [self makeViewScole];
    
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    NSArray *array2;
    // 阳光私募
    if (_productModel.category == 5)
    {
        [array1 addObject:[self makeTitleValueModel:StringProductName andValue:_productModel.title]];
        [array1 addObject:[self makeTitleValueModel:StringProductMoneyInto andValue:_productModel.moneyInto]];
        [array1 addObject:[self makeTitleValueModel:StringProductScale andValue:strScole]];
        [array1 addObject:[self makeTitleValueModel:StringProductDeadline andValue:_productModel.lockArea]];
        if (![_productModel.financing isEmpty])
        {
            [array1 addObject:[self makeTitleValueModel:StringProductFinancing andValue:_productModel.financing]];
        }
        if (![_productModel.organization isEmpty])
        {
            [array1 addObject:[self makeTitleValueModel:StringProductOrganization andValue:_productModel.organization]];
        }
        
        NSString *cost = [self makeViewCost];
        
        if (![cost isEmpty])
        {
            [array1 addObject:[self makeTitleValueModel:StringProductCost andValue:cost]];
        }
        
        if (![_productModel.reward isEmpty])
        {
            [array1 addObject:[self makeTitleValueModel:StringProductRemuneration andValue:_productModel.reward]];
        }
        
        [array1 addObject:[self makeTitleValueModel:StringProductAccount andValue:account]];
        
        array2 = [[NSArray alloc] initWithObjects:
                  [self makeTitleValueModel:StringProductRegion andValue:_productModel.region],
                  [self makeTitleValueModel:StringProductOrganizationNote andValue:[self makeViewNote]],
                  [self makeTitleValueModel:StringProductBrightSpot andValue:_productModel.brightSpot],
                  nil];
    }
    else
    {
        // 信托是产品期限，私募是锁定区
        NSString *deadline = [self makeViewDeadline];
        NSString *profit = [self makeViewProfit];
        
        [array1 addObject:[self makeTitleValueModel:StringProductName andValue:_productModel.title]];
        [array1 addObject:[self makeTitleValueModel:StringProductMoneyInto andValue:_productModel.moneyInto]];
        [array1 addObject:[self makeTitleValueModel:StringProductScale andValue:strScole]];
        [array1 addObject:[self makeTitleValueModel:StringProductDeadline andValue:deadline]];
        [array1 addObject:[self makeTitleValueModel:StringProductProfit andValue:profit]];
        [array1 addObject:[self makeTitleValueModel:StringProductAssign andValue:_productModel.assign]];
        [array1 addObject:[self makeTitleValueModel:StringProductProportion andValue:_productModel.proportion]];
        [array1 addObject:[self makeTitleValueModel:StringProductAccount andValue:account]];
        
        array2 = [[NSArray alloc] initWithObjects:
                           [self makeTitleValueModel:StringProductSrouce andValue:_productModel.source],
                           [self makeTitleValueModel:StringProductRiskControl andValue:_productModel.riskControl],
                           [self makeTitleValueAndImagleModel:StringProductIntro andValue:_productModel.intro andImage:_productModel.introPic],
                           [self makeTitleValueAndImagleModel:StringProductTransContr andValue:@"" andImage:_productModel.transContr],
                           nil];
    }
    
    _sourceData = [[NSArray alloc] initWithObjects:
                   array1,
                   array2,
                   nil];

    _sectionData = [[NSArray alloc] initWithObjects:
                   StringProductBrief,
                   StringProductExtern,
                    StringProductDownload,
                   nil];
}

- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;
    
    imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%ld", kBaseURLString,@"/wealth/product/share?pId=", self.productId];

    NSString *strTitle = StringAppName;
    id<ISSContent> publishContent =nil;

        publishContent = [ShareSDK content:self.productModel.title
                            defaultContent:self.productModel.title
                                     image:imagePath
                                     title:strTitle
                                       url:url
                               description:nil
                                 mediaType:SSPublishContentMediaTypeNews];
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.productModel.title]];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.productModel.title title:strWXTitle url:url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url:url site:nil fromUrl:url comment:nil summary:self.productModel.title image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
    NSArray *shareList;
    if (![QQApiInterface isQQInstalled]) {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType:ShareTypeSMS,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType: ShareTypeWeixiSession, ShareTypeWeixiTimeline,  nil];
        }
    }
    else {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType:ShareTypeQQSpace, ShareTypeQQ,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType: ShareTypeQQSpace, ShareTypeWeixiSession, ShareTypeWeixiTimeline, ShareTypeQQ,  nil];
        }
    }
    
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    XLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    XLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                                    hud.mode = MBProgressHUDModeText;
                                    hud.labelText = [NSString stringWithFormat:@"分享失败:%@", [error errorDescription]];
                                    hud.removeFromSuperViewOnHide = YES;
                                    [hud hide:YES afterDelay:1];
                                    
                                }
                            }];
    
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"您已取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"您已成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"邮件已发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.yOffset = -50;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
@end
