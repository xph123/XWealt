//
//  CXMyRecommentViewController.h
//  XWealth
//  我的邀请
//  Created by chx on 15/6/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullUpLoadMoreView.h"

@interface CXMyRecommentViewController :  XViewController<UITableViewDataSource,UITableViewDelegate,PullUpLoadMoreViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *recommentList;
@property (nonatomic, strong) NSMutableArray *registeredList;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@end
