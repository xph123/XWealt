//
//  CXFriendTableView.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXFriendTableView.h"
#import "CXFriendCell.h"
#import "ChineseString.h"
#import "MJNIndexView.h"

@interface CXFriendTableView ()<MJNIndexViewDataSource>
// MJNIndexView
@property (nonatomic, strong) MJNIndexView *indexView;

@end

@implementation CXFriendTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kControlBgColor;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableHeaderView = [self markHeaderView];
        tableView.backgroundColor = kControlBgColor;
        tableView.sectionIndexBackgroundColor = kControlBgColor;
        [self addSubview:tableView];
        self.tableView = tableView;
        
        
        // initialise MJNIndexView
        self.indexView = [[MJNIndexView alloc]initWithFrame:self.tableView.frame];
        self.indexView.dataSource = self;
        self.indexView.fontColor = [UIColor blueColor];
        [self addSubview:self.indexView];
        
        _allFriendName = [NSMutableArray array];
        _allFriendDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - ui init

- (UIView*) markHeaderView
{
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kUserCellHeight);
    
    UIView *headerView = [[UIView alloc] initWithFrame:rect];
    headerView.backgroundColor = kControlBgColor;
    
    CGRect rectUserView = rect;
    rectUserView.origin.x = kDefaultMargin;
    rectUserView.size.width -= kDefaultMargin*2;
    
    CXUserView *userView = [[CXUserView alloc] initWithFrame:rectUserView];
    userView.headImg.image = IMAGE(@"newfriend");
    userView.name.text = StringNewFriend;
    self.addFriendView = userView;
    [headerView addSubview:userView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriendViewClickAction:)];
    [_addFriendView addGestureRecognizer:singleTap];
    
    return headerView;
}

// 画小红点和数字
- (void)addNewFriendsTips:(NSString *)number
{
    if (number && number.length > 0)
    {
        self.addFriendView.tips.hidden = NO;
        self.addFriendView.numberLabel.text = number;
    }
    else
    {
        self.addFriendView.tips.hidden = YES;
        self.addFriendView.numberLabel.text = @"";
    }
}

- (void) addFriendViewClickAction:(NSString *) banner
{
    [self.delegate entryNewFriendViewControler];
}

#pragma mark - data

- (void) configData:(NSArray *)friendList
{
    if (_allFriendName.count)
    {
        [_allFriendName removeAllObjects];
        [_allFriendDic removeAllObjects];
    }
    
    for (CXUserModel *model in friendList)
    {
        NSString *name = [model getDisplayName];
        [_allFriendName addObject:name];
        [_allFriendDic setObject:model forKey:name];
    }
    
    self.indexArray = [ChineseString IndexArray:_allFriendName];
    self.LetterResultArr = [ChineseString LetterSortArray:_allFriendName];
    
    [_tableView reloadData];
    [_indexView refreshIndexItems];
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

#pragma mark MJMIndexForTableView datasource methods
// two methods needed for MJNINdexView protocol
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    return _indexArray;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0  inSection:index] atScrollPosition: UITableViewScrollPositionTop     animated:NO];
}


//#pragma mark -设置右方表格的索引数组
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return _indexArray;
//}
//#pragma mark -
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return index;
//}

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
    static NSString *CellIdentifier = @"CXFriendCellIdentifier";
    CXFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CXFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CXUserModel *friend = _allFriendDic[name];
    cell.userModel = friend;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kUserCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CXUserModel *friend = (CXUserModel *)_allFriendDic[name];
    if (friend == nil)
    {
        return;
    }
    
    // 添加 点击好友的事件处理
    [self.delegate didSelectItemAtIndex:friend];
}

@end
