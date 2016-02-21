//
//  CXSingleSelFriendViewController.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSingleSelFriendViewController.h"
#import "XSelectCell.h"
#import "ChineseString.h"

@interface CXSingleSelFriendViewController ()
@property (nonatomic, strong) NSIndexPath *selectIndex;
@end

@implementation CXSingleSelFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringSelectGroup;
    
    [self initRightBarButton];
    
    //tableView
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.sectionIndexBackgroundColor = kControlBgColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    _allFriendName = [NSMutableArray array];
    _allFriendDic = [NSMutableDictionary dictionary];
    [self getFriendListFromDatabase];  // 先从本地读取好友数据
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
- (void)getFriendListFromDatabase
{
    if (_allFriendName.count)
    {
        [_allFriendName removeAllObjects];
        [_allFriendDic removeAllObjects];
    }
    
    NSMutableArray *friendList = [[[CXDBHelper sharedDBHelper] getFriendDao] queryFriends];
    
    for (CXUserModel *model in friendList)
    {
        NSString *name = [NSObject isEmpty1:model.nickName] ? model.userName : model.nickName;
        [_allFriendName addObject:name];
        [_allFriendDic setObject:model forKey:name];
    }
    
    self.indexArray = [ChineseString IndexArray:_allFriendName];
    self.LetterResultArr = [ChineseString LetterSortArray:_allFriendName];
    
    if (self.defaultPerformUserModel)
    {
        for (int i = 0; i < self.indexArray.count; i++)
        {
            for (int j = 0; j < [[self.LetterResultArr objectAtIndex:i] count]; j++)
            {
                NSString *name = [[self.LetterResultArr objectAtIndex:i] objectAtIndex:j];
                
                NSString *defaultName = [NSObject isEmpty1:self.defaultPerformUserModel.nickName] ? self.defaultPerformUserModel.userName : self.defaultPerformUserModel.nickName;
                
                if ([name isEqualToString:defaultName])
                {
                     self.selectIndex = [NSIndexPath indexPathForRow:j inSection:i];
                    break;
                }
            }
        }
    }
    
    [_tableView reloadData];
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
        NSString *name = [[self.LetterResultArr objectAtIndex:self.selectIndex.section] objectAtIndex:self.selectIndex.row];
        
        CXUserModel *model =  _allFriendDic[name];
        
        [self.delegate setSingleSelecteFriend:model];
        
        [self goBack];
    }
}

#pragma mark -Section的Header的值

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 30.0)];
    customView.backgroundColor = kControlBgColor;
    
    // create the button object
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.opaque = NO;
    titleLabel.textColor = kTitleTextColor;
    titleLabel.font = kLargeTextFont;
    titleLabel.frame = CGRectMake(10.0, 5.0, 300.0, 20.0);
    titleLabel.text = [_indexArray objectAtIndex:section];
    
    [customView addSubview:titleLabel];
    
    return customView;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *key = [_indexArray objectAtIndex:section];
//    return key;
//}

#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArray;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.LetterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *XSelectCellIdentifier = @"XSelectCellIdentifier";
    XSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:XSelectCellIdentifier];
    if (cell == nil) {
        cell = [[XSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XSelectCellIdentifier];
    }
    
    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    CXUserModel *model = _allFriendDic[name];
    
    if (self.selectIndex && (indexPath.row == self.selectIndex.row && indexPath.section == self.selectIndex.section) )
    {
        [cell setContent:model.nickName andImageUrl:model.headImg andIsSelected:1];
    }
    else
    {
        [cell setContent:model.nickName andImageUrl:model.headImg andIsSelected:0];
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
