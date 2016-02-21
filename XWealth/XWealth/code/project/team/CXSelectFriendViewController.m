//
//  CXSelectFriendViewController.m
//  Link
//
//  Created by chx on 14-11-19.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSelectFriendViewController.h"
#import "ChineseString.h"
#import "CXSelectFriendCell.h"
#import "CXSelectFriendStruct.h"

@interface CXSelectFriendViewController ()

@end

@implementation CXSelectFriendViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.view.backgroundColor = kControlBgColor;
    
    [self initRightBarButton];
    
    CXSelectFriendView *tableView = [[CXSelectFriendView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self getFriendListFromDatabase];  // 先从本地读取好友数据
}

- (void) initRightBarButton
{
    UIButton *complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(0, 0, 60, 30);
    [complateBtn setTitle:StringSave forState:UIControlStateNormal];
    complateBtn.titleLabel.font = kNavBarTextFont;
    [complateBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [complateBtn addTarget:self action:@selector(clickComplateSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:complateBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)getFriendListFromDatabase
{
    NSMutableArray *friendList = [[[CXDBHelper sharedDBHelper] getFriendDao] queryFriends];
    
    [self.tableView configData:friendList andAlreadySelects:self.alreadySelectFriends];
}

#pragma mark - private methods

- (void)clickComplateSelectBtn:(UIButton *)button
{
    NSMutableArray *friends = [[NSMutableArray alloc] init];
    
    for (NSString *name in self.tableView.allFriendName)
    {
        CXSelectFriendStruct *selFriend = self.tableView.allFriendDic[name];
        
        if (selFriend.isSelected == 1)
        {
            [friends addObject:selFriend.userModel];
        }
    }
    
    if (friends.count == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择好友";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

        return;
    }
    else
    {
        if (self.alreadySelectFriends.count > 0)
        {
            [friends addObjectsFromArray:self.alreadySelectFriends];
        }
        [self.delegate setMutableSelectedFriends:friends andType:_resultType];
        
        [self goBack];
    }
}


@end
