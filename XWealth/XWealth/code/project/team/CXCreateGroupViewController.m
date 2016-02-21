//
//  CXCreateGroupViewController.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCreateGroupViewController.h"
#import "ChineseString.h"
#import "CXSelectFriendCell.h"
#import "CXSelectFriendStruct.h"
#import "CXCreateGroupView.h"
#import "SJAvatarBrowser.h"

@interface CXCreateGroupViewController ()

@end

@implementation CXCreateGroupViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kControlBgColor;
    
    _groupModel = [[CXGroupModel alloc] init];
    [self initRightBarButton];
    
    CXSelectFriendView *selFriendTableView = [[CXSelectFriendView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:selFriendTableView];
    self.selFriendTableView = selFriendTableView;
    
    CXCreateGroupView *createGroupHeaderview = [[CXCreateGroupView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kLargeMargin + kLabelHeight + kDefaultMargin*3 + kTextViewHeight + kIconLargeHeight)];
    self.createGroupHeaderview = createGroupHeaderview;
    self.selFriendTableView.tableView.tableHeaderView = createGroupHeaderview;
    
    __unsafe_unretained CXCreateGroupViewController *weak_self = self;
    self.createGroupHeaderview.clickAddPictureBlk = ^{
        // 修改群图片
        [weak_self clickGroupLogoView];
    };
    self.createGroupHeaderview.longPressAddPictureBlk = ^{
        // 长按群图片
        [weak_self longPressGroupLogoView];
    };

    [self getFriendListFromDatabase];  // 先从本地读取好友数据
}

- (void) initRightBarButton
{
    UIButton *complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(0, 0, 60, 30);
    [complateBtn setTitle:StringSave forState:UIControlStateNormal];
    complateBtn.titleLabel.font = kNavBarTextFont;
    [complateBtn setTitleColor:kNavBarTextColor forState:UIControlStateNormal];
    [complateBtn addTarget:self action:@selector(clickComplateSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:complateBtn];
    self.navigationItem.rightBarButtonItem = saveBar;
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - data

- (void)getFriendListFromDatabase
{
    NSMutableArray *friendList = [[[CXDBHelper sharedDBHelper] getFriendDao] queryFriends];
    
    [self.selFriendTableView configData:friendList andAlreadySelects:nil];
}

- (void) addGroupToServer:(NSMutableArray *)friends
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];

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
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    [parameters appendParameterWithName:@"name" andStringValue:self.createGroupHeaderview.nameTextField.text];
    [parameters appendParameterWithName:@"intro" andStringValue:self.createGroupHeaderview.textView.text];
    [parameters appendParameterWithName:@"members" andStringValue:strMembers];
    [parameters appendParameterWithName:@"number" andIntValue:[friends count]];
    [parameters appendParameterWithName:@"grade" andIntValue:0];
    
    [CXDataCenter sendFilesParams:parameters.parameters strURL:POST_CREATE_GROUP formBlock:^(id<AFMultipartFormData> formData){
        NSData* data=UIImagePNGRepresentation(self.groupLogoImage);
        
        if (self.groupLogoImage)
        {
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
             XLog(@"创建群失败");
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
                self.groupModel = mainPlate.anyModels[0];
                     
                [[[CXDBHelper sharedDBHelper] getGroupDao] insertGroup:_groupModel];
                [[[CXDBHelper sharedDBHelper] getGroupMemberDao] insertMembers:friends andGroupId:self.groupModel.groupID];
                 
                 // 缓存本地的图片到网络指定的路径下，并删除本地图片
                 if (_groupLogoPath && _groupLogoPath.length > 0
                     && self.groupModel.groupLogo && self.groupModel.groupLogo.length > 0)
                 {
                     [XLocalImageCache saveImageToCache:[XLocalImageCache localImageCacheDirectory:kDirectoryOfImage] image: _groupLogoImage imageName:self.groupModel.groupLogo imageType:@"jpg"];
                     
                     [XLocalImageCache deleteLocalImage:kDirectoryOfImage imageName:self.groupLogoPath];
                 }
                     
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:NOTIFICATION_CREATE_GROUP object:nil userInfo:nil];
             }
             
             XLog(@"创建群成功");
             [self goBack];
         }
     }];
}

#pragma mark - private methods

// 必须填写团队名称和选择团队成员
- (void)clickComplateSelectBtn:(UIButton *)button
{
    if ([NSString isBlankString:self.createGroupHeaderview.nameTextField.text]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"团队通常都有一个响亮的名字,你的呢？";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return ;
    }

    NSMutableArray *friends = [[NSMutableArray alloc] init];
    
    for (NSString *name in self.selFriendTableView.allFriendName)
    {
        CXSelectFriendStruct *selFriend = self.selFriendTableView.allFriendDic[name];
        
        if (selFriend.isSelected)
        {
            [friends addObject:selFriend.userModel];
        }
    }
    
    if (friends.count == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择好友";
        hud.yOffset = -50;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        
        return;
    }
    else
    {
        // 把自己加入到群里
        [friends addObject:kAppDelegate.currentUserModel];
        
        [self addGroupToServer:friends];
    }
}

#pragma  mark - image

- (void) clickGroupLogoView
{
    [self.createGroupHeaderview.textView resignFirstResponder];
    [self.createGroupHeaderview.nameTextField resignFirstResponder];
    
    if (self.groupLogoImage)
    {
        [SJAvatarBrowser showImage:self.createGroupHeaderview.groupLogoImageView];
    }
    else
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

- (void) longPressGroupLogoView
{
    [self.createGroupHeaderview.textView resignFirstResponder];
    [self.createGroupHeaderview.nameTextField resignFirstResponder];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否清除相片"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确认", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.groupLogoImage = nil;
        self.groupLogoPath = @"";
        [self.createGroupHeaderview.groupLogoImageView setImage:IMAGE(@"add_picture")];
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
    
    _groupLogoPath = path;
    _groupLogoImage = anotherImg;
    [self.createGroupHeaderview.groupLogoImageView setImage:anotherImg];
    //[self upDateHeaderBgImage:anotherImg andTempFileName:path];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
