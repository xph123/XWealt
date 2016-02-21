//
//  CXUserDetailViewController.h
//  Link
//  个人详情，个人主页
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXUserDetailHeadView.h"

@interface CXUserDetailViewController : XViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CXUserDetailHeadView *headView;
@property (nonatomic, strong) NSArray *sourceDatas;
@property (nonatomic, strong) CXUserModel *userModel;
@property (nonatomic, assign) NSInteger isFriend; // 好友 显示指派和汇报
@property (nonatomic, assign) NSInteger isRequest;// 非好友 申请过显示已申请，未申请过显示添加好友

@end
