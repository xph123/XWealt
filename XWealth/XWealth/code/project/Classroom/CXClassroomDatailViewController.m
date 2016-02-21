//
//  CXClassroomDatailViewController.m
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomDatailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "CXClassroomReaderViewController.h"
#import "CXLoginViewController.h"



@interface CXClassroomDatailViewController ()
@property (nonatomic, assign) int isFavorSending;
@property (nonatomic, strong) CXLawModel *lawModel;
@end

@implementation CXClassroomDatailViewController
{
    UIImageView *_showView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.isFavorSending = 0;
    self.title=@"详细信息";
    [self initRightBarButton];
    
    CGRect frame = self.view.frame;
    frame.origin.y=0;
    frame.size.height -= kViewEndSizeHeight + kButtomBarHeight;
    
    //    _tableView = [[CXInformationDetailTableView alloc] initWithFrame:frame];
    //    _tableView.informationModel = _informationModel;
    //    [self.view addSubview: _tableView];
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    //禁止UIWebView拖动
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    //设置UIWebView是按 WebView自适应大小显示,还是按正文内容的大小来显示,YES:表示WebView自适应大小,NO:表示按正文内容的大小来显示
    [_webView setScalesPageToFit:NO];
    //_webView.scalesPageToFit =YES;
    _webView.delegate =self;
    [self.view addSubview : _webView];
    
//    if (self.lawModel.url && self.lawModel.url.length > 0)
//    {
//        [self loadWebPageWithString:self.lawModel.url];
//    }
    
    CXClassroomCommentView *commentView = [[CXClassroomCommentView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kButtomBarHeight- kViewEndSizeHeight, kScreenWidth, kButtomBarHeight)];
//    [commentView setComments:self.lawModel.comments];
//    [commentView setGoods:self.lawModel.goods];
    [self.view addSubview:commentView];
    self.commentView = commentView;
    
    __unsafe_unretained CXClassroomDatailViewController *weak_self = self;
    commentView.viewNumberBlk = ^{
        [weak_self entryReadersView];
    };
    commentView.favorBlk = ^{
        [weak_self favor];
    };
    
    [self getInformationDetailFromServer];
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



#pragma mark - network data

- (void) getInformationDetailFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];

    [parametersUtil appendParameterWithName:@"courseId" andLongValue:self.courseId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_VIEW result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get product detail success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                NSString *attention = mainPlate.service;
                int favor = [attention intValue];
                
                self.lawModel = mainPlate.anyModels[0];
                [self loadWebPageWithString:self.lawModel.url];
                [self.commentView setComments:self.lawModel.comments];
                [self.commentView setGoods:self.lawModel.goods];
                
                if (favor == 1)
                {
                    [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_gooded"] forState:UIControlStateNormal];
                }
                else
                {
                    [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_good"] forState:UIControlStateNormal];
                }
                

                    NSDictionary *userInfo = @{@"lawModel":self.lawModel};
                
            
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:NOTIFICATION_COURSE_VIEW object:nil userInfo:userInfo];

            }
        }
        else
        {
            XLog(@"get product detail fail");
        }
    }];
}


- (void) sendFavor
{
    self.isFavorSending = 1;
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [parametersUtil appendParameterWithName:@"courseId" andLongValue:self.lawModel.classId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_FAVOR result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.isFavorSending = 0;
        if(!err)
        {
            XLog(@"favor success");
            if ([mainPlate.code integerValue] == 0)
            {
                self.lawModel.goods += 1;
                NSString *informStr = [NSString stringWithFormat:@"%d", self.lawModel.goods];
                [self.commentView.goodsButton setTitle: informStr forState: UIControlStateNormal];
                [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_gooded"] forState:UIControlStateNormal];


                    NSDictionary *userInfo = @{@"lawModel":self.lawModel};
                    
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:NOTIFICATION_COURSE_VIEW object:nil userInfo:userInfo];


            }
            
        }
        else
        {
            if ([StringLawFavored isEqualToString:(NSString*)err]||[StringCourseFavored isEqualToString:(NSString*)err])
            {
                if (self.lawModel.goods > 0)
                {
                    self.lawModel.goods -= 1;
                }
                
                NSString *informStr = [NSString stringWithFormat:@"%d", self.lawModel.goods];
                [self.commentView.goodsButton setTitle: informStr forState: UIControlStateNormal];
                [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_good"] forState:UIControlStateNormal];
                
                    NSDictionary *userInfo = @{@"lawModel":self.lawModel};
                    
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:NOTIFICATION_COURSE_VIEW object:nil userInfo:userInfo];
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

- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;
    if ([NSString isEmpty1:self.lawModel.imageUrl]) {
        imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    }
    else {
        imagePath = [ShareSDK imageWithUrl:[CXURLConstants getFullSltInformationUrl: self.lawModel.imageUrl]];
    }
    
    NSString *strTitle = @"掌富宝";
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.lawModel.name]];
    
    id<ISSContent> publishContent = [ShareSDK content:self.lawModel.name
                                       defaultContent:self.lawModel.name
                                                image:imagePath
                                                title:strTitle
                                                  url:self.lawModel.url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.lawModel.name title:strWXTitle url:self.lawModel.url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url: self.lawModel.url site:nil fromUrl:self.lawModel.url comment:nil summary:self.lawModel.name image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
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
// 目前的版本，不让看浏览的用户列表
- (void) entryReadersView
{
    //    CXInformationReaderViewController* readerController=[[CXInformationReaderViewController alloc] init];
    //    readerController.informationId = self.informationModel.informationId;
    //    [ self.navigationController pushViewController:readerController animated:YES];
}

- (void) favor
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    if (self.isFavorSending == 1)
    {
        return;
    }
    [self sendFavor];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSArray *imagesData =  [self parseData:response];
    //    NSMutableArray *images = [self downLoadPicture:imagesData];
    
    //将url转换为string
    NSString *picName = [[request URL] absoluteString];
    NSLog(@"picName is %@",picName);
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([picName hasPrefix:@"pic:"]) {
        NSString *urlToSave=[picName substringFromIndex:4];
        if (urlToSave.length>0) {
            NSString *urlName;
            if([urlToSave hasPrefix:@"http"])
            {
                urlName=urlToSave;
            }
            else
            {
                urlName=[kBaseURLString stringByAppendingString:urlToSave];
            }
            _showView=[[UIImageView alloc]initWithFrame:self.view.bounds];
            _showView.contentMode=UIViewContentModeScaleAspectFit;
            [_showView setImageWithURL:[NSURL URLWithString:urlName] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                _showView.image=image;
                //                [SJAvatarBrowser showImage:_showView];
                showImageArr *showAmage=[[showImageArr alloc]init];
                [showAmage showImageArray:nil andImage:_showView];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }
            return NO;
    }else {
        return YES;
    }
}



@end
