//
//  CXPopularActivityTableView.m
//  XWealth
//
//  Created by gsycf on 15/10/12.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXPopularActivityTableView.h"
#import "CXPopularActivityCell.h"
#import "CXInformationModel.h"
#import "CXPopularActivityCellFrame.h"
@implementation CXPopularActivityTableView

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
    CXPopularActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
    if (cell == nil) {
        cell = [[CXPopularActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
    }
    if (_sourceDatas.count!=0) {
        
        CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        cell.informationModel = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXInformationTwoCellFrame *cellFrame = [[CXInformationTwoCellFrame alloc] initWithDataModel:model];
        return [cellFrame cellHeight];

    }
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return NSLocalizedString(@"取消", nil);
//}



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
