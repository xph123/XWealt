//
//  CXMyNewsTableView.m
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsTableView.h"
#import "CXMyNewsCell.h"

@implementation CXMyNewsTableView
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
        //tableView
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
    return [self.sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *subscribeCellIdentifier = @"cell";
    CXMyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:subscribeCellIdentifier];
    if (cell == nil) {
        cell = [[CXMyNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subscribeCellIdentifier];
    }
    
    cell.notificationModel = [self.sourceDatas objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXNotificationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXMyNewsCellFrame *cellFrame = [[CXMyNewsCellFrame alloc] initWithDataModel:model];
        return [cellFrame cellHeight];
    }
    return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    CXTaskModel *model = [[_sourceDatas objectAtIndex:section] objectAtIndex:0];
//    return model.planDate;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
////- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
////    return NSLocalizedString(@"取消", nil);
////}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [self.delegate deleteItemAtIndex:indexPath.row];
//    }
//}

#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    [self.tableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate tableViewDidScroll:scrollView];
}
@end
