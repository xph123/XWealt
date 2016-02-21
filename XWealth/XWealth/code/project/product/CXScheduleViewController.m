//
//  CXScheduleViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXScheduleViewController.h"

@interface CXScheduleViewController ()

@end

@implementation CXScheduleViewController

- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y +=kSmallMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kSmallMargin;
    
    _tableView = [[CXScheduleTableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    
    
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"还没有打款记录!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    
    self.navigationItem.title=@"打款记录";
    
    [self loadInformationWithCategoryFromPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -  network data
- (void) loadInformationWithCategoryFromPage
{

    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"productId" andLongValue:_productId];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTSCHEDULE result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get banner list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"100"];
        }
        else
        {
            [self.tableView.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get banner list fail");
            
        }
    }];
}


#pragma mark - CXInformationTableViewDelegate




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
        
 
            [self loadInformationWithCategoryFromPage];
    }
}
- (void)updateDelegateView
{
    
}



@end
