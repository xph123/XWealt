//
//  CXXtbBillViewController.m
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbBillViewController.h"
#import "CXXtbBillCell.h"
#import "CXXtbBillCellFrame.h"

@interface CXXtbBillViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXXtbBillViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = kControlBgColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"资金流水";
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kControlBgColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"没有资金流水!", nil);
    self.tableView.tableFooterView = _loadMoreView;

    [ self getsourceDatasFromServer:self.curPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data & network data

- (void)getsourceDatasFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在获取数据...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_XINTUOBAO_FINDBILLLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"getsourceDatasFromServer success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            
//            CXXtbBillModel *model = [[CXXtbBillModel alloc] init];
//            model.type = 1;
//            model.childType = 7;
//            model.desc = @"";
//            model.billId = 12;
//            model.amount = @"1200.00";
//            model.balance = @"100.00";
//            model.beType = @"TRUST_BAO";
//            model.parmid = 123;
//            model.name = @"信托宝第119期";
//            model.payTime = @"2015-09-07 10:24:00";
//            
//            [_sourceDatas addObject:model];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"getsourceDatasFromServer fail");
        }
    }];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
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
            [self getsourceDatasFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self getsourceDatasFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IntegralCellIdentifier = @"IntegralCellIdentifier";
    CXXtbBillCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegralCellIdentifier];
    if (cell == nil) {
        cell = [[CXXtbBillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IntegralCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CXXtbBillModel *billModel = (CXXtbBillModel *)_sourceDatas[indexPath.row];
    
    cell.billModel = billModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXXtbBillModel *billModel = (CXXtbBillModel *)_sourceDatas[indexPath.row];
    CXXtbBillCellFrame *cellFrame = [[CXXtbBillCellFrame alloc] initWithDataModel:billModel];
    return [cellFrame cellHeight];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
