//
//  CXSettingViewController.m
//  Link
//
//  Created by chx on 14-12-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXSettingViewController.h"
#import "XNormalCell.h"
#import "CXLoginViewController.h"
#import "CXAboutViewController.h"
#import "CXFeedbackViewController.h"
#import "CXResetPasswordViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
@interface CXSettingViewController ()

@end

@implementation CXSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringSetting;
    
    NSArray * datas = [[NSArray alloc] initWithObjects:
                       StringEditPassword,
                       StringFeedback,
//                       StringUseHelper,
                       StringClearAll,
                       StringAboutUs,
                       StringServicePhone,
                       StringExitAccount,
  
                       nil];
    _sourceDatas = datas;
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

#pragma mark - private methods

- (void) exitApp
{
    [self sendLogout];
    
//    //先删除之前登录的人的信息
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *filename = kAppDelegate.userPlistFileName;
//
//    if ([[filename pathExtension] isEqualToString:@"plist"])
//    {
//        [fileManager removeItemAtPath:filename error:nil];
//    }
//    
//    [kAppDelegate EnterLoginView];
//    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//    [self presentViewController:loginViewController animated:NO completion:nil];
}

#pragma mark - network data

// 用户退出
- (void) sendLogout
{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = StringLogouting;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParamsForLogin:parametersUtil.parameters strURL:GET_LOGOUT result:^(CXMainPlate *mainPlate, NSError *err) {
        [self.HUD hide:YES];
        
        if(!err)
        {
            kAppDelegate.hasLogined = NO;
            XLog(@"logout success");
            
            //先删除之前登录的人的信息
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *filename = kAppDelegate.userPlistFileName;
           
            if ([[filename pathExtension] isEqualToString:@"plist"])
            {
                [fileManager removeItemAtPath:filename error:nil];
                 kAppDelegate.currentUserInfoFileName=@"";
                filename=@"";

            }
            kAppDelegate.currentUserModel=nil;
            [kAppDelegate LogoutEnterMainView];
            [kAppDelegate getUserData:NO];
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString*)err;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
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
    static NSString *MeMenuCellIdentifier = @"MeMenuCellIdentifier";
    
    if (indexPath.row == 5)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeMenuCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeMenuCellIdentifier];
        }
        
        cell.backgroundColor = kControlBgColor;
        
        CGRect bgFrame = CGRectMake(0, kDefaultMargin, kScreenWidth, kMenuHeight - 2 * kDefaultMargin);
        
        UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
        bgView.backgroundColor = kColorWhite;
        [cell addSubview:bgView];
        
        CGRect frame = CGRectMake(0, 0, kScreenWidth - 2 * kDefaultMargin, kMenuHeight - 2 * kDefaultMargin);
        UILabel *contentLable = [[UILabel alloc]initWithFrame:frame];
        contentLable.text = [_sourceDatas objectAtIndex:indexPath.row];
        contentLable.font = kLargeTextFont;
        contentLable.textColor = kButtonColor;
        contentLable.textAlignment = NSTextAlignmentCenter;
        contentLable.numberOfLines = 1;
        [bgView addSubview:contentLable];
        
        cell.selectionStyle = NO;
        
        return cell;
    }
    
    XNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:MeMenuCellIdentifier];
    if (cell == nil) {
        cell = [[XNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeMenuCellIdentifier];
    }
    
    cell.title =[_sourceDatas objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            CXResetPasswordViewController *resetPwControl = [[CXResetPasswordViewController alloc] init];
            [self.navigationController pushViewController:resetPwControl animated:YES];
        }
            break;
        case 1:
        {
            CXFeedbackViewController *aboutControl = [[CXFeedbackViewController alloc] init];
//            aboutControl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutControl animated:YES];
        }
            break;
//        case 2:
//        {
//            [self shareToOtherButtonClick];
//        }
//            break;
        case 2:
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:StringExit message:@"你确定要删除缓存吗？" delegate:self cancelButtonTitle:StringCencle otherButtonTitles:StringCertain, nil];
            alert.tag=100;
            [alert show];
            
            
            
            
    

            
        }
            break;
        case 3:
        {
            CXAboutViewController *aboutControl = [[CXAboutViewController alloc] init];
            NSString *aboutUrl=@"/util/AboutUs.action?p=2";
            aboutControl.connectionUrl=[kBaseURLString stringByAppendingString:aboutUrl];
            //            aboutControl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutControl animated:YES];
        }
            break;
        case 4:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008955056"]];
        }
            break;
        case 5:
        {
            [self exitButtonClice];
        }
            break;
        default:
            break;
    }
    
    
}
- (void) exitButtonClice
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:StringExit message:StringExitPrompt delegate:self cancelButtonTitle:StringCencle otherButtonTitles:StringCertain, nil];
    alert.tag=101;
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        switch (buttonIndex) {
            case 1:
            {
                NSFileManager *fileManager=[NSFileManager defaultManager];
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *Path=[paths[0] stringByAppendingPathComponent:@"projectFile"];
                NSString *messagesPath=[paths[0] stringByAppendingPathComponent:@"messages"];
                // 存在
                if ([fileManager fileExistsAtPath:Path]||[fileManager fileExistsAtPath:messagesPath])
                {
                    [fileManager removeItemAtPath:Path error:nil];
                    [fileManager removeItemAtPath:messagesPath error:nil];
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = StringPrompt;
                    hud.detailsLabelText = StringProdutClear;
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:2];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFION_OFFLINE_NEW_PROMPT object:nil];

                }
                //不存在
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = StringPrompt;
                    hud.detailsLabelText = StringProdutClear;
                    hud.yOffset = -50;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:2];
                }
            }
                
                break;
                
            default:
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            [self exitApp];
        }
    }

}



- (void) shareToOtherButtonClick
{
    NSString *content = StringAdvertising;
    NSString *url = [NSString stringWithFormat:@"%@%ld", @"http://www.gsycf.com/wealth/system/share?userId=", kAppDelegate.currentUserModel.userId];
    
    id<ISSCAttachment> imagePath;

    imagePath = [ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon-120" ofType:@"png"]];
   
    NSString *strTitle = StringAppName;
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:imagePath
                                                title:strTitle
                                                  url:url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    NSString *strWXTitle=[strTitle stringByAppendingString:[NSString stringWithFormat:@" | %@",content]];
    //定制微信朋友圈分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInt:2
                                                   ] content:content title:strWXTitle url:url thumbImage:imagePath image:imagePath musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    //定制qq空间分享
    [publishContent addQQSpaceUnitWithTitle:strTitle url:url site:nil fromUrl:url comment:nil summary:content image:imagePath type:[NSNumber numberWithInt:2]  playUrl:nil nswb:nil];
    
    NSArray *shareList;
    if (![QQApiInterface isQQInstalled]) {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeSMS,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType: ShareTypeWeixiSession, ShareTypeWeixiTimeline,  nil];
        }
    }
    else {
        if(![WXApi isWXAppInstalled]) {
            shareList = [ShareSDK getShareListWithType: ShareTypeQQSpace, ShareTypeQQ,  nil];
        }
        else {
            shareList = [ShareSDK getShareListWithType: ShareTypeQQSpace, ShareTypeWeixiSession, ShareTypeWeixiTimeline, ShareTypeQQ,  nil];
        }
    }

    
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateBegan)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                                }
                                if (state == SSResponseStateSuccess)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//                                    XLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                                    hud.mode = MBProgressHUDModeText;
                                    hud.labelText = [NSString stringWithFormat:@"分享失败:%@", [error errorDescription]];
                                    hud.removeFromSuperViewOnHide = YES;
                                    [hud hide:YES afterDelay:1];
                                    
                                }
                            }];
    
}
@end
