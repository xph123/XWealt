//
//  CXMyNewsDetailViewController.m
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsDetailViewController.h"
#import "CXSubscribeViewController.h"
#import "CXProductDetailWebViewController.h"
#import "CXInformationDetailViewController.h"
#import "CXPopularActivityViewController.h"
@interface CXMyNewsDetailViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMyNewsDetailViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += 0;
    tableVFrame.size.height -=  kNavAndStatusBarHeight ;
    
    _tableView = [[CXMyNewsDetailTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"无消息!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringMyNews;
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    [self loadMyNewsFromServer:self.curPage];
}
-(void)viewDidDisappear:(BOOL)animated
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:NO andAnimation:NO];
    [nav.navigationBar setTranslucent:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private mothed


#pragma mark -  network data


- (void) loadMyNewsFromServer:(NSInteger)page
{
    
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    NSInteger arrCoun;
    if (kAppDelegate.hasLogined) {
        [_sourceDatas addObjectsFromArray:[CXReceiveMessages querytable:kAppDelegate.currentUserModel.userName andType:self.type andcurPage:page]];
        arrCoun=[[CXReceiveMessages querytable:kAppDelegate.currentUserModel.userName andType:self.type andcurPage:page] count];
    }
    else
    {
         [_sourceDatas addObjectsFromArray:[CXReceiveMessages querytable:@"publicFile" andType:self.type andcurPage:page]];
        arrCoun=[[CXReceiveMessages querytable:@"publicFile" andType:self.type andcurPage:page] count];
    }
    
    
    [_loadMoreView updateWithCurrentLoadCount:arrCoun
                               totalLoadCount:_sourceDatas.count
                                     pageSize:@"10"];
    
    
}




#pragma mark - CXMyNewsTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath=(NSIndexPath *)data;
    CXNotificationModel *model=[self.sourceDatas objectAtIndex:indexPath.row];
//    //修改状态
//    if (kAppDelegate.hasLogined) {
//        [CXReceiveMessages updateFriendState:3 withMessageId:model.id andfileName:kAppDelegate.currentUserModel.userName];
//    }
//    else
//    {
//        
//        [CXReceiveMessages updateFriendState:3 withMessageId:model.id andfileName:@"publicFile"];
//    }

   
    if (model.type==3)
    {
        UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"版本升级提示" message:model.content delegate:self cancelButtonTitle:@"遗憾错过" otherButtonTitles:@"立即更新", nil];
        [aler show];
    }
    
    else if (model.type==4)
    {
        //热门活动
        CXPopularActivityViewController *popularActivityControl = [[CXPopularActivityViewController alloc] init];
        popularActivityControl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:popularActivityControl animated:YES];
    }
    
    else if (model.type==5)
    {
        if (model.eventId!=0) {
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = model.eventId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.eventId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
        }
    }

    //修改红点
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_OFFLINE_NEW_PROMPT object:nil];
}

- (void)deleteItemAtIndex:(NSInteger)index
{
    
}




#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
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
              [self loadMyNewsFromServer:self.curPage];
        }
        else
        {
        self.curPage=BASE_PAGE;
        [self loadMyNewsFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/zhang-fu-bao/id1018214306?mt=8"]];
            break;
        default:
            break;
    }
}

@end
