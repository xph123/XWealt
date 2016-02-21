//
//  CXEditRemarksViewController.m
//  Link
//
//  Created by chx on 15-2-27.
//  Copyright (c) 2015年 ruisk.com. All rights reserved.
//

#import "CXEditRemarksViewController.h"
#import "XModifyInfoCell.h"
#import "CXModifyTextFieldViewController.h"

@interface CXEditRemarksViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation CXEditRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringEditUserInfo;
    
    _titleArray = @[StringRemarksName,StringRemarksEmail];
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(editRemarksNameNotification:)
                   name:NOTIFICATION_EDIT_REMARKSNAME
                 object:nil];
    [center addObserver:self
               selector:@selector(editRemarksEmailNotification:)
                   name:NOTIFICATION_EDIT_REMARKSEMAIL
                 object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification
- (void)editRemarksNameNotification:(NSNotification *)notification
{
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    
    self.friendUserModel.remarksName = name;
    
    [self.tableView reloadData];
}

- (void)editRemarksEmailNotification:(NSNotification *)notification
{
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    
    self.friendUserModel.remarksEmail = name;
    
    [self.tableView reloadData];
}


#pragma mark - private motheds

- (void) deleteFriend
{
    
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
        numberofRows = [_titleArray count];
    }
    else if(1 == section)
    {
        numberofRows = 1;
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
                [cell setTitle:[_titleArray objectAtIndex:indexPath.row] andContent:self.friendUserModel.remarksName];
            }
                break;
            case 1:
            {
                [cell setTitle:[_titleArray objectAtIndex:indexPath.row] andContent:self.friendUserModel.remarksEmail];
            }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1)
    {
        NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.backgroundColor = kControlBgColor;
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(kDefaultMargin, kDefaultMargin, cell.frame.size.width - 2 * kDefaultMargin, kButtonHeight);
        [confirmBtn setBackgroundImage:IMAGE(@"exit_button_bg") forState:UIControlStateNormal];
        [confirmBtn setTitle:StringDelete forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [confirmBtn addTarget:self action:@selector(deleteFriend) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:confirmBtn];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    
    if (section == 1)
    {
        height = kDefaultMargin;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.section == 0)
    {
        height = kMenuHeight;
    }
    else
    {
        height = 80;
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
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringRemarksName andDefaultText:self.friendUserModel.remarksName];
                modifyControl.userModel = self.friendUserModel;
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 1:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringRemarksEmail andDefaultText:self.friendUserModel.remarksEmail];
                modifyControl.userModel = self.friendUserModel;
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            default:
                break;
        }
    }
}


@end
