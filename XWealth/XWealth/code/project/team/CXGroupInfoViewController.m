//
//  CXGroupInfoViewController.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupInfoViewController.h"
#import "CXUserDetailViewController.h"
#import "CXModifyGroupNameViewController.h"
#import "CXModifyGroupDescViewController.h"
#import "CXSelectFriendViewController.h"

@interface CXGroupInfoViewController ()<SelectFriendViewDelegate>

@end

@implementation CXGroupInfoViewController

- (id) initWithGroupModel:(CXGroupModel*) groupModel
{
    self = [super init];
    
    if (self)
    {
        _groupModel = groupModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;

    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height - 2 * kDefaultMargin);
    self.groupInfoTableView = [[CXGroupInfoView alloc] initWithFrame:frame];
    self.groupInfoTableView.infoDelegate = self;
    [self.view addSubview:_groupInfoTableView];
    
    _managerModel = [[[CXDBHelper sharedDBHelper] getUserDao] queryUserWithUserId:self.groupModel.managerUserId];
    
    [self.groupInfoTableView configData:_groupModel andManager:_managerModel];
    
    [self userGroupGrade];
    
    // 游客不显示成员列表，但是显示右上角申请按钮
    if (_memberGrade == GROUP_GUEST)
    {
        [self initRightBarButton];
    }
    else
    {
        _memberList = [[[CXDBHelper sharedDBHelper] getGroupMemberDao] queryMembersWithGroupId:self.groupModel.groupID];
        
        [self markGroupMemberView:_memberList];
    }
    
    [self getGroupMembersFromServer];
    
    
//    CGRect headFrame = CGRectMake(0, 0, self.view.frame.size.width, kMeHeadHeight + kDefaultMargin);
//    _headView = [[CXMeHeaderView alloc] initWithFrame:headFrame];
//    _headView.userModel = kAppDelegate.currentUserModel;
//    _tableView.tableHeaderView = _headView;
//    
//    __unsafe_unretained CXMeViewController *weak_self = self;
//    _headView.changeHeaderBgImageBlk = ^{
//        // 修改背影图片
//        [weak_self changeHeaderBgImage];
//    };
//    _headView.changeHeadImageBlk = ^{
//        // 修改头像
//        [weak_self changeHeadImage];
//    };
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYNAME
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYLOGO
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationGroupModify)
                   name:NOTIFICATION_GROUP_MODIFYDESC
                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void) initRightBarButton
{
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(0, 0, 60, 30);
    [applyBtn setTitle:StringSave forState:UIControlStateNormal];
    applyBtn.titleLabel.font = kNavBarTextFont;
    [applyBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [applyBtn addTarget:self action:@selector(clickApplyBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:applyBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void) markGroupMemberView:(NSMutableArray *)memberList
{
    if ([memberList count] > 0)
    {
        if (_memberGrade == GROUP_MANAGER)
        {
            [memberList addObject:[self markAddMemberButton]];
        }
        _memberHeaderView = [[CXGroupMemberView alloc] initWithItems:memberList];
        _memberHeaderView.grideDelegate = self;
        CGRect headerTableFrame = CGRectMake(0, 0, kScreenWidth, [_memberHeaderView numberOfRows] * kGridCellHeight);
        CGRect headerFrame = CGRectMake(0, 0, kScreenWidth, [_memberHeaderView numberOfRows] * kGridCellHeight + kDefaultMargin);
        _memberHeaderView.frame = headerFrame;
        _memberHeaderView.table.frame = headerTableFrame;
        self.groupInfoTableView.tableView.tableHeaderView = _memberHeaderView;
    }

}

- (CXUserModel *) markAddMemberButton
{
    CXUserModel *userModel = [[CXUserModel alloc] init];
    userModel.nickName = @"添加";
    userModel.headImg = @"add_image";
    
    return userModel;
}

- (GroupGrade) userGroupGrade
{
    _memberGrade = GROUP_GUEST;
    
    if (kAppDelegate.currentUserModel.userId == self.groupModel.managerUserId)
    {
        _memberGrade = GROUP_MANAGER;
        return _memberGrade;
    }
    
    for (CXUserModel *model in _memberList)
    {
        if (model.userId == kAppDelegate.currentUserModel.userId)
        {
            _memberGrade = GROUP_MEMBER;
            break;
        }
    }
    
    return _memberGrade;
}

#pragma mark - notification
- (void) notificationGroupModify
{
    _groupModel =  [[[CXDBHelper sharedDBHelper] getGroupDao] queryGroupWithGroupId:_groupModel.groupID];
    [self.groupInfoTableView configData:_groupModel andManager:_managerModel];
}

#pragma mark - network data

- (void)getGroupMembersFromServer
{
    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"id" andLongValue:self.groupModel.groupID];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_GROUP_MEMBERS result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get friend list success");
            
            if (mainPlate.anyModels.count > 0)
            {
                _memberList = (NSMutableArray *)mainPlate.anyModels;
                
                if (_memberGrade != GROUP_GUEST)
                {
                    [self markGroupMemberView:_memberList];
                }
                
                [[[CXDBHelper sharedDBHelper] getGroupMemberDao] insertMembers:mainPlate.anyModels andGroupId:self.groupModel.groupID];
                [[[CXDBHelper sharedDBHelper] getUserDao] replaceIntoUsers:mainPlate.anyModels];
                
                // 如果第一次进入群详情，群主信息没有，抓到成员数据时，更新群主信息
                _managerModel = [[[CXDBHelper sharedDBHelper] getUserDao] queryUserWithUserId:self.groupModel.managerUserId];
                [self.groupInfoTableView configData:_groupModel andManager:_managerModel];
            }
        }
        else
        {
            XLog(@"get friend list fail");
        }
    }];
}


- (void) upDateGroupLogo:(UIImage *) image  andTempFileName:(NSString *)fileName
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    [parameters appendParameterWithName:@"id" andLongValue:self.groupModel.groupID];
    
    [CXDataCenter sendFilesParams:parameters.parameters strURL:POST_GROUP_MODIFYLOGO formBlock:^(id<AFMultipartFormData> formData){
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
             XLog(@"修改群图标失败");
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
                 XLog(@"修改群图标成功");

                self.groupModel = mainPlate.anyModels[0];
                 
                 // 缓存本地的图片到网络指定的路径下，并删除本地图片
                 if (fileName && fileName.length > 0
                     && self.groupModel.groupLogo && self.groupModel.groupLogo.length > 0)
                 {
                     [XLocalImageCache saveImageToCache:[XLocalImageCache localImageCacheDirectory:kDirectoryOfImage] image: image imageName:self.groupModel.groupLogo imageType:@"jpg"];
                     
                     [XLocalImageCache deleteLocalImage:kDirectoryOfImage imageName:fileName];
                 }

                     
                [[[CXDBHelper sharedDBHelper] getGroupDao] replaceIntoGroup:_groupModel];
                     
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_GROUP_MODIFYLOGO object:nil userInfo:nil];
             }
             else
             {
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                 hud.mode = MBProgressHUDModeText;
                 hud.labelText = @"修改群图标失败";
                 hud.yOffset = -50;
                 hud.removeFromSuperViewOnHide = YES;
                 [hud hide:YES afterDelay:1];
             }
         }
     }];
    
}


- (void)addGroupMembersToServer:(NSMutableArray *)friends
{

    // 这里把多个检视者组织成“userId,userId2,userId3”形式
    NSString *strMembers = @"";
    for (CXUserModel *user in friends)
    {
        if (user.userId > 0)
        {
            strMembers = [NSString stringWithFormat:@"%@,%ld", strMembers, user.userId];
        }
    }
    
    if (strMembers.length > 0)
    {
        strMembers = [strMembers substringWithRange:NSMakeRange(1, strMembers.length  - 1)];
    }

    // 更新是在后台处理，不需要显示加载框
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"id" andLongValue:self.groupModel.groupID];
    [parametersUtil appendParameterWithName:@"members" andStringValue:strMembers];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_GROUP_ADDMEMBER result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"add members success");
        }
        else
        {
            XLog(@"add members fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptNoNetWork;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];
}


#pragma mark - private methods
// 申请加入群
- (void)clickApplyBtn:(UIButton *)button
{
    
}

- (BOOL) isFriend:(CXUserModel*)model
{
    BOOL isFriend = false;
    
    NSMutableArray *array = [[[CXDBHelper sharedDBHelper] getFriendDao] queryFriends];
    
    for (CXUserModel *user in array)
    {
        if (model.userId == user.userId)
        {
            isFriend = true;
            break;
        }
    }
    
    return isFriend;
}


#pragma mark - CXGroupMemberViewDelegate

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    int index = rowIndex * kGridColumns + colIndex;
    
    if (_memberGrade == GROUP_MANAGER && index == [_memberList count] - 1)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < [_memberList count] - 1; i++)
        {
            [array addObject:[_memberList objectAtIndex:i]];
        }
        CXSelectFriendViewController *selectView = [[CXSelectFriendViewController alloc] init];
        selectView.alreadySelectFriends = array;
        selectView.delegate = self;
        selectView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:selectView animated:YES];
    }
    else
    {
        CXUserModel *userModel = [_memberList objectAtIndex:index];
        
        CXUserDetailViewController *userDetail = [[CXUserDetailViewController alloc] init];
        userDetail.userModel = userModel;
        userDetail.isFriend = [self isFriend:userModel];
        userDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userDetail animated:YES];
    }
}

#pragma mark - CXGroupInfoViewDelegate

- (void) changeGroupLogo
{
    if (_memberGrade == GROUP_MANAGER)
    {
        UIActionSheet *sheet;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
        }
        else
        {
            sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        [sheet showInView:self.view];
    }
}

- (void) changeGroupName
{
    if (_memberGrade == GROUP_MANAGER)
    {
        CXModifyGroupNameViewController *modifyControl = [[CXModifyGroupNameViewController alloc] initWithGroupModel:_groupModel];
        [self.navigationController pushViewController:modifyControl animated:YES];
    }
}

- (void) changeGroupDesc
{
    if (_memberGrade == GROUP_MANAGER)
    {
        CXModifyGroupDescViewController *modifyControl = [[CXModifyGroupDescViewController alloc] initWithGroupModel:_groupModel];
        [self.navigationController pushViewController:modifyControl animated:YES];
    }
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
                // 取消
                return;
            case 1:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 2:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else
    {
        switch (buttonIndex)
        {
            case 0:
                // 取消
                return;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage* newImage=[[image fitSmallImage:CGSizeMake(kScreenWidth, kScreenHeight)] fixOrientation];
    NSData* data=UIImageJPEGRepresentation(newImage, 0.6);
    UIImage* anotherImg=[UIImage imageWithData:data];
    
    NSString *path = [XLocalImageCache tempSaveImageName];
    [data writeToFile:path atomically:YES];
    
    [self upDateGroupLogo:anotherImg andTempFileName:path];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - SelectFriendViewDelegate

- (void)setMutableSelectedFriends:(NSMutableArray *)friends andType:(NSString*)type
{
    if (friends.count > 0)
    {
        if ([_memberList count] > 0)
        {
//            // 删除“添加”按钮
//            if (_memberGrade == GROUP_MANAGER)
//            {
//                [_memberList removeObjectAtIndex:[_memberList count] - 1];
//            }
//            // 添加新加的好友
//            [_memberList addObjectsFromArray:friends];
            
            [_memberList removeAllObjects];
            _memberList = friends;
            
            // 添加“添加”按钮
            [_memberList addObject:[self markAddMemberButton]];
            
            
            _memberHeaderView = [[CXGroupMemberView alloc] initWithItems:_memberList];
            _memberHeaderView.grideDelegate = self;
            CGRect headerTableFrame = CGRectMake(0, 0, kScreenWidth, [_memberHeaderView numberOfRows] * kGridCellHeight);
            CGRect headerFrame = CGRectMake(0, 0, kScreenWidth, [_memberHeaderView numberOfRows] * kGridCellHeight + kDefaultMargin);
            _memberHeaderView.frame = headerFrame;
            _memberHeaderView.table.frame = headerTableFrame;
            self.groupInfoTableView.tableView.tableHeaderView = _memberHeaderView;
            
            [self addGroupMembersToServer:friends];
        }
    }
}

@end
