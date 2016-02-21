//
//  CXUserDetailViewController.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserDetailViewController.h"
#import "CXUserDetailFunctionCell.h"
#import "CXUserDetailCell.h"
//#import "CXAddTaskViewController.h"
#import "SJAvatarBrowser.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "CXEditRemarksViewController.h"

@interface CXUserDetailViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation CXUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringUserDetail;
    self.isRequest = 0;
    
    [self initRightBarButton];
    
    NSArray * datas;
    if (_userModel && ![_userModel.remarksEmail isEmpty] &&_isFriend == 1)
    {
        datas = [[NSArray alloc] initWithObjects:
                 StringRemarksEmail,
                 StringAddress,
                 StringSignaute,
                 StringMail,
                 StringFunctions,
                 nil];

    }
    else
    {
        datas = [[NSArray alloc] initWithObjects:
                 StringAddress,
                 StringSignaute,
                 StringMail,
                 StringFunctions,
                 nil];
    }
    
    _sourceDatas = datas;
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height - 2 * kDefaultMargin);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    CGRect headFrame = CGRectMake(0, 0, self.view.frame.size.width, kUserDetailHeadHeight);
    _headView = [[CXUserDetailHeadView alloc] initWithFrame:headFrame];
    _headView.userModel = _userModel;
    _tableView.tableHeaderView = _headView;
    
    __unsafe_unretained CXUserDetailViewController *weak_self = self;
    _headView.clickHeadImageBlk = ^{
        // 点击头像
        [weak_self clickHeadImageAction];
    };
    
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

#pragma mark - UI mark

- (void) initRightBarButton
{
    UIButton *funBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    funBtn.frame = CGRectMake(0, 0, 30, 30);
    [funBtn setImage:IMAGE(@"more_icon_normal") forState:UIControlStateNormal];
    [funBtn addTarget:self action:@selector(userFunction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:funBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
    
}

#pragma mark - notification
- (void)editRemarksNameNotification:(NSNotification *)notification
{
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    
    self.userModel.remarksName = name;
    
    _headView.userModel = _userModel;
//    [self.tableView reloadData];
}

- (void)editRemarksEmailNotification:(NSNotification *)notification
{
    NSString *name=nil;
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        name = notification.object;
    }
    
    self.userModel.remarksEmail = name;
    
    [self.tableView reloadData];
}


#pragma mark - private methods

- (void)userFunction:(UIButton *)button
{
    CXEditRemarksViewController *editControl = [[CXEditRemarksViewController alloc] init];
    editControl.friendUserModel = self.userModel;
    [self.navigationController pushViewController:editControl animated:YES];
}


// 点击头像，弹出大图
- (void) clickHeadImageAction
{
    [SJAvatarBrowser showImage:self.headView.headImageView];
}

// 点击功能按钮中的添加好友
- (void) clickAddFriendBtn
{
    [self sendAddFriend];
}

// 点击功能按钮中的指派
- (void) clickAddAppointBtn
{
//    CXTaskModel *taskModel = [[CXTaskModel alloc] init];
//    taskModel.performUserId = self.userModel.userId;
//    taskModel.performUser = self.userModel;
//    
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *  strDate = [dateformatter stringFromDate:senddate];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:MM:SS"];
//    NSString *  strCreateTime = [dateformatter stringFromDate:senddate];
//    
//    taskModel.planDate = strDate;
//    taskModel.planTime = @"18:00";
//    taskModel.createDate = strCreateTime;
//
//    CXAddTaskViewController *addTaskViewCtrl = [[CXAddTaskViewController alloc] initWithTaskModel:taskModel];
//    addTaskViewCtrl.isAddCooperate = true;
//    [self.navigationController pushViewController:addTaskViewCtrl animated:YES];
}

// 点击功能按钮中的汇报
- (void) clickAddReportBtn
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        alertView.tag = 101;
        [alertView show];
        return;
    }
    if (![mailClass canSendMail]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您没有设置邮件账户，请到邮件中设置！"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        alertView.tag = 102;
        [alertView show];
        return;
    }
    
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"任务汇报"];
    //添加收件人
    NSString *mail = self.userModel.userName;
    if (![NSString isBlankString:self.userModel.remarksEmail])
    {
        mail = self.userModel.remarksEmail;
    }
    else if (![NSString isBlankString:self.userModel.mail])
    {
        mail = self.userModel.mail;
    }

    NSArray *toRecipients = [NSArray arrayWithObject: mail];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailPicker setCcRecipients:ccRecipients];
    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailPicker setBccRecipients:bccRecipients];
    
    // 添加一张图片
    //    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    //    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    //    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件
    //    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
    //    NSData *pdf = [NSData dataWithContentsOfFile:file];
    //    [mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
    
    //    NSString *emailBody =   @"<font color='red'>任务：</font> " +  self.taskModel.content;
    NSString *emailBody = [self.userModel getDisplayName];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    //    [self presentModalViewController: mailPicker animated:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - network data

- (void) getUserInfoFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"userId" andLongValue:_userModel.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USERINFO result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"add friend success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                _userModel = mainPlate.anyModels[0];
                
                [self.tableView reloadData];
            }
        }
        else
        {
            XLog(@"add friend fail");
        }
    }];
}

- (void) sendAddFriend
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
//    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    [parametersUtil appendParameterWithName:@"friendId" andLongValue:_userModel.userId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_ADDFRIEND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        self.HUD.hidden = YES;
        
        if(!err)
        {
            XLog(@"add friend success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                NSInteger isFrined = 0;
                if ([mainPlate.anyModels count] > 0)
                {
                    NSString *strIsFriend = [mainPlate.anyModels objectAtIndex:0];
                    isFrined = [strIsFriend integerValue];
                }
                
                if (isFrined == 3)
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"你们已经是好友了。";
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }
                else
                {
                    // 成功
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"申请好友发送成功，请等待对方通过。";
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                    self.isRequest = 1;
                    [self.tableView reloadData];
                    
                    NSString *str = [NSString stringWithFormat:@"%ld", self.userModel.userId];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADDFRIEND_MYREQUEST object:str];
                }
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"申请好友失败，请稍待再试。";
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"add friend fail");
        }
    }];
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
    static NSString *UserDetailCellIdentifier = @"UserDetailCellIdentifier";
    CXUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:UserDetailCellIdentifier];
    if (cell == nil) {
        cell = [[CXUserDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserDetailCellIdentifier];
    }
    
    if (_isFriend && ![_userModel.remarksEmail isEmpty])
    {
        switch (indexPath.row) {
            case 0:
            {
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent:_userModel.remarksEmail];
            }
                break;
            case 1:
            {
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent:_userModel.address];
            }
                break;
            case 2:
            {
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent:_userModel.signature];
            }
                break;
            case 3:
            {
                NSString *mail = [NSString isBlankString:_userModel.mail] ? _userModel.userName : _userModel.mail;
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent: mail];
            }
                break;
            case 4:
            {
                static NSString *FunctionCellIdentifier = @"FunctionCellIdentifier";
                CXUserDetailFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCellIdentifier];
                if (cell == nil) {
                    cell = [[CXUserDetailFunctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FunctionCellIdentifier];
                }
                
                [cell setIsFriend:_isFriend andIsRequest:self.isRequest];
                
                __unsafe_unretained CXUserDetailViewController *weak_self = self;
                cell.addFriendBtnBlk = ^{
                    [weak_self clickAddFriendBtn];
                };
                
                cell.addAppointBtnBlk = ^{
                    [weak_self clickAddAppointBtn];
                };
                
                cell.addReportBtnBlk = ^{
                    [weak_self clickAddReportBtn];
                };
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent:_userModel.address];
            }
                break;
            case 1:
            {
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent:_userModel.signature];
            }
                break;
            case 2:
            {
                NSString *mail = [NSString isBlankString:_userModel.mail] ? _userModel.userName : _userModel.mail;
                [cell setTitle:[_sourceDatas objectAtIndex:indexPath.row] andContent: mail];
            }
                break;
            case 3:
            {
                static NSString *FunctionCellIdentifier = @"FunctionCellIdentifier";
                CXUserDetailFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCellIdentifier];
                if (cell == nil) {
                    cell = [[CXUserDetailFunctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FunctionCellIdentifier];
                }
                
                [cell setIsFriend:_isFriend andIsRequest:self.isRequest];
                
                __unsafe_unretained CXUserDetailViewController *weak_self = self;
                cell.addFriendBtnBlk = ^{
                    [weak_self clickAddFriendBtn];
                };
                
                cell.addAppointBtnBlk = ^{
                    [weak_self clickAddAppointBtn];
                };
                
                cell.addReportBtnBlk = ^{
                    [weak_self clickAddReportBtn];
                };
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            default:
                break;
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = kMenuHeight;
    
    if (_isFriend && ![_userModel.remarksEmail isEmpty])
    {
        if (indexPath.row == 4)
        {
            height = (kLargeMargin + kButtonHeight) * 3 + kDefaultMargin;
        }
    }
    else
    {
        if (indexPath.row == 3)
        {
            height = (kLargeMargin + kButtonHeight) * 2 + kDefaultMargin;
        }
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"您已取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"您已成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"邮件已发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.yOffset = -50;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


@end
