//
//  CXTeamViewController.m
//  团队主界面（包含好友和群的分页）
//
//  Created by yi.chen on 14-10-23.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXTeamViewController.h"
#import "CXTeamView.h"
#import "CXNewFriendViewController.h"
#import "CXUserDetailViewController.h"
#import "CXPullFunctionsView.h"
#import "CXSearchFriendViewController.h"
//#import "CXGroupTaskViewController.h"
#import "CXCreateGroupViewController.h"
#import "CXSearchGroupViewController.h"

@interface CXTeamViewController ()<CXTeamViewDelegate, CXPullFunctionsViewDelegate>

@end

@implementation CXTeamViewController

- (void)loadView
{
    [super loadView];
    CXTeamView *teamView = [[CXTeamView alloc] initWithFrame:kScreenBound];
    teamView.delegate = self;
    teamView.backgroundColor = kControlBgColor;
    self.view = teamView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initRightBarButtonItem];
    
    [self getFriendListFromDatabase];  // 先从本地读取好友数据
    [self getFriendListFromServer];    // 再从服务器请求，然后更新本地好友数据
    [self getNewFriendsFromDb]; // 这个界面是在app中发送新的朋友的消息之后创建，所以进来后自己给自己发一个新好友消息
    
    [self getGroupListFromDatabase];
    [self getGroupListFromServer];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self  //别人同意我的加好友请求后，需要更新好友列表
               selector:@selector(getFriendListFromServer)
                   name:NOTIFICATION_AGREE_MYREQUEST
                 object:nil];
    [center addObserver:self  //同意、拒绝别人的加好友请求后，需要更新“新的朋友”和“生意人”上面的标记
               selector:@selector(agreeAddFriend)
                   name:NOTIFICATION_ACTION_ON_REQUEST
                 object:nil];
    [center addObserver:self  //有人要加我为好友，需要在“新的朋友”和“生意人”上面标记
               selector:@selector(addFriendNotification:)
                   name:NOTIFICATION_ADD_FRIEND
                 object:nil];
    [center addObserver:self selector:@selector(createGroupNotification:)
                   name:NOTIFICATION_CREATE_GROUP
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYNAME
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYLOGO
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYDESC
                 object:nil];
    [center addObserver:self
               selector:@selector(editRemarksNameNotification:)
                   name:NOTIFICATION_EDIT_REMARKSNAME
                 object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initRightBarButtonItem
{
    UIButton *pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pullBtn.frame = CGRectMake(0, 0, 30, 30);
    [pullBtn setBackgroundImage:IMAGE(@"pull_button") forState:UIControlStateNormal];
    [pullBtn setBackgroundImage:IMAGE(@"pull_button") forState:UIControlStateHighlighted];
    [pullBtn addTarget:self action:@selector(pullFunctionView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fabuBar = [[UIBarButtonItem alloc] initWithCustomView:pullBtn];
    [self.navigationItem setRightBarButtonItems:@[fabuBar]];
}

#pragma mark - private methods
- (void)pullFunctionView:(UIButton *)button
{
    NSArray *functionIcons = @[IMAGE(@"add_friend"),
                       IMAGE(@"add_group"),
                       IMAGE(@"create_group")];
    NSArray *functionTitles = @[StringAddFriend,
                        StringAddGroup,
                        StringCreateGroup];
    
    CXPullFunctionsView *pullView = [[CXPullFunctionsView alloc] initWithIcons:functionIcons andTitles:functionTitles];
    pullView.delegate = self;
    [pullView show];
}


#pragma mark - data

- (void)getFriendListFromServer
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
//    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_FRIENDLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get friend list success");
            [[[CXDBHelper sharedDBHelper] getFriendDao] insertFriends:mainPlate.anyModels];
            [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUsers:mainPlate.anyModels];
            
            [self getFriendListFromDatabase];
        }
        else
        {
            XLog(@"get friend list fail");
        }
    }];
}

- (void)getFriendListFromDatabase
{
    NSMutableArray *friendList = [[[CXDBHelper sharedDBHelper] getFriendDao] queryFriends];
    
    [(CXTeamView*)self.view configFriendData:friendList];
}

- (void) getNewFriendsFromDb
{
    NSString *number = nil;
    // 读数据库，看有没新好好友，在团队中显示红点
    NSMutableArray *addFriendList = [[[CXDBHelper sharedDBHelper] getAddFriendDao] queryApplyFriends];
    
    if (addFriendList.count > 0)
    {
        number = [NSString stringWithFormat:@"%d", addFriendList.count];
        
    }
    
    [(CXTeamView*)self.view configNewFriends:number];
    
}

- (void) agreeAddFriend
{
    // 添加好友成功，新好友的小红点数字要-1
    [self getNewFriendsFromDb];
    // 要把这个好友加入到好友表中
    [self getFriendListFromDatabase];

}

- (void)getGroupListFromServer
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
//    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_GROUPLIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get friend list success");
            [[[CXDBHelper sharedDBHelper] getGroupDao] insertGroups:mainPlate.anyModels];
            
            [self getGroupListFromDatabase];
        }
        else
        {
            XLog(@"get friend list fail");
        }
    }];
}

- (void)getGroupListFromDatabase
{
    NSMutableArray *groupList = [[[CXDBHelper sharedDBHelper] getGroupDao] queryGroups];
    
    [(CXTeamView*)self.view configGroupData:groupList];
}


#pragma mark - notification
- (void)addFriendNotification:(NSNotification *)notification
{
    NSString *number=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        number = notification.object;
    }
    
    [(CXTeamView*)self.view configNewFriends:number];
}

- (void)createGroupNotification:(NSNotification *)notification
{
    [self getGroupListFromDatabase];
}

- (void) notificationGroupModify
{
    [self getGroupListFromDatabase];
}

- (void)editRemarksNameNotification:(NSNotification *)notification
{
    // 修改好友别名，需要重新计算名字拼音的首字母，所以重新读数据
    [self getFriendListFromDatabase];
}


#pragma mark -  CXTeamViewDelegate

- (void)didSelectItemAtIndex:(id)data andChoiceIndex:(NSInteger) index
{
    if (index == 0)
    {
        // 好友
        CXUserDetailViewController *userDetail = [[CXUserDetailViewController alloc] init];
        userDetail.userModel = data;
        userDetail.isFriend = 1;
        userDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userDetail animated:YES];
    }
    else
    {
        // 群
//        CXGroupModel * model = (CXGroupModel*)data;
//        CXGroupTaskViewController *userDetail = [[CXGroupTaskViewController alloc] init];
//        userDetail.groupModel = model;
//        userDetail.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:userDetail animated:YES];
    }
}

- (void)entryNewFriendViewControler
{
    CXNewFriendViewController *newFriend = [[CXNewFriendViewController alloc] init];
    newFriend.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newFriend animated:YES];
}

#pragma mark -  CXPullFunctionsViewDelegate

- (void)pullFunctionsView:(CXPullFunctionsView *)pullFunctionsView didSelectClassName:(NSString *)className
{
    [pullFunctionsView dismiss];
    
    if ([className isEqualToString:StringAddFriend])
    {
        CXSearchFriendViewController *searchViewControl = [[CXSearchFriendViewController alloc] init];
        [self.navigationController pushViewController:searchViewControl animated:YES];
    }
    else if ([className isEqualToString:StringAddGroup])
    {
        CXSearchGroupViewController *searchViewControl = [[CXSearchGroupViewController alloc] init];
        [self.navigationController pushViewController:searchViewControl animated:YES];
    }
    else if ([className isEqualToString:StringCreateGroup])
    {
        CXCreateGroupViewController *searchViewControl = [[CXCreateGroupViewController alloc] init];
        [self.navigationController pushViewController:searchViewControl animated:YES];
    }
}

@end
