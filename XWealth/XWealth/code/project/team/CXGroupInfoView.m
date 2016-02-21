//
//  CXGroupInfoView.m
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupInfoView.h"
#import "XModifyInfoCell.h"
#import "XModifyInfoMutableLineCell.h"

@implementation CXGroupInfoView

- (id) initWithFrame:(CGRect)frame
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
        
        CGRect tvFrame = self.bounds;
        UITableView *tableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = kControlBgColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        self.tableView = tableView;
    }
    
    return self;
}

#pragma mark - data
- (void)configData:(CXGroupModel *)groupModel andManager:(CXUserModel*)managerModel
{
    _groupModel = groupModel;
    _managerModel = managerModel;
    
    _sectionList1 = [[NSArray alloc] initWithObjects:
                     StringGroupMenuLogo,
                     StringGroupMenuName,
                     StringGroupMenuDesc,
                     nil];
    
    _sectionList2 = [[NSArray alloc] initWithObjects:
                     StringGroupMenuManager,
                     StringGroupMenuCreate,
                     nil];

    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberofRows = 0;
    
    if (0 == section)
    {
        numberofRows = [_sectionList1 count];
    }
    else if(1 == section)
    {
        numberofRows = [_sectionList2 count];
    }
    
    
    return numberofRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ModifyInfoCellIdentifier = @"ModifyInfoCellIdentifier";
    XModifyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ModifyInfoCellIdentifier];
    if (cell == nil) {
        cell = [[XModifyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ModifyInfoCellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andImageUrl:self.groupModel.groupLogo];
            }
                break;
            case 1:
            {
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andContent:self.groupModel.groupName];
            }
                break;
            case 2:
            {
                static NSString *ModifyInfoMutableLineCellIdentifier = @"ModifyInfoMutableLineCellIdentifier";
                XModifyInfoMutableLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ModifyInfoMutableLineCellIdentifier];
                if (cell == nil) {
                    cell = [[XModifyInfoMutableLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ModifyInfoMutableLineCellIdentifier];
                }

                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andContent:self.groupModel.groupDesc];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    
    if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                if (self.managerModel)
                {
                    [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:[self.managerModel getDisplayName]];
                }
            }
                break;
            case 1:
            {
                XDateTimeHelper *help = [[XDateTimeHelper alloc] initWithDate:self.groupModel.createDate];
                [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:[help getDate]];
            }
                break;
            default:
                break;
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    
    if (section == 1)
    {
        height = kLargeMargin;
    }
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = kMenuHeight;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
            height = HeadCellHeight;
        else if (indexPath.row == 2)
        {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            height = cell.frame.size.height;
            height = ((XModifyInfoMutableLineCell*)cell).cellHeight;
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                [self.infoDelegate changeGroupLogo];
            }
                break;
            case 1:
            {
                [self.infoDelegate changeGroupName];
            }
                break;
            case 2:
            {
                [self.infoDelegate changeGroupDesc];
            }
                break;
            default:
                break;
        }
    }
    
    // 群主和创建时间 不需要有响应事件，这两个不能修改
    if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
            }
                break;
            case 1:
            {
            }
                break;
            default:
                break;
        }
    }
}

@end
