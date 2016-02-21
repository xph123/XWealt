//
//  CXSearchFriendViewController.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSearchFriendViewController.h"
#import "CXAddFriendCell.h"
#import "CXAddFriendFrame.h"
#import "CXUserDetailViewController.h"

#define KCellImage @"CellImage"
#define KCellText @"CellText"

@interface CXSearchFriendViewController ()
{
    NSString *_searchBarValue;
    UISearchBar *_nameSearchBar;
}

@end

@implementation CXSearchFriendViewController

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
    _userList = [NSMutableArray array];
    
    self.noFriend = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+kHeightOfSearchBar, kScreenWidth, 24)];
    _noFriend.textColor = kTextColor;
    _noFriend.text = @"抱歉，未找到您搜索的好友!";
    _noFriend.textAlignment = NSTextAlignmentCenter;
    _noFriend.font = [UIFont systemFontOfSize:15];
    _noFriend.hidden = YES;
    [self.view addSubview:_noFriend];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 我申请加别人为好友，需要更新搜索的好友列表
    [center addObserver:self
               selector:@selector(requestAddFriendNotification:)
                   name:NOTIFICATION_ADDFRIEND_MYREQUEST
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
        
        for (CXApplyModel *applyModel in _allCustomUser )
        {
            if (applyModel.applyId == userId)
            {
                applyModel.isFriend = 1;
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
    
    __unsafe_unretained CXSearchFriendViewController *weak_self = self;
    cell.addFriendBtnBlk = ^{
        weak_self.currentIndexPath = indexPath;
        [weak_self addFriendAction:applyModel andIndex:indexPath];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXApplyModel *addModel = (CXApplyModel *)[_allCustomUser objectAtIndex:indexPath.row];
    CXAddFriendFrame *cellFrame = [[CXAddFriendFrame alloc] initWithDataModel:addModel];
    CGFloat height = [cellFrame cellHeight];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    CXUserModel *userModel = (CXUserModel *)[_userList objectAtIndex:indexPath.row];
    
    // ？？？ 这里要加入是不是好友的判断
    CXUserDetailViewController *userDetail = [[CXUserDetailViewController alloc] init];
    userDetail.userModel = userModel;
    userDetail.isFriend = 0;
    userDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userDetail animated:YES];
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

        [self searchFriend];
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
    
    [self searchFriend];
}


- (void)searchFriend
{

    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"word" andStringValue:_searchBarValue];
    [parametersUtil appendParameterWithName:@"page" andIntValue:_currentPage];
    [parametersUtil appendParameterWithName:@"pageSize" andIntValue:kPageSize];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_SEARCHFRIEND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if (self.HUD) {
            [self.HUD hide:YES];
        }
        
        if(!err)
        {
            XLog(@"get friend list success");
//            [[[CXDBHelper sharedDBHelper] getFriendDao] insertFriends:mainPlate.anyModels];
//            [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUsers:mainPlate.anyModels];
//            
//            [self getFriendListFromDatabase];
            
            if (_reload && _allCustomUser.count) {
                [_allCustomUser removeAllObjects];
                [_userList removeAllObjects];
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
            
            [_userList addObjectsFromArray:mainPlate.anyModels];
            
            for (CXUserModel *userModel in mainPlate.anyModels)
            {
                CXApplyModel *applyModel = [[CXApplyModel alloc] init];
                applyModel.applyId = userModel.userId;
                applyModel.name = [userModel getDisplayName];
                applyModel.logo = userModel.headImg;
                applyModel.signature = userModel.signature;
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
            XLog(@"get friend list fail");
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

-(void) addFriendAction: (CXApplyModel *)applyModel andIndex:(NSIndexPath *)indexPath
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
//    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:applyModel.applyId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_ADDFRIEND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"add friend success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                NSInteger isFrined = 0;
                if ([mainPlate.anyModels count] > 0)
                {
                    NSString *strIsFriend = [mainPlate.anyModels objectAtIndex:0];
                    isFrined = [strIsFriend integerValue];
                }
                
                if (isFrined == 3)
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"你们已经是好友了。";
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }
                else
                {
                    // 成功
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"申请好友发送成功，请等待对方通过。";
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                    CXApplyModel *addModel = [_allCustomUser objectAtIndex:indexPath.row];
                    addModel.isFriend = 1;
                    
                    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"申请好友失败，请稍待再试。";
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"add friend fail");
        }
    }];
}

@end
