//
//  CXSelectGroupViewController.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSelectGroupViewController.h"
#import "XSelectCell.h"

@interface CXSelectGroupViewController ()

@property (nonatomic, strong) NSIndexPath *selectIndex;

@end

@implementation CXSelectGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringSelectGroup;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    [self initRightBarButton];
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height - 2 * kDefaultMargin);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    [self loadGroupDatasFromDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - db data
- (void) loadGroupDatasFromDB
{
    _sourceDatas = [[[CXDBHelper sharedDBHelper] getGroupDao] queryGroups];
    
    XLog(@"%@", self.sourceDatas);
    [self.tableView reloadData];
}

#pragma mark - private methods

- (void)clickComplateSelectBtn:(UIButton *)button
{
    
    if (self.selectIndex == nil)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择团队";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        
        return;
    }
    else
    {
        CXGroupModel *model = [_sourceDatas objectAtIndex:self.selectIndex.row];
        
        [self.delegate setSelectedGroup:model];
        
        [self goBack];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *XSelectCellIdentifier = @"XSelectCellIdentifier";
    XSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:XSelectCellIdentifier];
    if (cell == nil) {
        cell = [[XSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XSelectCellIdentifier];
    }
    
    CXGroupModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
    if (self.selectIndex && indexPath.row == self.selectIndex.row )
    {
        [cell setContent:model.groupName andImageUrl:model.groupLogo andIsSelected:1];
    }
    else
    {
        [cell setContent:model.groupName andImageUrl:model.groupLogo andIsSelected:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSelectFriendCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectIndex = indexPath;
    
    [self.tableView reloadData];
    
}


@end
