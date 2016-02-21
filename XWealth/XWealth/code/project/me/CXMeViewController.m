//
//  CXMeViewController.m
//
//  Created by chx on 14-9-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXMeViewController.h"
#import "CXMeMenuCell.h"
#import "CXModifyPersonalInfoViewController.h"
#import "CXSettingViewController.h"
#import "CXWebViewController.h"
#import "CXMySubscribeViewController.h"
#import "CXMyReleaseViewController.h"
#import "CXAboutViewController.h"
#import "CXMyAttentionViewController.h"
#import "CXMyRecommentViewController.h"
#import "CXModifyTextFieldViewController.h"
#import "CXMyIntegralViewController.h"
#import "CXLoginViewController.h"
#import "CXMyTrackViewController.h"
#import "CXMyBenefitReleaseViewController.h"
#import "CXMyAccountViewController.h"
#import "CXMyCollectionViewController.h"
#import "CXPopularActivityViewController.h"
#import "CXMyBuybackViewController.h"
#import "CXMyshareApp2ViewController.h"
#import "CXTradingCenterViewController.h"
#import "CXMyFinanciersViewController.h"
#import "CXMyNewsViewController.h"
@interface CXMeViewController ()

@end

#define ImageHight 200

@implementation CXMeViewController
{
    int _yOffSet; //偏移量
    BOOL _yOffSetBool;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    _yOffSet=0;
    _yOffSetBool=YES;
    [self initLeftBarButton];
    [self initRightBarButton];
    

    _oneDatas = [[NSArray alloc] initWithObjects:
                    StringMyAccount,
                    nil];

    _oneImageDatas= [[NSArray alloc] initWithObjects:
                   @"myXintuobao",
                   nil];

    _twoDatas = [[NSArray alloc] initWithObjects:
                    StringMyScore,
                    nil];
    _twoImageDatas = [[NSArray alloc] initWithObjects:
                         @"myIntegral",
                         nil];

    
    _thereDatas = [[NSArray alloc] initWithObjects:
                   StringMyFollow,
                   nil];
    
    _thereImageDatas = [[NSArray alloc] initWithObjects:
                        @"myAttention",
                        nil];
    
    
    _fourDatas = [[NSArray alloc] initWithObjects:
                    StringMyRecommend,
                    nil];
    
    _fourImageDatas = [[NSArray alloc] initWithObjects:
                    @"myRecomment",
                    nil];
    _fiveDatas = [[NSArray alloc] initWithObjects:
                  StringUseHelper,
                  nil];
    
    _fiveImageDatas = [[NSArray alloc] initWithObjects:
                       @"my_Recomment",
                       nil];
    _sixDatas = [[NSArray alloc] initWithObjects:
                  StringSetting,
                  nil];
    
    _sixImageDatas = [[NSArray alloc] initWithObjects:
                       @"mySet",
                       nil];

   
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.size.height -=  kTabBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgTableViewColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
//    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
   

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationModifyUserHead)
                   name:NOTIFICATION_ME_MODIFY_USERHEAD
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationModifyUserInfo)
                   name:NOTIFICATION_ME_MODIFY_USERINFO
                 object:nil];
    [center addObserver:self
               selector:@selector(appWillEnterForegroundNotification)
                   name:NOTIFICATION_ENTRY_FOREGROUND
                 object:nil];
    [center addObserver:self selector:@selector(notificationNewsRed) name:NOTIFION_OFFLINE_NEW_PROMPT object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initheadView];
    if (_yOffSet<=kMeOffSetHiight) {
        UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
        [nav setAlpha:YES andAnimation:NO];
        [nav.navigationBar setTranslucent:YES];
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:NO andAnimation:NO];
//    [nav setRecoverySystemStyle:YES];
    if (kIsIOS7OrLater && !kIsIOS7Dot2Before)
    {
          [nav.navigationBar setTranslucent:NO];
    }

  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initheadView
{
    if (_accountModel==nil) {
        // 我的现金券和邀请返利需要信托宝url
        [self loadUserFundFromServer];
    }
    [self initRightBarButton];
    
    if (kAppDelegate.hasLogined==YES) {
        CGRect headFrame = CGRectMake(0, 0, self.view.frame.size.width, kMeHeadHeight + kDefaultMargin);
        _headView = [[CXMeHeaderView alloc] initWithFrame:headFrame];
        _headView.userModel = kAppDelegate.currentUserModel;
        _tableView.tableHeaderView = _headView;
        __unsafe_unretained CXMeViewController *weak_self = self;
        _headView.changeHeaderBgImageBlk = ^{
            // 修改背影图片
            [weak_self changeHeaderBgImage];
        };
        _headView.changeHeadImageBlk = ^{
            // 修改头像
            [weak_self changeHeadImage];
        };
        _headView.myInfoBlk = ^{
            // 修改头像
            [weak_self editMyInfo];
        };
        _headView.leftBlk= ^{
            [weak_self leftInfo];
        };
        _headView.centerBlk= ^{
            [weak_self centerInfo];
        };
        _headView.rightBlk= ^{
            [weak_self rightInfo];
        };
    }
    else
    {
        CGRect headFrame = CGRectMake(0, 0, self.view.frame.size.width, kMeHeadHeight + kDefaultMargin);
        _headView = [[CXMeHeaderView alloc] initWithFrame:headFrame];
        _headView.userModel = kAppDelegate.currentUserModel;
        _tableView.tableHeaderView = _headView;
        __unsafe_unretained CXMeViewController *weak_self = self;
        _headView.changeHeaderBgImageBlk = ^{
            // 修改背影图片
            [weak_self changeHeaderBgImage];
        };
        _headView.changeHeadImageBlk = ^{
            // 修改头像
            [weak_self changeHeadImage];
        };
        _headView.myInfoBlk = ^{
            // 修改头像
            [weak_self editMyInfo];
        };
        _headView.leftBlk= ^{
            [weak_self leftInfo];
        };
        _headView.centerBlk= ^{
            [weak_self centerInfo];
        };
        _headView.rightBlk= ^{
            [weak_self rightInfo];
        };
        
    }
    
    [self.tableView reloadData];
}
- (void) initLeftBarButton
{
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(0, 0, 20, 20);
    [logoImage setImage:IMAGE(@"")];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:logoImage];
    [self.navigationItem setLeftBarButtonItems:@[leftBar]];
}
- (void) initRightBarButton
{
    
    UIButton *myNewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myNewsBtn.frame = CGRectMake(0, 0, 30, 30);
    [myNewsBtn setImage:IMAGE(@"myMessage") forState:UIControlStateNormal];
    myNewsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [myNewsBtn addTarget:self action:@selector(myNewsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    BOOL messageBool=NO;
    if (kAppDelegate.hasLogined) {
        
        messageBool=[CXReceiveMessages querytableUnread:kAppDelegate.currentUserModel.userName];
    }
    else
    {
        messageBool=[CXReceiveMessages querytableUnread:@"publicFile"];
    }
        if (messageBool) {
            UIImageView *promptView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 14, 14)];
            promptView.backgroundColor=[UIColor redColor];
            promptView.clipsToBounds=YES;
            promptView.layer.cornerRadius=7;
            //    promptView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [myNewsBtn addSubview:promptView];
    }

    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:myNewsBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}


#pragma mark - notification
- (void) notificationModifyUserHead
{
    _headView.userModel = kAppDelegate.currentUserModel;
}

- (void) notificationModifyUserInfo
{
    _headView.userModel = kAppDelegate.currentUserModel;
}
-(void) notificationNewsRed
{
    [self initRightBarButton];
}
- (void) appWillEnterForegroundNotification
{
    NSLog(@"trigger event when will enter foreground.");
    
    // 如果有网络，取同步数据
    if (kAppDelegate.networkState > 0)
    {
       [self initheadView];
    }
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofRows = 0;
    
    if (0 == section)
    {
        numberofRows = [self.oneDatas count];
    }
    else if(1 == section)
    {
        numberofRows = [self.twoDatas count];
    }
    else if(2 == section)
    {
        numberofRows = [self.thereDatas count];
    }
    else if (3 == section)
    {
        numberofRows = [self.fourDatas count];
    }
    else if (4 == section)
    {
        numberofRows = [self.fiveDatas count];
    }
    else if (5 == section)
    {
        numberofRows = [self.sixDatas count];
    }
    return numberofRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MeMenuCellIdentifier = @"MeMenuCellIdentifier";
    CXMeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:MeMenuCellIdentifier];
    if (cell == nil) {
        cell = [[CXMeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeMenuCellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_oneDatas.count-1) {
            
            cell.downlineBool=NO;
        }

        [cell setTitle:[_oneDatas objectAtIndex:indexPath.row] andImage:[_oneImageDatas objectAtIndex:indexPath.row] ];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_twoDatas.count-1) {
             cell.downlineBool=NO;
        }

        [cell setTitle:[_twoDatas objectAtIndex:indexPath.row] andImage:[_twoImageDatas objectAtIndex:indexPath.row] ];
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_thereDatas.count-1) {
             cell.downlineBool=NO;
        }

        [cell setTitle:[_thereDatas objectAtIndex:indexPath.row] andImage:[_thereImageDatas objectAtIndex:indexPath.row] ];
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_fourDatas.count-1) {
             cell.downlineBool=NO;
        }

        [cell setTitle:[_fourDatas objectAtIndex:indexPath.row] andImage:[_fourImageDatas objectAtIndex:indexPath.row] ];
    }
    else if (indexPath.section == 4)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_fiveDatas.count-1) {
             cell.downlineBool=NO;
        }
        
        [cell setTitle:[_fiveDatas objectAtIndex:indexPath.row] andImage:[_fiveImageDatas objectAtIndex:indexPath.row] ];
    }
    else if (indexPath.section == 5)
    {
        if (indexPath.row==0) {
            cell.uplineBool=NO;
        }
        if (indexPath.row==_sixDatas.count-1) {
            cell.downlineBool=NO;
        }
        
        [cell setTitle:[_sixDatas objectAtIndex:indexPath.row] andImage:[_sixImageDatas objectAtIndex:indexPath.row] ];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat  height=0;
    if (section>0) {
         height = kDefaultMargin;
    }
    
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kDefaultMargin)];
    headerView.backgroundColor=kControlBgColor;
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_accountModel.cashUrl);
    
    if (kAppDelegate.hasLogined == NO)
    {
        
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                //我的信托宝
                CXMyAccountViewController *myAccountControl=[[CXMyAccountViewController alloc]init];
                myAccountControl.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:myAccountControl animated:YES];

//                CXMyTrackViewController *myTrackcontroller=[[CXMyTrackViewController alloc]init];
//                myTrackcontroller.hidesBottomBarWhenPushed=YES;
//                [self.navigationController pushViewController:myTrackcontroller animated:YES];
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
                // 我的现金券
                CXWebViewController *webControl=[[CXWebViewController alloc]init];
                webControl.hidesBottomBarWhenPushed = YES;
                webControl.url = _accountModel.cashUrl;
                webControl.titleName=StringMyScore;
                [self.navigationController pushViewController:webControl animated:YES];

//                CXMyFinanciersViewController *myFinanciersControl=[[CXMyFinanciersViewController alloc]init];
//                myFinanciersControl.hidesBottomBarWhenPushed=YES;
//                [self.navigationController pushViewController:myFinanciersControl animated:YES];
            }
                break;
//            case 1:
//            {
//                
////                CXMyIntegralViewController *modifyControl = [[CXMyIntegralViewController alloc] init];
////                modifyControl.hidesBottomBarWhenPushed = YES;
////                [self.navigationController pushViewController:modifyControl animated:YES];
//            }
//                break;
//            case 2:
//            {
//                // 邀请返利
//                CXMyshareApp2ViewController *myShareApp=[[CXMyshareApp2ViewController alloc]init];
//                myShareApp.hidesBottomBarWhenPushed=YES;
//                myShareApp.titleName=StringShareApp2;
//                [self.navigationController pushViewController:myShareApp animated:YES];
//            }
//                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
            {
                //我的关注
                CXMyAttentionViewController *attentionControl = [[CXMyAttentionViewController alloc] init];
                attentionControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:attentionControl animated:YES];
            }
                break;
//            case 1:
//            {   //热门活动
//                CXPopularActivityViewController *popularActivityControl = [[CXPopularActivityViewController alloc] init];
//                popularActivityControl.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:popularActivityControl animated:YES];
//            }
//                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {//我的邀请
            CXMyRecommentViewController *myRecommentControl = [[CXMyRecommentViewController alloc] init];
            myRecommentControl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myRecommentControl animated:YES];
        }
//        else if (indexPath.row == 1)
//        {//我的关注
//            CXMyAttentionViewController *attentionControl = [[CXMyAttentionViewController alloc] init];
//            attentionControl.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:attentionControl animated:YES];
//        }
//        else if (indexPath.row == 2)
//        {//我的收藏
//            CXMyCollectionViewController *myCollectionControl = [[CXMyCollectionViewController alloc] init];
//            myCollectionControl.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myCollectionControl animated:YES];
//
//        }

    }
    if (indexPath.section == 4)
    {
        if (indexPath.row == 0)
        {
            CXAboutViewController *appDirectionView = [[CXAboutViewController alloc] init];
            NSString *aboutUrl=@"/util/appDirection.action?version=2.4";
            appDirectionView.connectionUrl=[kBaseURLString stringByAppendingString:aboutUrl];
            appDirectionView.hidesBottomBarWhenPushed = YES;
            appDirectionView.name=StringUseHelper;
            [self.navigationController pushViewController:appDirectionView animated:YES];
        }
    }
    if (indexPath.section == 5)
    {
        if (indexPath.row == 0)
        {
            CXSettingViewController *settingControl = [[CXSettingViewController alloc] init];
            settingControl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingControl animated:YES];
        }
    }

  
}

#pragma  mark - private methods


- (void) changeHeaderBgImage
{
   
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
//    self.changeImagetype = ChangeHeaderBgImageType;
//    _imagePickerController = [[UIImagePickerController alloc] init];
//    _imagePickerController.delegate = self;
//    _imagePickerController.allowsEditing = YES;
//    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void) changeHeadImage
{
    if (kAppDelegate.hasLogined == NO)
    {
               CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    self.changeImagetype = ChangeHeadImageType;
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"拍照", nil) otherButtonTitles:@"从相册选择", nil];
    }
    else
    {
        sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:NSLocalizedString(@"从相册选择", nil) otherButtonTitles:nil];
    }
    [sheet showInView:self.view];}

- (void)editMyInfo
{
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    CXModifyPersonalInfoViewController *modifyControl = [[CXModifyPersonalInfoViewController alloc] init];
    modifyControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:modifyControl animated:YES];
//    NSString *strRecomment = @"";
//    if (kAppDelegate.currentUserModel.recomment > 0)
//    {
//        strRecomment = [@(kAppDelegate.currentUserModel.recomment) stringValue];
//    }
//    CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringRecommendMe andDefaultText:strRecomment];
//    modifyControl.userModel = kAppDelegate.currentUserModel;
//    [self.navigationController pushViewController:modifyControl animated:YES];
}
- (void)leftInfo
{
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    CXTradingCenterViewController *modifyControl = [[CXTradingCenterViewController alloc] init];
    modifyControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:modifyControl animated:YES];

}

- (void)centerInfo
{
    
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    // 邀请有礼
    CXMyshareApp2ViewController *myShareApp=[[CXMyshareApp2ViewController alloc]init];
    myShareApp.hidesBottomBarWhenPushed=YES;
    myShareApp.titleName=StringShareApp2;
    [self.navigationController pushViewController:myShareApp animated:YES];

//    CXMyAccountViewController *myAccountControl=[[CXMyAccountViewController alloc]init];
//    myAccountControl.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:myAccountControl animated:YES];


}
- (void)rightInfo
{
    
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    //我的收藏
    CXMyCollectionViewController *myCollectionControl = [[CXMyCollectionViewController alloc] init];
    myCollectionControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myCollectionControl animated:YES];
}
- (void)myNewsClick:(UIButton *)button
{
    if (_yOffSetBool==NO) {
        return;
    }
//    if (kAppDelegate.hasLogined == NO)
//    {
//        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//        loginViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginViewController animated:YES];
//        return;
//    }
    
    CXMyNewsViewController *myNewsControl = [[CXMyNewsViewController alloc] init];
    myNewsControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myNewsControl animated:YES];

}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType=0;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex)
        {
            case 0:
            {
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
                break;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                // 取消
                return;
                break;
        }
    }
    else
    {
        switch (buttonIndex)
        {
            case 0:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1:
                // 取消
                return;
                break;
        }
    }
    // 跳转到相机或相册页面
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.sourceType = sourceType;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    UIImage* newImage=[[image fitSmallImage:CGSizeMake(kScreenWidth, kScreenHeight)] fixOrientation];
    //获取照片的原图
   // UIImage* originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取图片裁剪的图
    UIImage* editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //获取图片裁剪后，剩下的图
   // UIImage* cropImage = [info objectForKey:UIImagePickerControllerCropRect];
    NSData* data=UIImageJPEGRepresentation(editImage, 0.8);
    UIImage* anotherImg=[UIImage imageWithData:data];

    NSString *path = [XLocalImageCache tempSaveImageName];
    [data writeToFile:path atomically:YES];
    
    if (self.changeImagetype == ChangeHeadImageType)
    {
        [self upDateHeadeImage:anotherImg andTempFileName:path];
    }
    else {
        [self upDateHeaderBgImage:anotherImg andTempFileName:path];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void) loadUserFundFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_XINTUOBAO_FINDUSERFUND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"loadUserFundFromServer success");
            if ([mainPlate.anyModels count] > 0)
            {
                _accountModel = [mainPlate.anyModels objectAtIndex:0];
            }
        }
        else
        {
            XLog(@"loadUserFundFromServer fail");
        }
    }];
}

- (void) upDateHeaderBgImage:(UIImage *) image andTempFileName:(NSString *)fileName
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    
    [CXDataCenter sendFilesParams:parameters.parameters strURL:POST_ME_MODIFY_BGIMAGE formBlock:^(id<AFMultipartFormData> formData){
        if (image)
        {
            NSData* data=UIImagePNGRepresentation(image);
            // 随机产生一个文件名
            NSString* fileName=[NSString stringWithFormat:@"%@.png",[NSString getUniqueStrByUUID]];
            
            XLog(@"fileName is %@",fileName);
            
            [formData appendPartWithFileData:data name:@"uploads" fileName:fileName mimeType:@"image/png"];
        }
        
    } resultBlock:^(CXMainPlate *mainPlate,NSError* error)
     {
         self.HUD.hidden = YES;
         
         if (error)
         {
             XLog(@"修改背景图片失败");
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
             hud.mode = MBProgressHUDModeText;
             hud.labelText = PromptNoNetWork;
             hud.yOffset = -50;
             hud.removeFromSuperViewOnHide = YES;
             [hud hide:YES afterDelay:1];
         }else
         {
             if ([mainPlate.code integerValue] == 0)
             {
                 NSString *imageFileName = @"";
                 
                 if (fileName && fileName.length > 0)
                 {
                     imageFileName = mainPlate.anyModels[0];
                     
                     if (imageFileName && imageFileName.length > 0)
                     {
                         NSString *fullFileName = [CXURLConstants getFullStatusUrl:imageFileName];
                         UIImage *image = [UIImage imageWithContentsOfFile:fileName];
                         [XLocalImageCache saveImageToCache:[XLocalImageCache localImageCacheDirectory:kDirectoryOfImage] image: image imageName:fullFileName imageType:@"jpg"];
                         
                         XFileValue *file = [[XFileValue alloc] initWithFileName:kAppDelegate.currentUserInfoFileName];
                         [file setValue:imageFileName forKey:kParameterHeaderBgImage];
                         kAppDelegate.currentUserModel.statusBg = imageFileName;
                     }
                     
                     [XLocalImageCache deleteLocalImage:kDirectoryOfImage imageName:fileName];
                     
                     _headView.userModel = kAppDelegate.currentUserModel;
                 }
             }
             
             XLog(@"修改背景图片成功");
         }
     }];
}

- (void) upDateHeadeImage:(UIImage *) image  andTempFileName:(NSString *)fileName
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = StringSending;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    
    [CXDataCenter sendFilesParams:parameters.parameters strURL:POST_ME_MODIFY_USERHEAD formBlock:^(id<AFMultipartFormData> formData){
        if (image)
        {
            NSData* data=UIImagePNGRepresentation(image);
            // 随机产生一个文件名
            NSString* fileName=[NSString stringWithFormat:@"%@.png",[NSString getUniqueStrByUUID]];
            
            XLog(@"fileName is %@",fileName);
            
            [formData appendPartWithFileData:data name:@"uploads" fileName:fileName mimeType:@"image/png"];
        }
        
    } resultBlock:^(CXMainPlate *mainPlate,NSError* error)
     {
         self.HUD.hidden = YES;
         
         if (error)
         {
             XLog(@"修改头像失败");
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
             hud.mode = MBProgressHUDModeText;
             hud.labelText = PromptNoNetWork;
             hud.yOffset = -50;
             hud.removeFromSuperViewOnHide = YES;
             [hud hide:YES afterDelay:1];
         }else
         {
             if ([mainPlate.code integerValue] == 0)
             {
                 NSString *imageFileName = @"";
                 
                 if (fileName && fileName.length > 0)
                 {
                     imageFileName = mainPlate.anyModels[0];
                     
                     if (imageFileName && imageFileName.length > 0)
                     {
                         NSString *fullFileName = [CXURLConstants getFullHeaderUrl:imageFileName];
                         NSString *fullsltFileName = [CXURLConstants getFullSltHeaderUrl:imageFileName];
                         
                         UIImage *image = [UIImage imageWithContentsOfFile:fileName];
                         [XLocalImageCache saveImageToCache:[XLocalImageCache localImageCacheDirectory:kDirectoryOfImage] image: image imageName:fullFileName imageType:@"jpg"];
                         [XLocalImageCache saveImageToCache:[XLocalImageCache localImageCacheDirectory:kDirectoryOfImage] image: image imageName:fullsltFileName imageType:@"jpg"];
                         
                         XFileValue *file = [[XFileValue alloc] initWithFileName:kAppDelegate.currentUserInfoFileName];
                         [file setValue:imageFileName forKey:kParameterHeadImg];
                         kAppDelegate.currentUserModel.headImg = imageFileName;
                     }
                     
                     [XLocalImageCache deleteLocalImage:kDirectoryOfImage imageName:fileName];
                     
                     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                     [center postNotificationName:NOTIFICATION_ME_MODIFY_USERHEAD object:nil userInfo:nil];
                     
                 }
                 
             }
             
             XLog(@"修改头像成功");
         }
     }];
}
#pragma mark -- 滚动视图的代理方法
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    /**
     *  关键处理：通过滚动视图获取到滚动偏移量从而去改变图片的变化
     */
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    _yOffSet=yOffset;
    NSLog(@"%d",_yOffSet);
    if(yOffset >= kMeOffSetHiight) {


    UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
    [nav setAlpha:NO andAnimation:NO];
    [nav.navigationBar setTranslucent:YES];
    }
    
    if(yOffset <kMeOffSetHiight) {
        
        UDCustomNavigation *nav = (UDCustomNavigation *)self.navigationController;
        [nav setAlpha:YES andAnimation:NO];
        [nav.navigationBar setTranslucent:YES];
    }

    if (yOffset<0) {
        CGRect frame = self.headView.headBgImageView.frame;
        frame.origin.y = yOffset;
        frame.size.height =  -yOffset+165;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.headView.headBgImageView.frame = frame;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _yOffSetBool=NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _yOffSetBool=YES;
}
@end
