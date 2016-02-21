//
//  CXWebViewController.m
//  Link
//
//  Created by chx on 15-2-25.
//  Copyright (c) 2015年 ruisk.com. All rights reserved.
//

#import "CXWebViewController.h"

@interface CXWebViewController ()

@end

@implementation CXWebViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhite;
    self.title = self.titleName;
    
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    frame.size.height -= kViewEndSizeHeight;
    
    _webView =[[UIWebView alloc]initWithFrame:frame];
    _webView.backgroundColor=[UIColor whiteColor];
    //禁止UIWebView移动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    _webView.delegate=self;
    _webView.scalesPageToFit=NO;
    NSURL *url=[NSURL URLWithString:self.url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
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

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.title =self.titleName;
//    self.view.backgroundColor = kControlBgColor;
//    CGRect frame=self.view.frame;
////    frame.size.height-=kViewEndSizeHeight ;
//    _webView = [[UIWebView alloc] initWithFrame:frame];
//    _webView.backgroundColor = kControlBgColor;
//    //禁止UIWebView拖动
//    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
//    //设置UIWebView是按 WebView自适应大小显示,还是按正文内容的大小来显示,YES:表示WebView自适应大小,NO:表示按正文内容的大小来显示
//    [_webView setScalesPageToFit:YES];
//    //_webView.scalesPageToFit =YES;
//    _webView.delegate = self;
//    [self.view addSubview : _webView];
//    
//    [self loadWebPageWithString:self.url];
//}
//
//- (void)loadWebPageWithString:(NSString*)urlString
//{
//    NSURL *url =[NSURL URLWithString:urlString];
//    XLog(@"url:%@",urlString);
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
////    CGFloat height = [webView.scrollView contentSize].height;
////    CGRect newFrame = webView.frame;
////    if (height >self.view.frame.size.height) {
////        newFrame.size.height = height;
////        webView.frame = newFrame;
////    }
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
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
