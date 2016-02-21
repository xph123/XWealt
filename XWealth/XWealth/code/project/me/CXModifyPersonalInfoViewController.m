//
//  CXModifyPersonalInfoViewController.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXModifyPersonalInfoViewController.h"
#import "XModifyInfoCell.h"
#import "CXModifyTextFieldViewController.h"
#import "CXModifyTextViewController.h"
#import "CXSelectTableViewController.h"
#import "SJAvatarBrowser.h"
#import "showImageArr.h"
#import "VPImageCropperViewController.h"

@interface CXModifyPersonalInfoViewController ()<CXSelectTableViewControllerDelegate,VPImageCropperDelegate>

@end

@implementation CXModifyPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = StringPersonalInfo;
    
    _sectionList1 = [[NSArray alloc] initWithObjects:
                       StringHeadImage,
                       StringName,
                       StringPhone,
                       StringMail,
                       nil];
    
    _sectionList2 = [[NSArray alloc] initWithObjects:
                       StringSex,
                       StringSignaute,
                       StringAddress,
                       StringOccupation,
                       nil];
    
    //tableView
    CGRect frame = CGRectMake(0, kDefaultMargin, self.view.frame.size.width, self.view.frame.size.height - 2 * kDefaultMargin);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kControlBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(notificationModifyUserHead)
                   name:NOTIFICATION_ME_MODIFY_USERHEAD
                 object:nil];
    [center addObserver:self
               selector:@selector(notificationModifyUserInfo)
                   name:NOTIFICATION_ME_MODIFY_USERINFO
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

#pragma mark - notification
- (void) notificationModifyUserHead
{
    [self.tableView reloadData];
}

- (void) notificationModifyUserInfo
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofRows = 0;
    
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
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andImageUrl:[CXURLConstants getFullSltHeaderUrl: kAppDelegate.currentUserModel.headImg]];
                __unsafe_unretained CXModifyPersonalInfoViewController *weak_self = self;
                cell.imgViewBlk = ^{
                    [weak_self viewHeadImage:indexPath];
                };
            }
                break;
            case 1:
            {
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.nickName];
            }
                break;
            case 2:
            {
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.telePhone];
            }
                break;
            case 3:
            {
                [cell setTitle:[_sectionList1 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.mail];
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
                NSString *sex = kAppDelegate.currentUserModel.sex == 0 ? StringMan : StringWomen;
                [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:sex];
            }
                break;
            case 1:
            {
                [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.signature];
            }
                break;
            case 2:
            {
                [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.address];
            }
                break;
            case 3:
            {
                [cell setTitle:[_sectionList2 objectAtIndex:indexPath.row] andContent:kAppDelegate.currentUserModel.occupation];
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
         height = kDefaultMargin;
    }
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = kExtMenuHeight;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
            height = HeadCellHeight;
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
                [self changeHeadImage:indexPath];
            }
                break;
            case 1:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringName andDefaultText:kAppDelegate.currentUserModel.nickName];
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 2:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringPhone andDefaultText:kAppDelegate.currentUserModel.telePhone];
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 3:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringMail andDefaultText:kAppDelegate.currentUserModel.mail];
                [self.navigationController pushViewController:modifyControl animated:YES];
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
                NSArray *sexList = [[NSArray alloc] initWithObjects:
                                 StringMan,
                                 StringWomen,
                                 nil];

                CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:sexList andSelect:kAppDelegate.currentUserModel.sex];
                modifyControl.delegate = self;
                modifyControl.title = StringSex;
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 1:
            {
                CXModifyTextViewController *modifyControl = [[CXModifyTextViewController alloc] initWithType:StringSignaute andDefaultText:kAppDelegate.currentUserModel.signature];
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 2:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringAddress andDefaultText:kAppDelegate.currentUserModel.address];
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            case 3:
            {
                CXModifyTextFieldViewController *modifyControl = [[CXModifyTextFieldViewController alloc] initWithType:StringOccupation andDefaultText:kAppDelegate.currentUserModel.occupation];
                [self.navigationController pushViewController:modifyControl animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - private methods

- (void) viewHeadImage:(NSIndexPath *)indexPath
{
//    XModifyInfoCell *cell = (XModifyInfoCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",kAppDelegate.currentUserModel.headImg);
    UIImageView *_showView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    _showView.contentMode=UIViewContentModeScaleAspectFit;
    [_showView setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullHeaderUrl:kAppDelegate.currentUserModel.headImg]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        _showView.image=image;
        showImageArr *showAmage=[[showImageArr alloc]init];
        [showAmage showImageArray:nil andImage:_showView];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];

//    [SJAvatarBrowser showImage:cell.headImageView bigImageUrl:[CXURLConstants getFullHeaderUrl:kAppDelegate.currentUserModel.headImg]];
}

- (void) changeHeadImage:(NSIndexPath *)indexPath
{
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
    [sheet showInView:self.view];

    
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
    [picker dismissViewControllerAnimated:YES completion:^{
        

        //获取照片的原图
        //UIImage* originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //获取图片裁剪的图
        UIImage* editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //获取图片裁剪后，剩下的图
       // UIImage* cropImage = [info objectForKey:UIImagePickerControllerCropRect];
//        UIImage* newImage=[[image fitSmallImage:CGSizeMake(kScreenWidth, kScreenHeight)] fixOrientation];
        NSData* data=UIImageJPEGRepresentation(editImage, 0.8);
        UIImage* anotherImg=[UIImage imageWithData:data];
        
        NSString *path = [XLocalImageCache tempSaveImageName];
        [data writeToFile:path atomically:YES];
        
        
        [self upDateHeadeImage:anotherImg andTempFileName:path];
    
    }];
    

}
//退出相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - network data

- (void) upDateHeadeImage:(UIImage *) image  andTempFileName:(NSString *)fileName
{
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parameters = [XHttpParameters parameters];
    [parameters appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    
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


- (void) setLocalValueAndNotifaction:(int) sex
{
    XFileValue *file = [[XFileValue alloc] initWithFileName:kAppDelegate.currentUserInfoFileName];
    NSString *strSex = [NSString stringWithFormat:@"%d", sex];
    [file setValue:strSex forKey:kParameterSex];
    kAppDelegate.currentUserModel.sex = sex;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NOTIFICATION_ME_MODIFY_USERINFO object:nil userInfo:nil];
}

#pragma mark - CXSelectTableViewControllerDelegate
// 发送设置性别的网络请求
- (void)setSelected:(int)nameId andIndex:(int)index
{
    int type = TypeSex;
    NSString *value = [NSString stringWithFormat:@"%d", index];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
    [self.view.window addSubview:self.HUD];
    self.HUD.labelText = @"正在发送...";
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD show:YES];
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"userId" andLongValue:kAppDelegate.currentUserModel.userId];
    [parametersUtil appendParameterWithName:@"type" andIntValue:type];
    [parametersUtil appendParameterWithName:@"value" andStringValue:value];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:POST_ME_MODIFY_USERINFO result:^(CXMainPlate *mainPlate, NSError *err) {
        self.HUD.hidden = YES;
        if(!err)
        {
            XLog(@"modify my info success");
            
            if ([mainPlate.code integerValue] == 0)
            {
                // 成功
                [self setLocalValueAndNotifaction:index];
            }
            else
            {
                // 失败
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = PromptEditError;
                hud.yOffset = -50;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
        }
        else
        {
            XLog(@"modify my info fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = (NSString *)err;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }];

}

@end
