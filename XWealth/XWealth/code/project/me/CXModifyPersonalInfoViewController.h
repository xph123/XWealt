//
//  CXModifyPersonalInfoViewController.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXModifyPersonalInfoViewController : XViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionList1;
@property (strong, nonatomic) NSArray *sectionList2;
//@property (nonatomic, strong) NSArray *titleArray;
//@property (nonatomic, copy) NSArray *contentArray;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end
