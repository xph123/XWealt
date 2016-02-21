//
//  CXSecondhandMarketViewController.m
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSecondhandMarketViewController.h"
#import "CXTrustTransferCenterViewController.h"
#import "CXBuybackTrustCenterViewController.h"
#import "CXXintuobaoViewController.h"
#import "CXBuybackTrustCenterDetailViewController.h"
#import "CXTrustTransferCenterDetailViewController.h"
#import "CXXintuobaoDetailViewController.h"
#import "CXFotViewController.h"
@interface CXSecondhandMarketViewController ()

@end

@implementation CXSecondhandMarketViewController

{
    BOOL _loadInformationRecommendFromServerBool;
}
- (void) dealloc
{
    [_DownLoadMoreView free];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    
    
    
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kViewBeginOriginY;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight   : 0;
    //    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    _tableView = [[CXSecondhandMarketTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    _tableView.isHaveSection = YES;
    _tableView.navigationController=self.navigationController;
    __unsafe_unretained CXSecondhandMarketViewController *weak_self = self;
    _tableView.firstBtnBlk = ^{
        [weak_self twoFunButtonClick];
    };
    _tableView.secondBtnBlk = ^{
        [weak_self oneFunButtonClick];
    };
    _tableView.thirdBtnBlk = ^{
        [weak_self fourFunButtonClick];
    };
    _tableView.fourBtnBlk = ^{
        [weak_self threeFunButtonClick];
    };

    [self.view addSubview: _tableView];
    
    
    //下拉刷新
    _DownLoadMoreView=[[MJRefreshHeaderView alloc]initWithScrollView:self.tableView.tableView];
    _DownLoadMoreView.delegate=self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringTwoMarket;
    
    
    _loadInformationRecommendFromServerBool=YES;
    _sourceDatas = [[NSMutableArray alloc] init];
    _bannerList = [[NSMutableArray alloc] init];
    
//    [self initRightBarButton];
    [self loadBannerFromServer];
    [self loadInformationRecommendFromServer];
    
    
    [self initTableViewHeader];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed=YES;
}

#pragma mark - UI mark


- (void) initRightBarButton
{
    
//    CGRect frame = CGRectMake(0.0, 0.0, 80, self.navigationController.navigationBar.bounds.size.height);
//    
//    CXDropProjectBtn *menu = [[CXDropProjectBtn alloc] initWithFrame:frame title:StringWindRelease];
//    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:menu];
//    menu.delegate=self;
//    NSArray *arr=@[StringReleaseProduct,StringTrustTransfer,StringBuyback];
//    NSArray *arrIcon=@[@"home_release",@"home_transfer",@"home_buyback"];
//    menu.icons=arrIcon;
//    menu.items=arr;
//    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void) initTableViewHeader
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = kControlBgColor;
    
    CXBannerViewController *scrollImageView;
    CGFloat selectBtnY = 0;
    
    if (self.bannerList && self.bannerList.count > 0)
    {
        scrollImageView = [[CXBannerViewController alloc] initWithBanners:self.bannerList];
        scrollImageView.navigationController = self.navigationController;
        [headView addSubview:scrollImageView.view];
        
        selectBtnY = kBannerHeight;
    }
    
    //tableView
    _selectBtnsView = [[CXSecondHandMarketButtonBar alloc] initWithFrame:CGRectMake(0, selectBtnY, kScreenWidth, kFunctionsBtnImaHeight*2)];
    [headView addSubview:_selectBtnsView];
    
    headView.frame = CGRectMake(0, 0, kScreenWidth, selectBtnY + kFunctionsBtnImaHeight*2);
    
    self.tableView.tableView.tableHeaderView = headView;
    
    __unsafe_unretained CXSecondhandMarketViewController *weak_self = self;
    _selectBtnsView.firstBtnBlk = ^{
        [weak_self oneFunButtonClick];
    };
    _selectBtnsView.secondBtnBlk = ^{
        [weak_self twoFunButtonClick];
    };
    _selectBtnsView.thirdBtnBlk = ^{
        [weak_self threeFunButtonClick];
    };
    _selectBtnsView.fourBtnBlk = ^{
        [weak_self fourFunButtonClick];
    };
}


#pragma mark -  network data

- (void) loadBannerFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_BANNER_SECONDHOMEPAGE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _bannerList = (NSMutableArray * )mainPlate.anyModels;
            [self initTableViewHeader];
            [_DownLoadMoreView endRefreshing];
            
        }
        else
        {
            XLog(@"get banner list fail");
            //[self.tableView.tableView reloadData];
            [_DownLoadMoreView endRefreshing];
        }
    }];
}
//首页所有显示数据
- (void) loadInformationRecommendFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_SCONDPROINFO result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
            
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            [_DownLoadMoreView endRefreshing];
            
            _loadInformationRecommendFromServerBool=YES;
            
            
        }
        else
        {
            XLog(@"get banner list fail");
            //[self.tableView.tableView reloadData];
            
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            [_DownLoadMoreView endRefreshing];
            _loadInformationRecommendFromServerBool=YES;
        }
    }];
}



#pragma mark - private methods



// 信托转让
- (void)oneFunButtonClick
{
    CXTrustTransferCenterViewController* TrustTransferCenterController=[[CXTrustTransferCenterViewController alloc] init];
    TrustTransferCenterController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:TrustTransferCenterController animated:YES];
}


// 受让信托
- (void)twoFunButtonClick
{
    CXBuybackTrustCenterViewController* BuybackTrustCenterController=[[CXBuybackTrustCenterViewController alloc] init];
    BuybackTrustCenterController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:BuybackTrustCenterController animated:YES];
}

// 信托宝
- (void)threeFunButtonClick
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gaosouyi.com/xintuobao/index.html"]];
    CXXintuobaoViewController* trustController=[[CXXintuobaoViewController alloc] init];
    trustController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:trustController animated:YES];
}

// Fot
- (void)fourFunButtonClick
{

    CXFotViewController *fotViewController=[[CXFotViewController alloc] init];
    fotViewController.hidesBottomBarWhenPushed = YES;
    [ self.navigationController pushViewController:fotViewController animated:YES];

}



#pragma mark - CXSecondhandMarketTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    if (_sourceDatas.count!=0&&_sourceDatas!=nil) {
        NSIndexPath *indexPath = (NSIndexPath*)data;
        switch (indexPath.section) {
            case 0:
            {
                    CXBuyBackModel  *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    CXBuybackTrustCenterDetailViewController *buybackTrustCenterDetailViewController=[[CXBuybackTrustCenterDetailViewController alloc]init];
                    buybackTrustCenterDetailViewController.buyBackModel=model;
                    [self.navigationController pushViewController:buybackTrustCenterDetailViewController animated:YES];
                
            }
                break;
            case 1:
            {
                CXBenefitModel *model =[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXTrustTransferCenterDetailViewController *trustTransferCenterDetailController=[[CXTrustTransferCenterDetailViewController alloc]init];
                trustTransferCenterDetailController.benefitId=model.releaseId;
                trustTransferCenterDetailController.productId=model.productId;
                [self.navigationController pushViewController:trustTransferCenterDetailController animated:YES];

                
            }
                break;
            case 3:
            {
                CXXintuoBaoModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXXintuobaoDetailViewController * detailController=[[CXXintuobaoDetailViewController alloc] init];
                detailController.hidesBottomBarWhenPushed = YES;
                detailController.xintuobaoModel = model;
                [ self.navigationController pushViewController:detailController animated:YES];
            }
                break;
        
            default:
                break;
        }
    }
}
//刷新
#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==self.DownLoadMoreView) {
        if (_bannerList.count==0) {
            [_bannerList removeAllObjects];
            
            [self loadBannerFromServer];
        }
        if (_loadInformationRecommendFromServerBool==YES) {
            [_sourceDatas removeAllObjects];
            [self loadInformationRecommendFromServer];
            _loadInformationRecommendFromServerBool=NO;
        }
        
        
    }
}

#pragma mark - UIScrollViewDelegate
-(void)tableViewDidScroll:(UIScrollView *)scrollView
{
}
@end
