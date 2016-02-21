//
//  CXSelectFinanciersTableView.m
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSelectFinanciersTableView.h"
#import "CXSelectFinanciersCell.h"
#import "CXSelectFinanciersCellFrame.h"

@implementation CXSelectFinanciersTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        CGRect tableVFrame = self.bounds;
        //        tableVFrame.origin.y=kViewBeginOriginY;
        self.tableView = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kControlBgColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *InformationCellIdentifier = @"InformationCellIdentifier";
    CXSelectFinanciersCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
    if (cell == nil) {
        cell = [[CXSelectFinanciersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
    }
    if (_sourceDatas.count!=0) {
        
        CXFinanciersModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        cell.financiersModel = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXFinanciersModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXSelectFinanciersCellFrame *cellFrame = [[CXSelectFinanciersCellFrame alloc] initWithDataModel:model];
        return [cellFrame cellHeight];
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHaveSection)
    {
        return kFunctionBarHeight;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
}




#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    if ([self.sourceDatas count] == 0)
    {
        self.promptView.hidden = NO;
        self.tableView.hidden = YES;
    }
    else
    {
        self.promptView.hidden = YES;
        self.tableView.hidden = NO;
        
        [self.tableView reloadData];
    }
}

- (void) configDataHaveHeaderView:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    // 有headerview 显示headerview ，不显示没有任务提醒
    self.promptView.hidden = YES;
    self.tableView.hidden = NO;
    
    [self.tableView reloadData];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate tableViewDidScroll:scrollView];
}


@end
