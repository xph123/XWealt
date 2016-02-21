//
//  CXXintuobaoDetailViewController.m
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXintuobaoDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
@interface CXXintuobaoDetailViewController ()

@end

@implementation CXXintuobaoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"信托宝详情";
    
//    [self initRightBarButton];
    
    CGRect frame = self.view.frame;
    frame.size.height -= kViewEndSizeHeight;// + kButtomBarHeight;
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    //禁止UIWebView拖动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    //设置UIWebView是按 WebView自适应大小显示,还是按正文内容的大小来显示,YES:表示WebView自适应大小,NO:表示按正文内容的大小来显示
    [_webView setScalesPageToFit:NO];
    //_webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [self.view addSubview : _webView];
    
 
    [self loadWebPageWithString:self.xintuobaoModel.url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark webview
- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)loadWebPageWithData:(NSString*)data
{
    //    self.webView.scalesPageToFit = YES;
    NSString *HTMLData = data;
    [self.webView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webViewHeight = [webView.scrollView contentSize].height;
    
    //    CGRect newFrame = webView.frame;
    //    newFrame.size.height = _webViewHeight;
    //    webView.frame = newFrame;
    //
}





#pragma mark - private methods

- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;

    imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    
    NSString *strTitle = @"掌富宝";
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.xintuobaoModel.name]];
    
    id<ISSContent> publishContent = [ShareSDK content:self.xintuobaoModel.name
                                       defaultContent:self.xintuobaoModel.name
                                                image:imagePath
                                                title:strTitle
                                                  url:self.xintuobaoModel.url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.xintuobaoModel.name title:strWXTitle url:self.xintuobaoModel.url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url: self.xintuobaoModel.url site:nil fromUrl:self.xintuobaoModel.url comment:nil summary:self.xintuobaoModel.name image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
    NSArray *shareList;
    if (![QQApiInterface isQQInstalled]) {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeSMS,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType:ShareTypeWeixiSession, ShareTypeWeixiTimeline,  nil];
        }
    }
    else {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeQQSpace, ShareTypeQQ,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType:ShareTypeQQSpace, ShareTypeWeixiSession, ShareTypeWeixiTimeline, ShareTypeQQ,  nil];
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
                                    //                                    XLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                                    hud.mode = MBProgressHUDModeText;
                                    hud.labelText = [NSString stringWithFormat:@"分享失败:%@", [error errorDescription]];
                                    hud.removeFromSuperViewOnHide = YES;
                                    [hud hide:YES afterDelay:1];
                                    
                                }
                            }];
    
}


@end
