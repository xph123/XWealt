//
//  CXMyIntegralViewController.h
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullUpLoadMoreView.h"

@interface CXMyIntegralViewController :  XViewController<UITableViewDataSource,UITableViewDelegate, PullUpLoadMoreViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *integralList;
@property (nonatomic, strong) UILabel *integralLabel;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
