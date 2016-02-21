//
//  CXTrackTableView.m
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXTrackTableView.h"
#import "CXTrackCell.h"
#import "CXTrackCellFrame.h"

@implementation CXTrackTableView
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
    
    NSString *releaseCellIdentifier = @"releaseCellIdentifier";
    CXTrackCell *cell =[[CXTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:releaseCellIdentifier];
//    CXTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:releaseCellIdentifier];
//    if (cell == nil) {
//        cell = [[CXTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:releaseCellIdentifier];
//    }
    
    cell.trackModel = [self.sourceDatas objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXTrackModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXTrackCellFrame *cellFrame = [[CXTrackCellFrame alloc] initWithDataModel:model];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.delegate deleteItemAtIndex:indexPath.row];
    }
}


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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
