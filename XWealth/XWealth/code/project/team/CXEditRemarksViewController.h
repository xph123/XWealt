//
//  CXEditRemarksViewController.h
//  Link
//
//  Created by chx on 15-2-27.
//  Copyright (c) 2015年 ruisk.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXEditRemarksViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CXUserModel *friendUserModel;

@end
