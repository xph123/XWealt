//
//  CXRecommentViewController.m
//  XWealth
//
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXRecommentViewController.h"
#import "CXMyRecommentCell.h"
#import "AddressBookHelper.h"

@interface CXRecommentViewController ()<CXRecommentTableViewDelegate>

@end

@implementation CXRecommentViewController
{
    CXRecommentModel *_recommentModel;
    NSIndexPath *_cellIndexPath;
}
- (id) initWithRedgisterList:(NSMutableArray *) registeredList
{
    if (self = [super init])
    {
        self.recommentList = registeredList;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = kControlBgColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = StringInvitation;
    
//    [self initRightBarButton];
    
    _contactList = [NSMutableArray array];
    
    CGRect talbeFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -kViewEndSizeHeight);
    
    CXRecommentTableView *friendTable = [[CXRecommentTableView alloc] initWithFrame:talbeFrame];
    
    friendTable.delegate = self;
    //添加搜索
    friendTable.NameSearchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:friendTable.NameSearchBar contentsController:self];
    friendTable.NameSearchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    friendTable.NameSearchDisplayController.searchResultsTableView.backgroundColor = kControlBgColor;
    friendTable.NameSearchDisplayController.searchResultsTableView.sectionIndexBackgroundColor = kControlBgColor;
    [friendTable setSearchbar:^{
        
    }];
    friendTable.tableView.tableHeaderView=friendTable.NameSearchBar;
    //[self.view addSubview:friendTable.NameSearchBar];
    //[friendTable addSubview:friendTable.NameSearchBar];
    self.tableView = friendTable;
    [self.view addSubview:self.tableView];
    
    
    
    self.contactDic = [AddressBookHelper getAllContact];
    
    NSArray* allKeys = [self.contactDic allKeys];
    for (NSString *key in allKeys)
    {
        NSString *phone = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([XStringHelper isValidateTelePhone:phone]) // 有效的手机号码
        {
            CXRecommentModel *recommentModel = [[CXRecommentModel alloc] init];
            recommentModel.name = [[self.contactDic objectForKey:key] stringByReplacingOccurrencesOfString:@" " withString:@""];
            recommentModel.phone = phone;
            recommentModel.type = 1;
            recommentModel.state = [self getRegisterState:phone];
            [self.contactList addObject:recommentModel];
        }
    }
    
    [self.tableView configData:self.contactList];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.navigationController=self.navigationController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private methods

- (void) initRightBarButton
{
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 60, 30);
    [releaseBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = kMiddleTextFont;
    [releaseBtn setTitle:StringInvitationAll forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(invitationAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}



- (void) invitationAllBtnClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:StringPrompt message:StringInvitationAllPrompt delegate:self cancelButtonTitle:StringCencle otherButtonTitles:StringCertain, nil];
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self sendRecommentAll];
    }
}


- (int) getRegisterState:(NSString*)phone
{
    int state = 0;
    
    for (CXRecommentModel *model in self.recommentList)
    {
        if ([phone isEqualToString:model.phone])
        {
            state = model.state;
            break;
        }
    }
             
    return state;
}

- (NSString *) markNameString
{
    // 这里把名字组织成“user,user2,user3”形式
    NSString *strName = @"";
    for (CXRecommentModel *model in self.contactList)
    {
        if (model.state == 0)
        {
            strName = [NSString stringWithFormat:@"%@,%@", strName, model.name];
        }
    }
    
    if (strName.length > 0)
    {
        strName = [strName substringWithRange:NSMakeRange(1, strName.length  - 1)];
    }

    return strName;
}

- (NSString *) markPhoneString
{
    // 这里把名字组织成“user,user2,user3”形式
    NSString *strName = @"";
    for (CXRecommentModel *model in self.contactList)
    {
        if (model.state == 0)
        {
            strName = [NSString stringWithFormat:@"%@,%@", strName, model.phone];
        }
    }
    
    if (strName.length > 0)
    {
        strName = [strName substringWithRange:NSMakeRange(1, strName.length  - 1)];
    }
    
    return strName;
}


#pragma mark - data & network data


- (void)sendRecommentFriend:(CXRecommentModel*)model andIndex:(NSIndexPath *)indexPath
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];

    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"phone" andStringValue:model.phone];
    [parametersUtil appendParameterWithName:@"name" andStringValue:model.name];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_USER_RECOMMENT_CONTRACT result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify recomment success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                _recommentModel=model;
                _cellIndexPath=indexPath;
                // 成功
                //[self ShowProgressHUB:@"已成功发送推荐邀请！"];
                 [self showMessageView:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",kAppDelegate.currentUserModel.userName], nil] title:@"test" body:[NSString stringWithFormat:@"掌富宝APP是理财师的好帮手，用户理财的好工具，10元起投信托。您可通过网址：http://www.gsycf.com/mobile/download.jsp  直接下载注册使用。"]];
                
//                [self showMessageView:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",kAppDelegate.currentUserModel.userName], nil] title:@"test" body:[NSString stringWithFormat:@"尊敬的%@用户，%@邀请您体验掌富宝APP。您可通过网址：http://www.gsycf.com/直接下载注册使用；掌富宝APP是理财师的好帮手，用户理财的好工具，10起投信托。",model.phone,kAppDelegate.currentUserModel.userName]];
                CXMyRecommentCell *cell = (CXMyRecommentCell *)[_tableView.tableView cellForRowAtIndexPath:indexPath];
                
                if (cell != nil)
                {
                    [cell.recommentBtn setBackgroundColor:kColorGrayLight];
                    [cell.recommentBtn setTitle:StringInvitationed forState:UIControlStateNormal];
                }
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_ME_RECOMMENT object:nil userInfo:nil];
            }
        }
        else
        {
            // 失败
            [self ShowProgressHUB:@"" andMsg:(NSString*)err];
        }
    }];
}

- (void)sendRecommentAll
{
    if (self.contactList && self.contactList.count == 0)
    {
        [self ShowProgressHUB:@"没有通讯录好友！"];
        return;
    }
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"phone" andStringValue:[self markPhoneString]];
    [parametersUtil appendParameterWithName:@"name" andStringValue:[self markNameString]];

    
    [CXDataCenter submitParmas:parametersUtil.parameters strURL:GET_USER_RECOMMENT_ALLCONTRACT result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify recomment success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                [self ShowProgressHUB:@"已成功发送推荐邀请！"];
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_ME_RECOMMENT object:nil userInfo:nil];
            }
        }
        else
        {
            // 失败
            [self ShowProgressHUB:(NSString*)err];
        }
    }];
}


#pragma markCXRecommentTableViewDelegate

- (void) recommentFriend:(CXRecommentModel*)model andIndex:(NSIndexPath *)indexPath
{

    if (![XStringHelper isValidateTelePhone:model.phone])
    {
        [self ShowProgressHUB:StirngRecommentValidPhone];
        return;
    }
    [self sendRecommentFriend:model andIndex:indexPath];

    
}
#pragma mark-MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            NSLog(@"信息传送成功");
            [self ShowProgressHUB:@"已成功发送推荐邀请！"];
            break;
        case MessageComposeResultFailed:
            //信息传送失败
             NSLog(@"信息传送失败");
            [self ShowProgressHUB:@"信息传送失败！"];
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
             NSLog(@"信息被用户取消传送");
            [self ShowProgressHUB:@"信息被用户取消传送！"];

            break;
        default:
            break;
    }
}
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor blackColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return YES;
//}

@end
