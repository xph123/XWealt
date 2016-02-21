//
//  CXAboutViewController.m
//  XWealth
//
//  Created by chx on 15-3-22.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXAboutViewController.h"
#import "CXServiceProvisionViewController.h"

@interface CXAboutViewController ()

@end

@implementation CXAboutViewController
-(instancetype)init
{
    if (self) {
     self.name=@"";
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhite;
    self.title = StringAboutUs;
    
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    frame.size.height -= kViewEndSizeHeight;
    
    _webView =[[UIWebView alloc]initWithFrame:frame];
    _webView.backgroundColor=[UIColor whiteColor];
    //禁止UIWebView移动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    _webView.delegate=self;
    _webView.scalesPageToFit=NO;
    NSURL *url=[NSURL URLWithString:_connectionUrl];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    if (![self.name isEqualToString:@""]) {
         self.title = _name;
    }
}
//开始
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
//结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
//失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = kColorWhite;
//    self.title = StringAboutUs;
//
//    CGFloat iconWidth = 114;
//    CGFloat iconHeight = 114;
//    CGFloat x = (kScreenWidth - iconWidth) / 2;
//    CGFloat y = 36 + kViewBeginOriginY;
//    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, iconWidth, iconHeight)];
//    logoImg.image = IMAGE(@"icon-120");
//    [self.view addSubview:logoImg];
//    
//    CGFloat nameY = y + iconHeight + kFunctionBarHeight;
//    
//    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, nameY, kScreenWidth - 2 * kDefaultMargin, kFunctionBarHeight)];
//    nameLabel.font = kExtralLargeTextFont;
//    nameLabel.textColor = kTitleTextColor;
//    nameLabel.text =  @"高搜易财富";
//    nameLabel.backgroundColor = kColorClear;
//    nameLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:nameLabel];
//
//    
//    NSMutableAttributedString *signature = [[NSMutableAttributedString alloc] initWithString:StringAdvertising];
//    NSRange rangeName = [StringAdvertising rangeOfString:@"掌富宝"];
//    [signature addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:rangeName];
//
//    CGFloat signatureY = nameY + kFunctionBarHeight;
//    
//    UILabel *signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, signatureY, kScreenWidth - 2 * kDefaultMargin, kFunctionBarHeight)];
//    signatureLabel.font = kLargeTextFont;
//    signatureLabel.textColor = kTextColor;
////    signatureLabel.text =  @"最佳理财哪里找，就选掌富宝！";
//    signatureLabel.attributedText = signature;
//    signatureLabel.backgroundColor = kColorClear;
//    signatureLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:signatureLabel];
//    
//
//    
//    CGFloat allRightY = kScreenHeight - 80 - (!kIsIOS7Dot2Before ? kNavAndStatusBarHeight:0);
//   
//    UILabel *allrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, allRightY, kScreenWidth - 2 * kDefaultMargin, kLabelHeight)];
//    allrightLabel.font = kMiddleTextFont;
//    allrightLabel.textColor = kTextColor;
//    allrightLabel.text =  @"All Right Reserved";
//    allrightLabel.backgroundColor = kColorClear;
//    allrightLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:allrightLabel];
//    
//    CGFloat copyrightY = allRightY - kLabelHeight + 5;
//    UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, copyrightY, kScreenWidth - 2 * kDefaultMargin, kLabelHeight)];
//    copyrightLabel.font = kMiddleTextFont;
//    copyrightLabel.textColor = kTextColor;
//    copyrightLabel.text =  @"Copyright @ 2015 gsycf.com \n";
//    copyrightLabel.backgroundColor = kColorClear;
//    copyrightLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:copyrightLabel];
//
//    CGFloat companyY = copyrightY - kLabelHeight;
//    
//    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, companyY, kScreenWidth - 2 * kDefaultMargin, kFunctionBarHeight)];
//    companyLabel.font = kMiddleTextFont;
//    companyLabel.textColor = kTextColor;
//    companyLabel.text =  @"深圳市高搜易财富投资管理有限公司";
//    companyLabel.backgroundColor = kColorClear;
//    companyLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:companyLabel];
//    
//    
//    CGFloat permitY = companyY - kLabelHeight;
//    
//    UILabel *permitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, permitY, kScreenWidth - 2 * kDefaultMargin, kFunctionBarHeight)];
//    permitLabel.font = kMiddleTextFont;
//    permitLabel.textColor = kMainStyleColor;
////    permitLabel.text =  @"软件许可与服务协议";
//    permitLabel.backgroundColor = kColorClear;
//    permitLabel.textAlignment = NSTextAlignmentCenter;
//    
//    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:StringServiceAndProtocol];
//    NSRange contentRange = {0, [content length]};
//    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//    permitLabel.attributedText = content;
//
//    [self.view addSubview:permitLabel];
//    
//    CGSize size = [StringServiceAndProtocol getSizeWithWidth:kScreenWidth - 2 * kDefaultMargin fontSize:kMiddleTextFontSize];
//    CGRect btnRect = CGRectMake((kScreenWidth - size.width) / 2, permitY, size.width, kFunctionBarHeight);
//    UIButton *dateBtn = [[UIButton alloc] initWithFrame:btnRect];
//    [dateBtn setBackgroundColor:kColorClear];
//    [dateBtn addTarget:self action:@selector(provisionBtnClick) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:dateBtn];
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void) provisionBtnClick
//{
//    CXServiceProvisionViewController *provisionVC = [[CXServiceProvisionViewController alloc] init];
//    [self.navigationController pushViewController:provisionVC animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
