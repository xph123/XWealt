//
//  CXMyRecommentViewController.m
//  XWealth
//
//  Created by chx on 15/6/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyRecommentViewController.h"
#import "CXMyRecommentCell.h"
#import "CXUserDetailViewController.h"
#import "CXRecommentViewController.h"

@interface CXMyRecommentViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSString *state;
@end

@implementation CXMyRecommentViewController
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
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
    self.title = StringMyRecommend;
    self.state=@"1";
    [self initRightBarButton];
    [self setViewButton];
    
    self.curPage = BASE_PAGE;
    _recommentList = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kViewBeginOriginY+kButtonHeight+0.5, self.view.frame.size.width, self.view.frame.size.height  - kViewBeginOriginY-kButtonHeight-0.5) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kControlBgColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"您还未邀请好友使用掌富宝，请按右上角的邀请按钮邀请您的好友吧!", nil);
    self.tableView.tableFooterView = _loadMoreView;
    
    [self getRecommentListFromServer:self.curPage andState:self.state];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationRecomment)
                   name:NOTIFICATION_ME_RECOMMENT
                 object:nil];

}


-(void)setViewButton
{
    UIView *buttonBackView=[[UIView alloc]initWithFrame:CGRectMake(0, kViewBeginOriginY, self.view.frame.size.width, kButtonHeight)];
    buttonBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:buttonBackView];
    CGRect CentreBackViewFram=CGRectMake(self.view.frame.size.width/2, kButtonHeight/4, 1, kButtonHeight/2);
    UIView *CentreBackView=[[UIView alloc]initWithFrame:CentreBackViewFram];
    CentreBackView.backgroundColor=kGrayColor;
    [buttonBackView addSubview:CentreBackView];
    
    //右边的按钮
    CGRect leftFrame=CGRectMake(0, 0, self.view.frame.size.width/2-1, kButtonHeight);
    _leftBtn=[[UIButton alloc]initWithFrame:leftFrame];
    _leftBtn.tag=101;
    [_leftBtn setTitle:StringRegistered forState:UIControlStateNormal];
    [_leftBtn setBackgroundColor:[UIColor whiteColor]];
    [_leftBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:KReleaseButtonColor forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(LeftRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.selected=YES;
    [buttonBackView addSubview:_leftBtn];
    //左边的按钮
    CGRect RightFrame=CGRectMake(self.view.frame.size.width/2+1, 0, self.view.frame.size.width/2-1, kButtonHeight);
    _rightBtn=[[UIButton alloc]initWithFrame:RightFrame];
    _rightBtn.tag=102;
    [_rightBtn setTitle:StringNoRegister forState:UIControlStateNormal];
    [_rightBtn setBackgroundColor:[UIColor whiteColor]];
    [_rightBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:KReleaseButtonColor forState:UIControlStateSelected];
    [_rightBtn addTarget:self action:@selector(LeftRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonBackView addSubview:_rightBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initRightBarButton
{
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 60, 30);
    [releaseBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = kMiddleTextFont;
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [releaseBtn setTitle:StringInvitation forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(invitationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}

#pragma mark - private methods

- (void) notificationRecomment
{
    self.curPage = BASE_PAGE;
//    _rightBtn.selected=NO;
//    _leftBtn.selected=YES;
    [self getRecommentListFromServer:self.curPage andState:self.state];
}

- (void) invitationBtnClick
{
    self.registeredList = [[NSMutableArray alloc] init];
    
    for (CXRecommentModel *model in self.recommentList)
    {
        if (model.state == 1)
        {
            [self.registeredList addObject:model];
        }
    }
    
    CXRecommentViewController* recommentController=[[CXRecommentViewController alloc] initWithRedgisterList:self.registeredList];
    [self.navigationController pushViewController:recommentController animated:YES];
}

#pragma mark - button methods
-(void)LeftRightButtonClick:(UIButton *)btn
{
    if (btn.tag==101) {
        _rightBtn.selected=NO;
        [btn setSelected:YES];
        self.state=@"1";
        self.curPage=1;
         [self getRecommentListFromServer:self.curPage andState:self.state];

    }
    else if (btn.tag==102)
    {
        _leftBtn.selected=NO;
        btn.selected=YES;
        self.state=@"2";
        self.curPage=1;
         [self getRecommentListFromServer:self.curPage andState:self.state];
    }
    
}

#pragma mark - data & network data

- (void)getRecommentListFromServer:(NSInteger)page andState:(NSString *)state
{
    if (page == BASE_PAGE)
    {
        if (self.recommentList && self.recommentList.count > 0)
        {
            [self.recommentList removeAllObjects];
        }
    }

    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"state" andStringValue:state];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_LISTMYRECOMMENT result:^(CXMainPlate *mainPlate, NSError *err) {
 
        if(!err)
        {
            XLog(@"get recomment list success");
            
            [_recommentList addObjectsFromArray:mainPlate.anyModels];

            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_recommentList.count
                                             pageSize:@"10"];
            [self.tableView reloadData];
        }
        else
        {
            [self.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get recomment list fail");
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
        
        if (_recommentList && _recommentList.count > 0)
        {
            self.curPage++;
             [self getRecommentListFromServer:self.curPage andState:self.state];
            
        }
        else
        {
            self.curPage = BASE_PAGE;
             [self getRecommentListFromServer:self.curPage andState:self.state];
            
        }
    }
}

- (void)updateDelegateView
{
    //[self.tableView reloadData];
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recommentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FriendCellIdentifier = @"FriendCellIdentifier";
    CXMyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendCellIdentifier];
    if (cell == nil) {
        cell = [[CXMyRecommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FriendCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CXRecommentModel *recommentModel = (CXRecommentModel *)_recommentList[indexPath.row];
    
    cell.recommentModel = recommentModel;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2 * kLabelHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
