//
//  CXTrustTransferCenterDetailViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterDetailViewController.h"
#import "CXSubscribeViewController.h"
#import "CXProductDetailViewController.h"
#import "CXLoginViewController.h"
#import "CXProductDetailWebViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface CXTrustTransferCenterDetailViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) BOOL isShowMore;
@property (nonatomic, assign) NSInteger delIndex;     //删除的行
@end

@implementation CXTrustTransferCenterDetailViewController
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(instancetype)init
{
    self=[super init];
    if (self) {
//        UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        
//        self.navigationItem.leftBarButtonItems=@[leftbtn];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=StringTrustTransferDetail;
    self.view.backgroundColor=kControlBgColor;
    CGRect frame=self.view.frame;
    frame.origin.y=0;
    frame.origin.y += kViewBeginOriginY;
    frame.size.height-=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kButtomBarHeight + kSmallMargin : kButtomBarHeight + kSmallMargin;
    _tableView=[[CXTrustTransferCenterDetailTableView alloc]initWithFrame:frame];
    _tableView.delegate=self;
    _tableView.isHaveSection = true;
     _sourceDatas = [[NSMutableArray alloc] init];
    [self.view addSubview:_tableView];
    [self initTableViewHeader];
    [self initRightBarButton];
    self.curPage = BASE_PAGE;
    if (self.benefitId!=0||_benefitModel!=nil) {
        [self loadReleaseFromServer];
    }
    [self loadSourceDatasFromServer:self.curPage];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"还没有预约哦！快来预约吧!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
    
    
    CXTrustTransferDetailOperatorView *detailOperatorView=[[CXTrustTransferDetailOperatorView alloc]initWithFrame:CGRectMake(0, frame.size.height+frame.origin.y, kScreenWidth, kTabBarHeight)];
    [self.view addSubview:detailOperatorView];
    self.operatorView=detailOperatorView;

    __unsafe_unretained CXTrustTransferCenterDetailViewController *weak_self=self;
    detailOperatorView.dataBlk= ^{
        [weak_self dataButtonClick];
    };
    detailOperatorView.subscribeBlk= ^{
        [weak_self subscribeButtonClick];
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
#pragma mark -  network data

//获取相关的信托转让详情
- (void) loadReleaseFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"benefitId" andLongValue:self.benefitId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_VIEW result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get release list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            if (_sourceDatas!=nil&&_sourceDatas.count!=0) {
                CXBenefitModel *benefitArr=[_sourceDatas objectAtIndex:0];
                self.benefitModel=benefitArr;
                
                [self initTableViewHeader];
                [self loadSourceDatasFromServer:self.curPage];
                [self.tableView.tableView reloadData];
            }


        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            XLog(@"get release list fail");
        }
    }];
}
//认购记录
- (void) loadSourceDatasFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    [parametersUtil appendParameterWithName:@"benefitId" andLongValue:self.benefitModel.releaseId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_LISTBENFITRECORD result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadXintuoBaosFromServer success");
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            //                [self.tableView configData:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                         totalLoadCount:_sourceDatas.count
                                               pageSize:@"10"];
        }
        else
        {
            
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"loadXintuoBaosFromServer fail");
        }
    }];
}
//我要预约
- (void) sendSubscribe
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"benefitId" andLongValue:self.benefitModel.releaseId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_SUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get sendSubscribe success");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = StringSubscribeSuccess;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

            self.curPage=BASE_PAGE;
            [self loadSourceDatasFromServer:self.curPage];
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
//取消预约
- (void) cancelSubscribe:(NSInteger)index
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
     CXBenefitRecordModel *model = [_sourceDatas objectAtIndex:index];
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"recordId" andLongValue:model.Id];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_CENCELSUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"get cancelSubscribe success");
            [self.sourceDatas removeObjectAtIndex:index];
            [self.tableView configDataHaveHeaderView:_sourceDatas countNum:self.sourceDatas.count];
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initTableViewHeader
{
    CXTrustTransferDetailHeadView *headView=[[CXTrustTransferDetailHeadView alloc]initWithModel:self.benefitModel];
    headView.frame=headView.headViewRect;
    headView.backgroundColor=kControlBgColor;
    self.tableView.tableView.tableHeaderView=headView;
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}
#pragma mark - CXTrustTransferCenterDetailTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
//    if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
//        NSIndexPath *indexPath = (NSIndexPath*)data;
//        CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
//        
//        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
//        detailController.informationId = model.informationId;
//        detailController.hidesBottomBarWhenPushed = YES;
//        
//        [ self.navigationController pushViewController:detailController animated:YES];
//    }
}
- (void)deleteItemAtIndex:(NSInteger)index
{
   
    self.delIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否取消预约！" delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self cancelSubscribe:self.delIndex];
    }
}
#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_loadMoreView.state != LoadMoreStateComplete) {
        _loadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count)
        {
            self.curPage++;
            [self loadSourceDatasFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadSourceDatasFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configDataHaveHeaderView:_sourceDatas countNum:_sourceDatas.count];
}
#pragma mark - private methods
//产品详情
-(void)dataButtonClick
{
    if (_benefitModel.productId!=0&&_benefitModel!=nil) {
//        CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//        detailController.hidesBottomBarWhenPushed = YES;
//        //        detailController.productId = _productModel.productId;
//        detailController.productId = _benefitModel.productId;
//        [ self.navigationController pushViewController:detailController animated:YES];
        

        
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = _benefitModel.productId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, _benefitModel.productId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"该产品未上架";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

    }
    
}
//我要预约
-(void)subscribeButtonClick
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    if(kAppDelegate.currentUserModel.userId==self.benefitModel.userId)
    {
        UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"自己不能预约自己的产品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alar show];
        return;

    }
    if (self.benefitModel.state == 2)
    {
        UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此产品已经交易成功，请选择其他产品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alar show];
        return;
    }
    

    
    [self sendSubscribe];

}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
               switch (buttonIndex) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                    break;
                default:
                    break;
            }
    

}
- (void) shareToOtherButtonClick
{
    id<ISSCAttachment> imagePath;
    
    imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%ld", kBaseURLString,@"/wealth/benefit/share?id=", self.benefitModel.releaseId];
    
    NSString *strTitle = StringAppName;
    id<ISSContent> publishContent =nil;
    NSString *shareName=[NSString stringWithFormat:@"信托转让-%@",self.benefitModel.name];

    publishContent = [ShareSDK content:shareName
                        defaultContent:shareName
                                 image:imagePath
                                 title:strTitle
                                   url:url
                           description:nil
                             mediaType:SSPublishContentMediaTypeNews];
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",shareName]];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:shareName title:strWXTitle url:url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url:url site:nil fromUrl:url comment:nil summary:shareName image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    
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
