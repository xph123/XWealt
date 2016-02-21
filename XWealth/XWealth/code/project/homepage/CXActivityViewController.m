//
//  CXActivityViewController.m
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXActivityViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "CXLoginViewController.h"

@interface CXActivityViewController ()

@end

@implementation CXActivityViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.activityType=0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kControlBgColor;
    self.title = self.titleName;
    
    [self initRightBarButton];
    
    CGRect frame = self.view.frame;
    frame.size.height -= kViewEndSizeHeight;
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    //禁止UIWebView拖动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    //设置UIWebView是按 WebView自适应大小显示,还是按正文内容的大小来显示,YES:表示WebView自适应大小,NO:表示按正文内容的大小来显示
    [_webView setScalesPageToFit:NO];
    //_webView.scalesPageToFit =YES;
    _webView.delegate =self;
    
    [self.view addSubview : _webView];
    
    [self loadWebPageWithString:self.url];
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
    
//    NSString *str = [NSString stringWithFormat:@"http://192.168.0.167:8080/util/recommentActive.action?userId=%ld", kAppDelegate.currentUserModel.userId];
//    
//    [self loadWebPageWithString:str];
    //    NSString *js_result = [webView stringByEvaluatingJavaScriptFromString:str];
    
    //    CGRect newFrame = webView.frame;
    //    newFrame.size.height = _webViewHeight;
    //    webView.frame = newFrame;
    //
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSArray *imagesData =  [self parseData:response];
    //    NSMutableArray *images = [self downLoadPicture:imagesData];
    
    //将url转换为string
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString is %@",urlString);
    
    NSString *string2 = @"action_request:";
    NSRange range = [urlString rangeOfString:string2];
    NSInteger location = range.location;
    NSInteger lenght = range.length;
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
//    if ([urlString hasPrefix:@"login_request:"])
////    if ([urlString hasPrefix:@"https://itunes.apple.com/cn/app/zhang-fu-bao/"])
//    {
//        if (kAppDelegate.hasLogined == NO)
//        {
//            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//            loginViewController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:loginViewController animated:YES];
//        }
//        
//        return NO;
//    }
//    else if ([urlString hasPrefix:@"action_request:"])
    if (lenght > 0)
    {
        if (kAppDelegate.hasLogined)
        {
            NSString *urlToSave=[urlString substringFromIndex:location+lenght];
            if (urlToSave.length>0) {
                
                NSString *str = [NSString stringWithFormat:@"%@?userId=%ld", urlToSave, kAppDelegate.currentUserModel.userId];
                
                [self loadWebPageWithString:str];
                
            }
        }
        else
        {
            CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
            loginViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginViewController animated:YES];

        }
        
        
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - private methods

- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;
    if ([NSString isEmpty1:self.imageUrl]) {
        imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    }
    else {
        imagePath = [ShareSDK imageWithUrl:self.imageUrl];
    }
    
    NSString *strTitle = @"掌富宝";
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.nameUrl]];

    
    id<ISSContent> publishContent = [ShareSDK content:self.nameUrl
                                       defaultContent:self.nameUrl
                                                image:imagePath
                                                title:strTitle
                                                  url:self.shareUrl
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    NSLog(@"%@,%@,%@",self.nameUrl,self.shareUrl,imagePath);
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.nameUrl title:strWXTitle url:self.shareUrl thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url: self.shareUrl site:nil fromUrl:self.shareUrl comment:nil summary:self.nameUrl image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
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
                                    [self sendShareSuccessToServer];
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

- (void) sendShareSuccessToServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"infoId" andLongValue:self.infoId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SHAREACTIVITY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"sendShareSuccessToServer success");
        }
        else
        {
            XLog(@"sendShareSuccessToServer fail");
        }
    }];

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
