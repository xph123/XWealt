//
//  CXMyIntegralViewController.m
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyIntegralViewController.h"
#import "CXIntegralCell.h"

@interface CXMyIntegralViewController ()
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXMyIntegralViewController

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
    self.title = StringMyScore;
    
    self.curPage = BASE_PAGE;
    _integralList = [NSMutableArray array];
    
    [self initHeaderView];
    
    CGFloat talbeY = 100 + 2*kDefaultMargin + kViewBeginOriginY;
    CGFloat tableHeight = self.view.frame.size.height - 100;
    tableHeight -= kViewEndSizeHeight  + kDefaultMargin*2;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, talbeY, self.view.frame.size.width, tableHeight) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kControlBgColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateComplete;
    _loadMoreView.noData = NSLocalizedString(@"您还没有现金劵，请邀请好友赢取现金劵吧!", nil);
    self.tableView.tableFooterView = _loadMoreView;
    
    [self getMyIntegralFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initHeaderView
{
    CGFloat y = kViewBeginOriginY + kDefaultMargin;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, y, kScreenWidth - 2 * kDefaultMargin, 100)];
    headerView.backgroundColor = kColorWhite;
    [self.view addSubview:headerView];
    
    UILabel *integralTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kScreenWidth - 4 * kDefaultMargin, kLabelHeight)];
    integralTitle.font = kLargeTextFont;
    integralTitle.textColor = kTitleTextColor;
    integralTitle.numberOfLines = 1;
    integralTitle.textAlignment = NSTextAlignmentLeft;
    integralTitle.backgroundColor = [UIColor clearColor];
    integralTitle.text = StringMyScore;
    [headerView addSubview:integralTitle];

    UILabel *integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLargeMargin, kDefaultMargin + kLabelHeight, kScreenWidth - 120, kTwoLineLabelHeight)];
    integralLabel.font = kExtralLargeTextFont;
    integralLabel.textColor = kMainStyleColor;
    integralLabel.numberOfLines = 1;
    integralLabel.textAlignment = NSTextAlignmentLeft;
    integralLabel.backgroundColor = [UIColor clearColor];
    integralLabel.text = [@(kAppDelegate.currentUserModel.integral) stringValue];
    [headerView addSubview:integralLabel];
    self.integralLabel = integralLabel;
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 120 - kDefaultMargin, kDefaultMargin + kLabelHeight, 120 - 3 * kDefaultMargin, kButtonHeight)];
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    [moreBtn setTitle:@"查看详情>>" forState:UIControlStateNormal];
    [moreBtn setTitleColor:kHightLightTextColor forState:UIControlStateNormal];
    moreBtn.titleLabel.font = kMiddleTextFont;
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview: moreBtn];
    
}

- (void)moreBtnClick
{
    self.curPage = BASE_PAGE;
    _loadMoreView.state = LoadMoreStateIsLoading;
    [ self getIntegralListFromServer:self.curPage];
}

#pragma mark - data & network data

- (void) getMyIntegralFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_MYINTEGRAL result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"getIntegralListFromServer success");
            
            NSString *myIntegral =  mainPlate.anyModels[0];
            int integral = [myIntegral intValue];
            if (integral != 0)
            {
                self.integralLabel.text = [@(integral) stringValue];
                kAppDelegate.currentUserModel.integral = integral;
            }
        }
        else
        {
            XLog(@"getIntegralListFromServer fail");
        }
    }];

}

- (void)getIntegralListFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.integralList && self.integralList.count > 0)
        {
            [self.integralList removeAllObjects];
        }
    }
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_LISTMYINTEGRAL result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"getIntegralListFromServer success");
            
            [_integralList addObjectsFromArray:mainPlate.anyModels];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_integralList.count
                                             pageSize:@"10"];
        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"getIntegralListFromServer fail");
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
        
        if (_integralList && _integralList.count > 0)
        {
            self.curPage++;
            [self getIntegralListFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self getIntegralListFromServer:self.curPage];
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
    return _integralList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IntegralCellIdentifier = @"IntegralCellIdentifier";
    CXIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegralCellIdentifier];
    if (cell == nil) {
        cell = [[CXIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IntegralCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CXIntegralModel *integralModel = (CXIntegralModel *)_integralList[indexPath.row];
    
    cell.integralModel = integralModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXIntegralModel *integralModel = (CXIntegralModel *)_integralList[indexPath.row];
    CXIntegralFrame *cellFrame = [[CXIntegralFrame alloc] initWithDataModel:integralModel];
    return [cellFrame cellHeight];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
