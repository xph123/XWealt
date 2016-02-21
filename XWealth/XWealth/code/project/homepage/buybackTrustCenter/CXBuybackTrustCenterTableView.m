//
//  CXBuybackTrustCenterTableView.m
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterTableView.h"
#import "CXBuybackTrustCenterCell.h"
#import "CXBuybackTrustCenterCellFrame.h"
@implementation CXBuybackTrustCenterTableView

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
    
    NSString *releaseCellIdentifier = @"buyBackCellIdentifier";
    CXBuybackTrustCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:releaseCellIdentifier];
    if (cell == nil) {
        cell = [[CXBuybackTrustCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:releaseCellIdentifier];
    }
    if (self.sourceDatas!=nil&&self.sourceDatas.count!=0) {
        cell.buyBackModel = [self.sourceDatas objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXBuyBackModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXBuybackTrustCenterCellFrame *cellFrame = [[CXBuybackTrustCenterCellFrame alloc] initWithDataModel:model];
        CGFloat cellHight=[cellFrame cellHeight]+kDefaultMargin;
        return cellHight;
    }
    return 0;
    //return kSubscribeCellHeight+15-3;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
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


@end
