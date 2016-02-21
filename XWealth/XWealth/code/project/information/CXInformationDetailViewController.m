//
//  CXInformationDetailViewController.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationDetailViewController.h"
#import "CXCommentView.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "CXInformationReaderViewController.h"
#import "CXLoginViewController.h"
#import "SJAvatarBrowser.h"
#import "TFHpple.h"

@interface CXInformationDetailViewController ()

@property (nonatomic, assign) int isFavorSending; //判断是否加载完成
@property (nonatomic, strong) CXInformationModel *informationModel;

@end

//限定大图片尺寸
#define BIG_IMG_WIDTH 264
#define BIG_IMG_HEIGHT 300
@implementation CXInformationDetailViewController
{
    UIView *_backView;
    UIImageView *_showView;
    NSURLConnection *_connection;
    NSMutableArray *_downloadImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"资讯";
    self.isFavorSending = 0;
    
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
//     [self addTapOnWebView];
    
//    if (self.informationModel.url && self.informationModel.url.length > 0)
//    {
//        [self loadWebPageWithString:self.informationModel.url];
//    }
    
    CXCommentView *commentView = [[CXCommentView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kButtomBarHeight- kViewEndSizeHeight, kScreenWidth, kButtomBarHeight)];
//    [commentView setComments:self.informationModel.comments];
//    [commentView setGoods:self.informationModel.goods];
    [self.view addSubview:commentView];
    self.commentView = commentView;
    
    __unsafe_unretained CXInformationDetailViewController *weak_self = self;
    commentView.viewNumberBlk = ^{
        [weak_self entryReadersView];
    };
    commentView.favorBlk = ^{
        [weak_self favor];
    };
    commentView.collectBlk=^{
        [weak_self collect];
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
    [parametersUtil appendParameterWithName:@"informationId" andLongValue:self.informationId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_DETAIL result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get product detail success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                NSString *attention = mainPlate.service;
                int favor = [attention intValue];
                
                self.informationModel = mainPlate.anyModels[0];
                
                [self.commentView setComments:self.informationModel.comments];
                [self.commentView setGoods:self.informationModel.goods];
                
                if (self.informationModel.url && self.informationModel.url.length > 0)
                {
                    [self loadWebPageWithString:self.informationModel.url];
                }
                
                if (favor == 1)
                {
                    [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_gooded"] forState:UIControlStateNormal];
                }
                else
                {
                    [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_good"] forState:UIControlStateNormal];
                }

                
                NSDictionary *userInfo = @{@"informationModel":self.informationModel};
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_INFORMATION_VIEW object:nil userInfo:userInfo];
                self.isFavorSending=1;
            }
        }
        else
        {
            self.isFavorSending=0;
            XLog(@"get product detail fail");
        }
    }];
}


- (void) sendFavor
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"informationId" andLongValue:_informationModel.informationId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_FAVOR result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"favor success");
            if ([mainPlate.code integerValue] == 0)
            {
                self.informationModel.goods += 1;
                NSString *informStr = [NSString stringWithFormat:@"%d", self.informationModel.goods];
                [self.commentView.goodsButton setTitle: informStr forState: UIControlStateNormal];
                [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_gooded"] forState:UIControlStateNormal];
                
                NSDictionary *userInfo = @{@"informationModel":self.informationModel};
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_INFORMATION_VIEW object:nil userInfo:userInfo];
            }
            
        }
        else
        {
            if ([StringInformFavored isEqualToString:(NSString*)err])
            {
                if (self.informationModel.goods > 0)
                {
                    self.informationModel.goods -= 1;
                }
                
                NSString *informStr = [NSString stringWithFormat:@"%d", self.informationModel.goods];
                [self.commentView.goodsButton setTitle: informStr forState: UIControlStateNormal];
                [self.commentView.goodsButton setImage:[UIImage imageNamed:@"information_good"] forState:UIControlStateNormal];
                
                NSDictionary *userInfo = @{@"informationModel":self.informationModel};
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_INFORMATION_VIEW object:nil userInfo:userInfo];
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
- (void) sendCollect
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
     [parametersUtil appendParameterWithName:@"flag" andLongValue:1];
    
    [parametersUtil appendParameterWithName:@"informationId" andLongValue:_informationModel.informationId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_FAVORITEINFO result:^(CXMainPlate *mainPlate, id err) {
        if(!err)
        {
            XLog(@"favor success");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = StringCollectionSuccess;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

            
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

    }];
    
}

#pragma mark - private methods

- (void) shareToOtherButtonClick
{
    if (self.isFavorSending == 0)
    {
        return;
    }
    id<ISSCAttachment> imagePath;
    if ([NSString isEmpty1:self.informationModel.imageUrl]) {
        imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    }
    else {
        imagePath = [ShareSDK imageWithUrl:[CXURLConstants getFullSltInformationUrl: self.informationModel.imageUrl]];
    }

    NSString *strTitle = @"掌富宝";
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",self.informationModel.name]];
    
    id<ISSContent> publishContent = [ShareSDK content:self.informationModel.name
                                       defaultContent:self.informationModel.name
                                                image:imagePath
                                                title:strTitle
                                                  url:self.informationModel.url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
     NSLog(@"%@,%@,%@",self.informationModel.name,self.informationModel.url,self.informationModel.imageUrl);
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:self.informationModel.name title:strWXTitle url:self.informationModel.url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url: self.informationModel.url site:nil fromUrl:self.informationModel.url comment:nil summary:self.informationModel.name image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
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

    if (self.isFavorSending == 0)
    {
        return;
    }
    [self sendFavor];
}
- (void) collect
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    if (self.isFavorSending == 0)
    {
        return;
    }
    [self sendCollect];
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


////解析html数据
//- (NSArray*)parseData:(NSData*) data
//{
//    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
//    
//    //在页面中查找img标签
//    NSArray *images = [doc searchWithXPathQuery:@"//img"];
//    return images;
//}
////下载图片的方法
//- (NSMutableArray*)downLoadPicture:(NSArray *)images
//{
//    //创建存放UIImage的数组
//    _downloadImages = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < [images count]; i++){
//        NSString *prefix = [[[images objectAtIndex:i] objectForKey:@"src"] substringToIndex:4];
//        NSString *url = [[images objectAtIndex:i] objectForKey:@"src"];
//        
////        //判断图片的下载地址是相对路径还是绝对路径，如果是以http开头，则是绝对地址，否则是相对地址
////        if ([prefix isEqualToString:@"http"] == NO){
////            url = [_URLUITextField.text stringByAppendingPathComponent:url];
////        }
//        
//        NSURL *downImageURL = [NSURL URLWithString:url];
//        
//        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:downImageURL]];
//        
//        if(image != nil){
//            [_downloadImages addObject:image];
//        }
//        NSLog(@"下载图片的URL:%@", url);
//    }
//    return _downloadImages;
//}



















//-(void)addTapOnWebView
//{
//    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [self.webView addGestureRecognizer:singleTap];
//    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
//}

//#pragma mark- TapGestureRecognizer
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
//
//-(void)handleSingleTap:(UITapGestureRecognizer *)sender
//{
//    CGPoint pt = [sender locationInView:self.webView];
//    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
//    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
//    NSLog(@"image url=%@", urlToSave);
//    if (urlToSave.length > 0) {
//        _showView=[[UIImageView alloc]initWithFrame:self.view.bounds];
//        _showView.contentMode=UIViewContentModeScaleAspectFit;
//
//        [_showView setImageWithURL:[NSURL URLWithString:urlToSave] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            _showView.image=image;
//           
//            [self showImageURL:urlToSave point:0];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//            
//        }];
//
////        [self showImageURL:urlToSave point:pt];
//    }
//}
//呈现图片
//-(void)showImage:(UIImageView *)avatarImageView
//{
//    
//    lastScale = 1.0;
//    UIImage *image = avatarImageView.image;
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
//    backgroundView.backgroundColor = [UIColor blackColor];
//    backgroundView.alpha = 0;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
//    imageView.image = image;
//    imageView.tag = 100;
//    imageView.userInteractionEnabled = YES;
//    [backgroundView addSubview:imageView];
//    [window addSubview:backgroundView];
//    window.backgroundColor = [UIColor blackColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
//    [backgroundView addGestureRecognizer:tap];
//    
//    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
//    //[pinchRecognizer setDelegate:self];
//    [imageView addGestureRecognizer:pinchRecognizer];
//    
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
//                                                    initWithTarget:self
//                                                    action:@selector(handlePan:)];
//    [imageView addGestureRecognizer:panGestureRecognizer];
//    
//    CGSize bigSize;
//    CGSize smallSize = image.size;
//    CGFloat scale = smallSize.width/smallSize.height;
//    CGFloat x, y;
//    if (scale > screenWidth / screenHeight) {
//        bigSize = CGSizeMake(screenWidth, screenWidth*smallSize.height/smallSize.width);
//        x = 0;
//        y = (screenHeight - bigSize.height) / 2;
//    }
//    else {
//        bigSize = CGSizeMake(screenHeight*smallSize.width/smallSize.height, screenHeight);
//        x = (screenWidth- bigSize.width) / 2;
//        y = (screenHeight - bigSize.height) / 2;
//    }
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame=CGRectMake(x, y, bigSize.width, bigSize.height);
//        backgroundView.alpha = 1;
//    } completion:^(BOOL finished) {
//    }];
//
////    [self.navigationController setNavigationBarHidden:YES];
////    _backView=[[UIView alloc]initWithFrame:self.view.bounds];
////    _backView.backgroundColor=[UIColor blackColor];
////    _backView.alpha=0;
////    [self.view addSubview:_backView];
////    
////    UIScrollView *scrollerBackView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
////    scrollerBackView.minimumZoomScale=1.0f;
////    scrollerBackView.maximumZoomScale=5.0f;
////    scrollerBackView.delegate=self;
////    //scrollerBackView.pagingEnabled=YES;
////     [_backView addSubview:scrollerBackView];
////    
////    UIImageView *showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
////    showView.center = point;
////    
////    [UIView animateWithDuration:0.5f animations:^{
////        CGPoint newPoint = self.view.center;
////        newPoint.y += 20;
////        showView.center = newPoint;
////        _backView.alpha=1.0f;
////    }];
////    
////    showView.backgroundColor = [UIColor blackColor];
////    showView.userInteractionEnabled = YES;
////    [showView setImageWithURL:[NSURL URLWithString:url]];
////    [scrollerBackView addSubview:showView];
////   
////   
////    
////    
////    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleViewTap:)];
////    [_backView addGestureRecognizer:singleTap];
//    
//    
//}
//
//
////移除图片查看视图
//-(void)handleSingleViewTap:(UITapGestureRecognizer *)sender
//{
//    for (id obj in self.view.subviews) {
//        if ([obj isKindOfClass:[_backView class]]) {
//            [obj removeFromSuperview];
//        }
//    }
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
