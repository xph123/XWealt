//
//  CXSearchGroupViewController.m
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSearchGroupViewController.h"
#import "CXAddFriendCell.h"
#import "CXAddFriendFrame.h"
#import "CXUserDetailViewController.h"
#import "CXGroupInfoViewController.h"

#define KCellImage @"CellImage"
#define KCellText @"CellText"

@interface CXSearchGroupViewController ()
{
    NSString *_searchBarValue;
    UISearchBar *_nameSearchBar;
}

@end

@implementation CXSearchGroupViewController

#pragma mark - view control circle

-(void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = StringAddFriend;
    self.view.backgroundColor = kControlBgColor;
    
    _searchBarValue = @"";
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, kNavAndStatusBarHeight, self.view.bounds.size.width, kHeightOfSearchBar)];
    searchBar.placeholder= StringSearchInfo;
    searchBar.delegate = self;
    searchBar.keyboardType = UISearchBarStyleDefault;
    [searchBar becomeFirstResponder];
    [self.view addSubview: searchBar];
    _nameSearchBar = searchBar;
    
    CGRect frame = CGRectMake(0, kNavAndStatusBarHeight + kHeightOfSearchBar + kDefaultMargin, self.view.bounds.size.width, kScreenHeight- kNavAndStatusBarHeight - kHeightOfSearchBar - 2 * kDefaultMargin);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_tableView];
    
    self.loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loadMoreBtn.frame = CGRectMake(0, 0, kScreenWidth, 30);
    _loadMoreBtn.backgroundColor = kControlBgColor;
    [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loadMoreBtn setTitleColor:kColorGrayLight forState:UIControlStateNormal];
    [_loadMoreBtn addTarget: self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = _loadMoreBtn;
    _tableView.contentOffset = CGPointMake(0, 0);
    
    _loadMoreBtn.hidden = YES;
    
    _allCustomUser = [NSMutableArray array];
    _groupList = [NSMutableArray array];
    
    self.noFriend = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+kHeightOfSearchBar, kScreenWidth, 24)];
    _noFriend.textColor = kTextColor;
    _noFriend.text = @"抱歉，未找到您搜索的群!";
    _noFriend.textAlignment = NSTextAlignmentCenter;
    _noFriend.font = [UIFont systemFontOfSize:15];
    _noFriend.hidden = YES;
    [self.view addSubview:_noFriend];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 我申请加别人为好友，需要更新搜索的好友列表
    [center addObserver:self
               selector:@selector(requestAddFriendNotification:)
                   name:NOTIFICATION_GROUP_APPLY
                 object:nil];
    
}

- (void)goBack:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification
- (void)requestAddFriendNotification:(NSNotification *)notification
{
    NSString *strUserId=nil;
    BOOL isUserExit = NO;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        strUserId = notification.object;
    }
    
    if (strUserId && strUserId.length > 0)
    {
        long userId = [strUserId integerValue];
        
        for (CXApplyModel *addFriendModel in _allCustomUser )
        {
            if (addFriendModel.applyId == userId)
            {
                addFriendModel.isFriend = 1;
                isUserExit = YES;
                break;
            }
        }
        
        if (isUserExit)
        {
            [self.tableView reloadData];
        }
        
    }
}


#pragma mark - UISearchBarDelegate
// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
{
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    _searchBarValue = searchBar.text;
    
    if (![_searchBarValue isEqualToString:@""]) {
        [self startSearch];
    }
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)cancelSelect:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _allCustomUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_allCustomUser == nil || _allCustomUser.count <= 0) {
        UITableViewCell *fCell = [[UITableViewCell alloc] init];
        return fCell;
    }
    static NSString *AddFriendCellIdentifier = @"AddFriendCellIdentifier";
    CXAddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:AddFriendCellIdentifier];
    if (cell == nil) {
        cell = [[CXAddFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddFriendCellIdentifier];
    }
    
    CXApplyModel *applyModel = (CXApplyModel *)[_allCustomUser objectAtIndex:indexPath.row];
    cell.applyModel = applyModel;
    
    __unsafe_unretained CXSearchGroupViewController *weak_self = self;
    cell.addFriendBtnBlk = ^{
        weak_self.currentIndexPath = indexPath;
        [weak_self applyGroupAction:applyModel andIndex:indexPath];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXApplyModel *applyModel = (CXApplyModel *)[_allCustomUser objectAtIndex:indexPath.row];
    CXAddFriendFrame *cellFrame = [[CXAddFriendFrame alloc] initWithDataModel:applyModel];
    CGFloat height = [cellFrame cellHeight];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CXGroupModel *groupModel = (CXGroupModel *)[_groupList objectAtIndex:indexPath.row];
    
    CXGroupInfoViewController* infoController=[[CXGroupInfoViewController alloc] initWithGroupModel:groupModel];
    [ self.navigationController pushViewController:infoController animated:YES];
}

#pragma mark - UIScrollView
//此代理在scrollview滚动时就会调用
//在下拉一段距离到提示松开和松开后提示都应该有变化，变化可以在这里实现
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_nameSearchBar resignFirstResponder];
    if (fabs(fabs(_tableView.contentOffset.y) - _tableView.contentSize.height + _tableView.frame.size.height) <= 1) {
        if (!_isLoadingMore) {
            [self loadMore];
        }
    }
}

//松开后判断表格是否在刷新，若在刷新则表格位置偏移，且状态说明文字变化为loading...
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)loadMore
{
    if (_hasMore) {
        _isLoadingMore = YES;
        [_loadMoreBtn setTitle:@"正在加载 . . ." forState:UIControlStateNormal];
        
        [self searchGroup];
    }
    
}

#pragma mark - network data

- (void)startSearch
{
    if (!self.HUD) {
        self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
        [self.view addSubview:self.HUD];
        self.HUD.labelText = @"搜索中...";
        self.HUD.removeFromSuperViewOnHide = NO;
    }
    [self.HUD show:YES];
    
    _reload = YES;
    _hasMore = YES;
    _currentPage = 1;
    
    [self searchGroup];
}


- (void)searchGroup
{
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    [parametersUtil appendParameterWithName:@"content" andStringValue:_searchBarValue];
    [parametersUtil appendParameterWithName:@"page" andIntValue:_currentPage];
    [parametersUtil appendParameterWithName:@"pageSize" andIntValue:kPageSize];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_GROUP_SEARCH result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if (self.HUD) {
            [self.HUD hide:YES];
        }
        
        if(!err)
        {
            XLog(@"search group success");
            
            if (_reload && _allCustomUser.count) {
                [_allCustomUser removeAllObjects];
                [_groupList removeAllObjects];
            }
            
            if (mainPlate.anyModels.count == 0)
            {
                if (_reload) {
                    [_tableView reloadData];
                    _noFriend.hidden = NO;
                    _loadMoreBtn.hidden = YES;
                }
                else {
                    _hasMore = NO;
                    _noFriend.hidden = YES;
                    _loadMoreBtn.hidden = NO;
                    
                    [_loadMoreBtn setTitle:@"加载完毕" forState:UIControlStateNormal];
                }
                return;
            }
            else
            {
                if (_reload) {
                    _tableView.contentOffset = CGPointMake(0, 0);
                }
            }
            
            [_groupList addObjectsFromArray:mainPlate.anyModels];
            
            for (CXGroupModel *groupModel in mainPlate.anyModels)
            {
                CXApplyModel *applyModel = [[CXApplyModel alloc] init];
                applyModel.applyId = groupModel.groupID;
                applyModel.name = groupModel.groupName;
                applyModel.logo = groupModel.groupLogo;
                applyModel.signature = groupModel.groupDesc;
                applyModel.isFriend = 0;
                
                [_allCustomUser addObject:applyModel];
            }
            
            _noFriend.hidden = YES;
            _loadMoreBtn.hidden = NO;
            
            if (mainPlate.anyModels.count < 10 && mainPlate.anyModels.count > 0) {
                _hasMore = NO;
                [_loadMoreBtn setTitle:@"加载完毕" forState:UIControlStateNormal];
            }
            else{
                _hasMore = YES;
                self.currentPage += 1;
                [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
            }
            
            [_tableView reloadData];
            
            if (_isLoadingMore) {
                _isLoadingMore = NO;
            }
            if (_reload) {
                _reload = NO;
            }
        }
        else
        {
            XLog(@"search group fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptLoadingFail;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            
            if (_isLoadingMore) {
                _isLoadingMore = NO;
            }
            
        }
    }];
}

-(void) applyGroupAction: (CXApplyModel *)applyModel andIndex:(NSIndexPath *)indexPath
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    [parametersUtil appendParameterWithName:@"groupId" andLongValue:applyModel.applyId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_GROUP_APPLY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"apply group success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"您的申请已发送，请等待对方通过。";
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
                CXApplyModel *addModel = [_allCustomUser objectAtIndex:indexPath.row];
                addModel.isFriend = 1;
                
                [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"申请添加群失败，请稍待再试。";
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"apply group fail");
        }
    }];
}
@end
