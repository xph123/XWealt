//
//  CXMyBenefitReleaseViewController.m
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyBenefitReleaseViewController.h"
#import "CXProductDetailWebViewController.h"
#import "CXProductTransferViewController.h"
@interface CXMyBenefitReleaseViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;   //删除
@end

@implementation CXMyBenefitReleaseViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
         self.type=0;
        _buybackId=0;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kDefaultMargin;
     if (self.type==1) {
          tableVFrame.size.height -= kViewEndSizeHeight+kTabBarHeight;
     }
    else
    {
         tableVFrame.size.height -= kViewEndSizeHeight ;
    }
   
    
    //    tableVFrame.origin.x = kDefaultMargin;
    //    tableVFrame.size.width = kScreenWidth - 2 * kDefaultMargin;
    //    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin;
    //    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    
    _tableView = [[CXBenefitReleaseTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"您还未发布转让产品!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringMyBenefitTransfer;
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
   
    if (self.type==1) {
        
        UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height, kScreenWidth, kTabBarHeight)];
        downView.backgroundColor=kColorWhite;
        [self.view addSubview:downView];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kMinimumThread)];
        lineView.backgroundColor=kLineColor;
        [downView addSubview:lineView];
        
       UIButton *relectButton=[UIButton buttonWithType:UIButtonTypeCustom];
        relectButton.frame=CGRectMake(kLargeMargin, kDefaultMargin, kScreenWidth-2*kLargeMargin, downView.frame.size.height -2*kDefaultMargin);
        [relectButton setBackgroundColor:kMainStyleColor];
        [relectButton setTitle:@"发布信托转让" forState:UIControlStateNormal];
        [relectButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        relectButton.titleLabel.font=kMiddleTextFont;
        relectButton.layer.masksToBounds=YES;
        relectButton.layer.cornerRadius=kRadius;
        [relectButton addTarget:self action:@selector(relectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:relectButton];

    }
}
-(void)viewWillAppear:(BOOL)animated
{
     [self loadMyReleaseFromServer:self.curPage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  network data


- (void) loadMyReleaseFromServer:(NSInteger)page
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
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_LISTMYRELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get release list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
            
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get release list fail");
        }
    }];
}
//我要预约
- (void) sendSubscribe:(NSInteger)index
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"buybackId" andLongValue:self.buybackId];
    CXBenefitModel *model = [_sourceDatas objectAtIndex:index];
    [parametersUtil appendParameterWithName:@"benefitId" andLongValue:model.releaseId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BUYBACK_SUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
        
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
- (void) delReleaseFromServer:(NSInteger)index
{
    CXBenefitModel *model = [self.sourceDatas objectAtIndex:index];
    

    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"benefitId" andLongValue:model.releaseId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BENEFIT_DELRELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"delReleaseFromServer success");
            
            [self.sourceDatas removeObjectAtIndex:index];
            [self.tableView configData:self.sourceDatas];
        }
        else
        {
            XLog(@"delReleaseFromServer fail");
            [self ShowProgressHUB:(NSString *)err];
        }
    }];
}
#pragma mark - priveClick
-(void)relectBtnClick
{
    CXProductTransferViewController *productTransferViewController=[[CXProductTransferViewController alloc]init];
    [self.navigationController pushViewController:productTransferViewController  animated:YES];
}
#pragma mark - CXReleaseTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    self.delIndex = indexPath.row;
    switch (self.type) {
        case 0:
        {
            if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
                NSIndexPath *indexPath = (NSIndexPath*)data;
                CXBenefitModel *model = [_sourceDatas objectAtIndex:indexPath.row];
                if (model.state==2||model.state==1) {
                    CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
                    productDetailWebViewController.hidesBottomBarWhenPushed = YES;
                    productDetailWebViewController.productId = model.productId;
                    productDetailWebViewController.titleName=@"产品详情";
                    productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
                    [ self.navigationController pushViewController:productDetailWebViewController animated:YES];

                }
                else if (model.state==0)
                {
                    
                    
                    UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的产品正在审核，如急需转让,请直接联系客服" delegate:self cancelButtonTitle:@"联系客服" otherButtonTitles:@"确定", nil];
                    alar.tag=102;
                    [alar show];
                }
               else
               {

                   
                   UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的产品还未通过审核，如急需转让,请直接联系客服" delegate:self cancelButtonTitle:@"联系客服" otherButtonTitles:@"确定", nil];
                   alar.tag=102;
                   [alar show];
               }
            }
  
        }
        break;
        case 1:
        {
            CXBenefitModel *model = [_sourceDatas objectAtIndex:self.delIndex];
            if (model.state==1) {
                UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定选中产品" delegate:self cancelButtonTitle:@"重选" otherButtonTitles:@"确定", nil];
                alar.tag=101;
                [alar show];

            }
            else if (model.state==2)
            {
                UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的产品已经转让成功，请重新选择" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alar.tag=101;
                [alar show];
            }
            else
            {

                UIAlertView *alar=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的产品还未上架，如急需转让,请直接联系客服" delegate:self cancelButtonTitle:@"联系客服" otherButtonTitles:@"确定", nil];
                alar.tag=102;
                [alar show];
            }
                   }
        break;
        default:
        break;
    }
    

}

- (void)deleteItemAtIndex:(NSInteger)index
{
    self.delIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"删除", nil) otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self delReleaseFromServer:self.delIndex];
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 101:
        {
            switch (buttonIndex) {
                case 0:
                    break;
                case 1:
                {
                    
                    [self sendSubscribe:self.delIndex];
                    //[self.navigationController popViewControllerAnimated:YES];
                }
                    break;
                default:
                    break;
            }

        }
            break;
        case 102:
        {
            switch (buttonIndex) {
                case 0:
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
                }
                    break;
                case 1:
                    break;
                default:
                    break;
            }

        }
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_loadMoreView.state != LoadMoreStateComplete) {
        _loadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count > 0)
        {
            self.curPage++;
            [self loadMyReleaseFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadMyReleaseFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}


@end
