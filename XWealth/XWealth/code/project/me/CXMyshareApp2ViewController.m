//
//  CXMyshareApp2ViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyshareApp2ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "CXMyRecommentViewController.h"
@interface CXMyshareApp2ViewController ()

@end

@implementation CXMyshareApp2ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self getReturnProfit];
    self.view.backgroundColor = kColorWhite;
    self.title = self.titleName;
    [self initRightBarButton];
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    frame.size.height -= kViewEndSizeHeight;
    
    _webView =[[UIWebView alloc]initWithFrame:frame];
    _webView.backgroundColor=[UIColor whiteColor];
    //禁止UIWebView移动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    _webView.delegate=self;
    _webView.scalesPageToFit=NO;

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
//邀请返利请求接口
- (void) getReturnProfit
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SYSTEM_RETURNPROFIT result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadUserFundFromServer success");
            if ([mainPlate.anyModels count] > 0)
            {
                NSMutableArray *sourceDatas = (NSMutableArray * )mainPlate.anyModels;
                _shareModel=sourceDatas[0];
                _url = [NSString stringWithFormat:@"%@?code=%@&userId=%ld&integral=%@", _shareModel.url, _shareModel.code, kAppDelegate.currentUserModel.userId,_shareModel.integral];
                NSURL *url=[NSURL URLWithString:self.url];
                NSURLRequest *request=[NSURLRequest requestWithURL:url];
                [_webView loadRequest:request];
                
            }
        }
        else
        {
            XLog(@"loadUserFundFromServer fail");
        }
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSArray *imagesData =  [self parseData:response];
    //    NSMutableArray *images = [self downLoadPicture:imagesData];
    
    //将url转换为string
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString is %@",urlString);
    
    NSString *string2 = @"action_request";
    NSRange range = [urlString rangeOfString:string2];
    NSInteger location = range.location;
    NSInteger lenght = range.length;
    

    if (lenght > 0)
    {
        if (kAppDelegate.hasLogined)
        {
            [self shareToOtherButtonClick];
            
            
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

- (void) shareToOtherButtonClick
{
    NSString *content = _shareModel.intro;
    NSString *url = [NSString stringWithFormat:@"%@?userId=%ld",_shareModel.shareUrl,kAppDelegate.currentUserModel.userId];
    
    id<ISSCAttachment> imagePath;
    if ([NSString isEmpty1:_shareModel.imageUrl]) {
        imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    }
    else {
        imagePath = [ShareSDK imageWithUrl:_shareModel.imageUrl];
    }

    
    NSString *strTitle = self.shareModel.name;
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:imagePath
                                                title:strTitle
                                                  url:url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",content]];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:content title:strWXTitle url:url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url:url site:nil fromUrl:url comment:nil summary:content image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    NSArray *shareList;
    if (![QQApiInterface isQQInstalled]) {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeSMS,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType: ShareTypeWeixiSession, ShareTypeWeixiTimeline,  nil];
        }
    }
    else {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeQQSpace, ShareTypeQQ,  nil];
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
                                if (state == SSResponseStateBegan)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                                }
                                if (state == SSResponseStateSuccess)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                                    [self sendShareSuccessToServer];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
    [parametersUtil appendParameterWithName:@"inviteId" andStringValue:self.shareModel.inviteId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_ACTIVITY_INVITESHARE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"sendShare success");
        }
        else
        {
            XLog(@"sendShare fail");
        }
    }];
    
}


@end
