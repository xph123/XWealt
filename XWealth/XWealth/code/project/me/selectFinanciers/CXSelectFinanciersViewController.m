//
//  CXSelectFinanciersViewController.m
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSelectFinanciersViewController.h"
@interface CXSelectFinanciersViewController ()

@end

@implementation CXSelectFinanciersViewController

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)loadView
{
    [super loadView];
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y +=kSmallMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kSmallMargin;
    
    _tableView = [[CXSelectFinanciersTableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    
    
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"选择理财师", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    
    self.navigationItem.title=@"选择专属理财师";
    
    self.curPage = BASE_PAGE;
    [self loadFinancialListWithPage:self.curPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -  network data
- (void) loadFinancialListWithPage:(NSInteger)page
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
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_FINANCIALLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get financial list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
        }
        else
        {
            [self.tableView.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get financial list fail");
            
        }
    }];
}

- (void) savaFinancialFromServer:(NSInteger)index
{
    CXFinanciersModel *model = [self.sourceDatas objectAtIndex:index];
    
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [parametersUtil appendParameterWithName:@"userId" andLongValue:model.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_SAVAFINANCIAL result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"savaFinancialFromServer success");
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = StringRecommentSuccess;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            XLog(@"savaFinancialFromServer fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}

#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data;
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    [self savaFinancialFromServer:indexPath.row];
    
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
            self.curPage ++;
            [self loadFinancialListWithPage:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadFinancialListWithPage:self.curPage];
        }
    }
}
- (void)updateDelegateView
{
    
}

@end
