//
//  CXGroupTableView.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupTableView.h"
#import "CXGroupCell.h"

@implementation CXGroupTableView

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
        tableView.backgroundColor = kControlBgColor;
        [self addSubview:tableView];
        self.tableView = tableView;
        
        _sourceData = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - data

- (void) configData:(NSArray *)groupList
{
    _sourceData = (NSMutableArray*)groupList;

    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *GroupCellIdentifier = @"GroupCellIdentifier";
    CXGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupCellIdentifier];
    if (cell == nil)
    {
        cell = [[CXGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GroupCellIdentifier];
    }
    
    CXGroupModel *group = [_sourceData objectAtIndex:indexPath.row];
    cell.groupModel = group;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kUserCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   CXGroupModel *group = [_sourceData objectAtIndex:indexPath.row];
    
    if (group == nil)
    {
        return;
    }
    
    // 添加 点击好友的事件处理
    [self.delegate groupTableDidSelectItemAtIndex:group];
}


@end
