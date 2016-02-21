//
//  CXRecommentTableView.m
//  XWealth
//
//  Created by chx on 15/7/4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXRecommentTableView.h"
#import "ChineseString.h"
#import "MJNIndexView.h"
#import "CXMyRecommentCell.h"
#import "UDCustomNavigation.h"

@interface CXRecommentTableView ()<MJNIndexViewDataSource>
// MJNIndexView
@property (nonatomic, strong) MJNIndexView *indexView;

@end

@implementation CXRecommentTableView

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
        _nameNum=0;
        //搜索栏
        CGRect searchFrame = self.frame;
        searchFrame.origin.y += kViewBeginOriginY;
        searchFrame.size.height = 44;
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame: searchFrame];
        searchBar.placeholder= StringInformationSearchInfo;
        searchBar.keyboardType = UISearchBarStyleDefault;
        //[searchBar becomeFirstResponder];
        
        //[self addSubview:searchBar];
        self.NameSearchBar = searchBar;
        
        //表格
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = kControlBgColor;
        tableView.sectionIndexBackgroundColor = kControlBgColor;
        [self addSubview:tableView];

        self.tableView = tableView;
        
        // initialise MJNIndexView
        self.indexView = [[MJNIndexView alloc]initWithFrame:self.tableView.frame];
        self.indexView.dataSource = self;
        self.indexView.fontColor = [UIColor blueColor];
        self.indexView.font=[UIFont systemFontOfSize:12.0f];
        [self addSubview:self.indexView];
        
        _allFriendName = [NSMutableArray array];
        _allFriendDic = [NSMutableDictionary dictionary];
        _allSearchArr=[NSMutableArray array];
    }
    return self;
}

#pragma mark - private motheds

- (void) recommentFriend:(CXRecommentModel*)model andIndex:(NSIndexPath *)indexPath
{
    [self.delegate recommentFriend:model andIndex:indexPath];
}


#pragma mark - data

- (void) configData:(NSArray *)friendList
{
    if (_allFriendName.count)
    {
        [_allFriendName removeAllObjects];
        [_allFriendDic removeAllObjects];
    }
    
    for (CXRecommentModel *model in friendList)
    {
        NSString *name = model.name;
        
        for (NSString *key in _allFriendDic) {
            if ([name isEqualToString:key]) {
                _nameNum++;
                name=[NSString stringWithFormat:@"%@%d",name,_nameNum];
            }
        }
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
    if (tableView==self.tableView)
    {
       return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView)
    {
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
    // create the parent view that will hold header Label
    return nil;
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
#pragma mark UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [_allSearchArr removeAllObjects];
//    for (NSMutableArray *muArr in self.allFriendName) {
        for (NSString *sstr in self.allFriendName) {
            NSRange range=[sstr rangeOfString:searchString];//判断是否字符串存在，生成位置是否存在
            if (range.location!=NSNotFound) {//如果位置存在
                [_allSearchArr addObject:sstr];
                //NSLog(@"%@",sstr);
            }
//        }
    }
    return YES;
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_NameSearchDisplayController.searchResultsTableView)
    {
        return 1;
    }

    return [_indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_NameSearchDisplayController.searchResultsTableView)
    {
       return _allSearchArr.count;
    }

    return [[self.LetterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier = @"CXMyRecommentCellIdentifier";
    CXMyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CXMyRecommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (tableView==_NameSearchDisplayController.searchResultsTableView)
    {
        NSString *name =self.allSearchArr[indexPath.row];
        //[[self.allSearchArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        CXRecommentModel *friend = _allFriendDic[name];
        cell.recommentModel = friend;
        
        __unsafe_unretained CXRecommentTableView *weak_self = self;
        cell.recommentBtnBlk = ^{
            
            [weak_self recommentFriend:friend andIndex:indexPath];
        };

    }
    else
    {
        NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        CXRecommentModel *friend = _allFriendDic[name];
        cell.recommentModel = friend;
        
        __unsafe_unretained CXRecommentTableView *weak_self = self;
        cell.recommentBtnBlk = ^{
            
            [weak_self recommentFriend:friend andIndex:indexPath];
        };

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2 * kLabelHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSString *name = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    CXUserModel *friend = (CXUserModel *)_allFriendDic[name];
//    if (friend == nil)
//    {
//        return;
//    }
//    
//    // 添加 点击好友的事件处理
//    [self.delegate didSelectItemAtIndex:friend];
}
-(void)setSearchbar:(void(^)(void))block
{
    self.NameSearchDisplayController.delegate=self;
    self.NameSearchDisplayController.searchResultsDelegate=self;
    self.NameSearchDisplayController.searchResultsDataSource=self;
}
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:YES andAnimation:YES];
    if (kIsIOS7OrLater && !kIsIOS7Dot2Before)
    {
        [nav.navigationBar setTranslucent:NO];
    }

}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:NO andAnimation:YES];
    if (kIsIOS7OrLater && !kIsIOS7Dot2Before)
    {
        [nav.navigationBar setTranslucent:NO];
    }

}
@end
