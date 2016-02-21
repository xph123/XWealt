//
//  CXMyNewsViewController.m
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsViewController.h"
#import "CXSubscribeViewController.h"
#import "CXProductDetailWebViewController.h"
#import "CXInformationDetailViewController.h"

@interface CXMyNewsViewController ()
@property (nonatomic, assign) NSInteger delIndex;
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMyNewsViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += 0;
    tableVFrame.size.height -= kViewEndSizeHeight + kDefaultMargin;
    
    _tableView = [[CXMyNewsTableView alloc] initWithFrame:tableVFrame];
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
     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notificationNewsRed) name:NOTIFION_OFFLINE_NEW_PROMPT object:nil];
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

-(void)notificationNewsRed
{
   [self loadMyNewsFromServer:self.curPage];
}
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
    if (kAppDelegate.hasLogined) {
        NSMutableArray *arrData=[[NSMutableArray alloc]init];
             [arrData addObjectsFromArray:[CXReceiveMessages querytable:kAppDelegate.currentUserModel.userName]];
        CXNotificationModel *systemModel;
        CXNotificationModel *editionModel;
        CXNotificationModel *activityModel;
        CXNotificationModel *recommendModel;
        for (CXNotificationModel *model in arrData) {
            if (model.type==2) {
                if (systemModel==nil||systemModel.timestamp<model.timestamp) {
                    systemModel=model;
                }
            }
            if (model.type==3) {
                if (editionModel==nil||editionModel.timestamp<model.timestamp) {
                    editionModel=model;
                }
            }
            if (model.type==4) {
                if (activityModel==nil||activityModel.timestamp<model.timestamp) {
                    activityModel=model;
                }
            }
            if (model.type==5) {
                if (recommendModel==nil||recommendModel.timestamp<model.timestamp) {
                    recommendModel=model;
                }
            }
        }
        if (systemModel!=nil) {
           [self.sourceDatas addObject:systemModel];
        }
        if (editionModel!=nil) {
            [self.sourceDatas addObject:editionModel];
        }
        if (activityModel!=nil) {
            [self.sourceDatas addObject:activityModel];
        }
        if (recommendModel!=nil) {
            [self.sourceDatas addObject:recommendModel];
        }

    }
    else
    {
        NSMutableArray *arrData=[[NSMutableArray alloc]init];
        [arrData addObjectsFromArray:[CXReceiveMessages querytable:@"publicFile"]];
    

    CXNotificationModel *systemModel;
    CXNotificationModel *editionModel;
    CXNotificationModel *activityModel;
    CXNotificationModel *recommendModel;
    for (CXNotificationModel *model in arrData) {
        if (model.type==2) {
            if (systemModel==nil||systemModel.timestamp<model.timestamp) {
                systemModel=model;
            }
        }
        if (model.type==3) {
            if (editionModel==nil||editionModel.timestamp<model.timestamp) {
                editionModel=model;
            }
        }
        if (model.type==4) {
            if (activityModel==nil||activityModel.timestamp<model.timestamp) {
                activityModel=model;
            }
        }
        if (model.type==5) {
            if (recommendModel==nil||recommendModel.timestamp<model.timestamp) {
                recommendModel=model;
            }
        }
    }
        if (systemModel!=nil) {
            [self.sourceDatas addObject:systemModel];
        }
        if (editionModel!=nil) {
            [self.sourceDatas addObject:editionModel];
        }
        if (activityModel!=nil) {
            [self.sourceDatas addObject:activityModel];
        }
        if (recommendModel!=nil) {
            [self.sourceDatas addObject:recommendModel];
        }
    }
        [_loadMoreView updateWithCurrentLoadCount:_sourceDatas.count
                                   totalLoadCount:_sourceDatas.count
                                         pageSize:@"100"];

    
}
////删除
//- (void) delSubscribeFromServer:(NSInteger)index
//{
//    CXSubscribeModel *model = _sourceDatas[index];
//    
//    XHttpParameters *parametersUtil = [XHttpParameters parameters];
//    [parametersUtil appendParameterWithName:@"subscribeId" andLongValue:model.subscribeId];
//    
//    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_DELSUBSCRIBE result:^(CXMainPlate *mainPlate, NSError *err) {
//        
//        if(!err)
//        {
//            XLog(@"delSubscribeFromServer success");
//            
//            [self.sourceDatas removeObjectAtIndex:index];
//            [self.tableView configData:self.sourceDatas];
//        }
//        else
//        {
//            XLog(@"delSubscribeFromServer fail");
//            [self ShowProgressHUB:(NSString *)err];
//        }
//    }];
//}



#pragma mark - CXMyNewsTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath=(NSIndexPath *)data;
    CXNotificationModel *model=[self.sourceDatas objectAtIndex:indexPath.row];
    CXMyNewsDetailViewController* myNewsDetailViewController=[[CXMyNewsDetailViewController alloc] init];
    myNewsDetailViewController.type = model.type;
    myNewsDetailViewController.hidesBottomBarWhenPushed = YES;
   
    if (kAppDelegate.hasLogined) {
        [CXReceiveMessages updateFriendStateFromType:3 withMessageType:model.type andfileName:kAppDelegate.currentUserModel.userName];
        [self.tableView.tableView reloadData];
    }
    else
    {
        [CXReceiveMessages updateFriendStateFromType:3 withMessageType:model.type andfileName:@"publicFile"];
        [self.tableView.tableView reloadData];
    }

    [ self.navigationController pushViewController:myNewsDetailViewController animated:YES];
}

- (void)deleteItemAtIndex:(NSInteger)index
{
    
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
        
//        if (_sourceDatas && _sourceDatas.count > 0)
//        {
//            self.curPage++;
            self.curPage=BASE_PAGE;
            [self loadMyNewsFromServer:self.curPage];
//        }
    }
}

- (void)updateDelegateView
{
    [self.tableView configData:_sourceDatas];
}

@end
