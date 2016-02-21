//
//  CXNewFriendViewController.m
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXNewFriendViewController.h"
#import "AddFriendCell.h"
#import "CXUserDetailViewController.h"

@interface CXNewFriendViewController ()

@end

@implementation CXNewFriendViewController

#pragma mark - view circle

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
    self.title = StringNewFriend;
    
    _addFriendList = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = kControlBgColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self getAddFriendsFromDb];
    
    // 新的朋友 是从服务器推送过来，先存在数据库中的，不需要从服务器获取
    [ self getFriendListFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data & network data

- (void)getAddFriendsFromDb
{
    if (_addFriendList.count) {
        [_addFriendList removeAllObjects];
    }
    
    _addFriendList = [[[CXDBHelper sharedDBHelper] getAddFriendDao] queryFriends];
    
    [_tableView reloadData];
}

- (void)getFriendListFromServer
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_NEWFRIENDS result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get friend list success");
            [[[CXDBHelper sharedDBHelper] getAddFriendDao] insertNewFriends:mainPlate.anyModels];
            
            NSMutableArray *userArray = [[NSMutableArray alloc] initWithCapacity:mainPlate.anyModels.count];
            
            for (CXAddFriendModel *model in mainPlate.anyModels)
            {
                [userArray addObject:model.user];
            }
            
            [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUsers:userArray];
            
            [self getAddFriendsFromDb];
        }
        else
        {
            XLog(@"get friend list fail");
        }
    }];
}


- (void)sendRefuseAddFriend:(CXAddFriendModel*)model
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:model.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_ADDFRIEND_REFUSE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"refuse add friend success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功拒绝，本地数据库操作，这里不做提示
                [[[CXDBHelper sharedDBHelper] getAddFriendDao] updateFriendState:FRIEND_REFUSE withUserId:model.userId];
                
                [self getAddFriendsFromDb];
                
                [self.tableView reloadData];
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_ACTION_ON_REQUEST object:nil];
             
            }
            else
            {
                // 失败
            }
        }
        else
        {
            XLog(@"result add friend fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}

- (void)sendAgreeAddFriend:(CXAddFriendModel*)model
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:model.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_ADDFRIEND_AGREE result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"agree add friend success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功拒绝，本地数据库操作，这里不做提示
                [[[CXDBHelper sharedDBHelper] getAddFriendDao] updateFriendState:FRIEND_YES withUserId:model.userId];
                // 添加好友，要把新的好友写入到好友数据表中
                BOOL isFriendExist = [[[CXDBHelper sharedDBHelper] getFriendDao] isFriendExist:model.userId];
                if (!isFriendExist)
                {
                    [[[CXDBHelper sharedDBHelper] getFriendDao] insertFriend:model.user];
                }
                
                [self getAddFriendsFromDb];
                [self.tableView reloadData];
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_ACTION_ON_REQUEST object:nil];
            }
            else
            {
                // 失败
            }
        }
        else
        {
            XLog(@"agree add friend fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}



#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addFriendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AddFriendCellIdentifier = @"AddFriendCellIdentifier";
    AddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:AddFriendCellIdentifier];
    if (cell == nil) {
        cell = [[AddFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddFriendCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CXAddFriendModel *addFriendModel = (CXAddFriendModel *)_addFriendList[indexPath.row];
    
    cell.addFriendModel = addFriendModel;
   
    __unsafe_unretained CXNewFriendViewController *weak_self = self;
    cell.refuseBlk = ^{
        [weak_self refuseAddFriend:addFriendModel cellForRowAtIndexPath:indexPath];
    };
    
    cell.agreeBlk = ^{
        [weak_self agreeAddFriend:addFriendModel cellForRowAtIndexPath:indexPath];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAddFriendCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CXAddFriendModel *addFriendModel = (CXAddFriendModel *)_addFriendList[indexPath.row];
    CXUserDetailViewController *userDetail = [[CXUserDetailViewController alloc] init];
    userDetail.userModel = addFriendModel.user;
    userDetail.isFriend = addFriendModel.isFriend;
    userDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userDetail animated:YES];
}

#pragma mark - cell delegate functions

- (void)refuseAddFriend:(CXAddFriendModel *) addFriendModel cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLog(@"refuseAddFriend");
    [self sendRefuseAddFriend:addFriendModel];
}

- (void)agreeAddFriend:(CXAddFriendModel *) addFriendModel cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    XLog(@"agree AddFriend");
    
    [self sendAgreeAddFriend:addFriendModel];
}


@end
