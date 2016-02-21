//
//  CXScheduleTableView.m
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXScheduleTableView.h"
#import "CXScheduleCell.h"
#import "CXProductListScheduleModel.h"
#import "CXScheduleCellFrame.h"
@implementation CXScheduleTableView

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
    CXScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
    if (cell == nil) {
        cell = [[CXScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
    }
    if (_sourceDatas.count!=0) {
        
        CXProductListScheduleModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        cell.productListScheduleModel = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXProductListScheduleModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXScheduleCellFrame *cellFrame = [[CXScheduleCellFrame alloc] initWithDataModel:model];
        return [cellFrame cellHeight];
    }
    return 0;
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
