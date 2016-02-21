//
//  CXGroupInfoViewController.h
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXGroupInfoView.h"
#import "CXGroupMemberView.h"

@interface CXGroupInfoViewController : XViewController<CXGroupMemberViewDelegate, CXGroupInfoViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) CXGroupInfoView *groupInfoTableView;
@property (nonatomic, strong) CXGroupModel *groupModel;
@property (nonatomic, strong) CXUserModel *managerModel;
@property (nonatomic, strong) NSMutableArray *memberList;
@property (nonatomic, strong) CXGroupMemberView *memberHeaderView;

@property (nonatomic, assign) GroupGrade memberGrade;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;

- (id) initWithGroupModel:(CXGroupModel*) groupModel;

@end
