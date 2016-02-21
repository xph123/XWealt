//
//  CXXtbBillViewController.h
//  XWealth
//  资金流水
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullUpLoadMoreView.h"

@interface CXXtbBillViewController : XViewController<UITableViewDataSource,UITableViewDelegate, PullUpLoadMoreViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
