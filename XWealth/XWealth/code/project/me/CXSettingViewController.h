//
//  CXSettingViewController.h
//  Link
//
//  Created by chx on 14-12-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSettingViewController : XViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@end
