//
//  CXCreateGroupViewController.h
//  Link
//  新建群
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectFriendView.h"
#import "CXCreateGroupView.h"

//@protocol CreateGroupViewDelegate <NSObject>
//
//- (void)groupName:(NSString*) groupName andDesc:(NSString*) groupDesc andMember:(NSMutableArray *)friends;
//
//@end

@interface CXCreateGroupViewController : XViewController<UIAlertViewDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) CXSelectFriendView *selFriendTableView;
@property (nonatomic, strong) CXCreateGroupView *createGroupHeaderview;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
//@property (nonatomic, weak) id <CreateGroupViewDelegate> delegate;
@property (nonatomic, strong) CXGroupModel *groupModel;
@property (nonatomic, strong) UIImage *groupLogoImage;
@property (nonatomic, strong) NSString *groupLogoPath;

@end
