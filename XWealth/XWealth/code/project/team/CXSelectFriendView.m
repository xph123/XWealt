//
//  CXSelectFriendView.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSelectFriendView.h"
#import "ChineseString.h"
#import "CXSelectFriendCell.h"
#import "CXSelectFriendStruct.h"

@implementation CXSelectFriendView

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
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = kControlBgColor;
        tableView.sectionIndexBackgroundColor = kControlBgColor;
        [self addSubview:tableView];
        self.tableView = tableView;
        
        _allFriendName = [NSMutableArray array];
        _allFriendDic = [NSMutableDictionary dictionary];
    }
    
    return self;
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
    static NSString *CellIdentifier = @"CXFriendCellIdentifier";
    CXSelectFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CXSelectFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CXSelectFriendStruct *friend = _allFriendDic[name];
    cell.selectModel = friend;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSelectFriendCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CXSelectFriendStruct *friend = (CXSelectFriendStruct *)_allFriendDic[name];
    if (friend == nil)
    {
        return;
    }
    
    if (friend.isSelected == 2)
    {
        return;
    }
    
    friend.isSelected = !friend.isSelected;
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - data
- (void)configData:(NSArray *)friendList andAlreadySelects:(NSArray*)alreadySelectedFriends
{
    if (_allFriendName.count)
    {
        [_allFriendName removeAllObjects];
        [_allFriendDic removeAllObjects];
    }
    
    for (CXUserModel *model in friendList)
    {
        // 如果是已经选择过的，=2 ，显示的时候打灰色勾
        int isSelected = 0;
        for (CXUserModel * alreadySelModel in alreadySelectedFriends)
        {
            if (alreadySelModel.userId == model.userId)
            {
                isSelected = 2;
                break;
            }
        }
        
        CXSelectFriendStruct *selectModel = [[CXSelectFriendStruct alloc] init];
        selectModel.isSelected = isSelected;
        selectModel.userModel = model;
        
        NSString *name = [NSObject isEmpty1:model.nickName] ? model.userName : model.nickName;
        [_allFriendName addObject:name];
        [_allFriendDic setObject:selectModel forKey:name];
    }
    
    self.indexArray = [ChineseString IndexArray:_allFriendName];
    self.LetterResultArr = [ChineseString LetterSortArray:_allFriendName];
    
    [_tableView reloadData];
}

@end
