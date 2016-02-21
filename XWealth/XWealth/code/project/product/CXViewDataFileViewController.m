//
//  CXViewDataFileViewController.m
//  XWealth
//
//  Created by chx on 15/6/30.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXViewDataFileViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
@interface CXViewDataFileViewController ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSMutableData *data;
@end

@implementation CXViewDataFileViewController
{
    MBProgressHUD *_hud;
    NSString   *_fileName;    //文件名称
   
    
}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = kControlBgColor;
    [self initRightBarButton];
    self.title = self.viewTitle;
    CGRect frame = self.view.frame;
    self.data=[[NSMutableData alloc]init];
    
    frame.size.height -= kViewEndSizeHeight;
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    //禁止UIWebView拖动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    //设置UIWebView是按 WebView自适应大小显示,还是按正文内容的大小来显示,YES:表示WebView自适应大小,NO:表示按正文内容的大小来显示
    [_webView setScalesPageToFit:YES];
    //_webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [self.view addSubview : _webView];
     NSArray *fileNameArr=[_url componentsSeparatedByString:@"/"];
    _fileName=fileNameArr[fileNameArr.count-1];
    if (self.url && self.url.length > 0)
    {
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *Path=[paths[0] stringByAppendingPathComponent:@"projectFile"];
        // 若不存在userFolder，则建立该文件夹
        if (![fileManager fileExistsAtPath:Path])
        {
            [fileManager createDirectoryAtPath:Path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *filePath=[Path stringByAppendingPathComponent:_fileName];
        //没有文件
        if (![fileManager fileExistsAtPath:filePath]) {
             [self loadWebPageWithString:self.url];
            [self loadWithData:self.url];
        }
        //有文件
        else
        {
            NSURL *DataUrl = [NSURL fileURLWithPath:filePath];
            [_webView loadRequest:[NSURLRequest requestWithURL:DataUrl]];
        }
        
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = StringPrompt;
        hud.detailsLabelText = StringFileNoExist;
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }

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
    UIButton *addTaskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTaskBtn.frame = CGRectMake(0, 0, 30, 30);
    [addTaskBtn setImage:IMAGE(@"share") forState:UIControlStateNormal];
    [addTaskBtn addTarget:self action:@selector(shareToOtherButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:addTaskBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
    
}

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
//开始加载的时候执行该方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:_hud];
    _hud.labelText = StringAddingData;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud show:YES];

}
//加载完成的时候执行该方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
     [_hud hide:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"加载成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    _webViewHeight = [webView.scrollView contentSize].height;
 
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    [_hud hide:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"网络错误";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

#pragma mark- NSURLConnectionDataDelegate
- (void)loadWithData:(NSString *)urlStr
{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    _fileName=[response suggestedFilename];
    self.data.length=0;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
        [self.data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Path=[paths[0] stringByAppendingPathComponent:@"projectFile"];
    // 若不存在userFolder，则建立该文件夹
    if (![fileManager fileExistsAtPath:Path])
    {
        [fileManager createDirectoryAtPath:Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath=[Path stringByAppendingPathComponent:_fileName];
    if(![fileManager fileExistsAtPath:filePath])
    {
        [self.data writeToFile:filePath atomically:YES];
    }
}
- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;
    
    imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    
    NSString *url = self.url;
    
    NSString *strTitle = StringAppName;
    id<ISSContent> publishContent =nil;
    
    publishContent = [ShareSDK content:self.shareName
                        defaultContent:self.shareName
                                 image:imagePath
                                 title:strTitle
                                   url:url
                           description:nil
                             mediaType:SSPublishContentMediaTypeNews];
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.shareName]];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.shareName title:strWXTitle url:url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url:url site:nil fromUrl:url comment:nil summary:self.shareName image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
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

@end
