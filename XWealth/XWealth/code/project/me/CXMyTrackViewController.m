//
//  CXMyTrackViewController.m
//  XWealth
//
//  Created by 12345 on 15-8-23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyTrackViewController.h"

@interface CXMyTrackViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end

@implementation CXMyTrackViewController

- (void)loadView
{
    [super loadView];
    [self initRightBarButton];
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y += kDefaultMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kDefaultMargin*2;
    
    //    tableVFrame.origin.x = kDefaultMargin;
    //    tableVFrame.size.width = kScreenWidth - 2 * kDefaultMargin;
    //    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin;
    //    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    
    _tableView = [[CXTrackTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"点击右上角添加购买记录!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringMyTrack;
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    [self loadMyReleaseFromServer:self.curPage];
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notificationInformationView:) name:NOTIFICATION_TRACK_UPDATA object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initRightBarButton
{

    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 30, 30);
    [releaseBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = kMiddleTextFont;
    [releaseBtn setTitle:StringAdd forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}
//右边按钮事件
- (void)settingClick:(UIButton *)button
{
        CXAddTrackViewController *AddTrackControl = [[CXAddTrackViewController alloc] init];
        AddTrackControl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AddTrackControl animated:YES];
    
}
#pragma mark - notification
- (void) notificationInformationView:(NSNotification *)notification
{

        self.curPage = BASE_PAGE;
        [self loadMyReleaseFromServer:self.curPage];
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
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_TRACK_LISTMYTRACK result:^(CXMainPlate *mainPlate, NSError *err) {
        
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
//删除
- (void) delReleaseFromServer:(NSInteger)index
{
    if (self.sourceDatas.count>=index) {
    CXTrackModel *model = [self.sourceDatas objectAtIndex:index];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"trackId" andLongValue:model.releaseId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_TRACK_DELRELEASE result:^(CXMainPlate *mainPlate, NSError *err) {
        
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
}

#pragma mark - CXReleaseTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    //    NSIndexPath *indexPath = (NSIndexPath*)data;
    //    CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    //
    //    CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
    //    detailController.informationModel = model;
    //    detailController.hidesBottomBarWhenPushed = YES;
    //
    //    [ self.navigationController pushViewController:detailController animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
