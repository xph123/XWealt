//
//  CXMyAttentionViewController.h
//  XWealth
//
//  Created by chx on 15/6/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "PullUpLoadMoreView.h"

@interface CXMyAttentionViewController : XViewController<CXProductTableViewDelegate,PullUpLoadMoreViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXProductTableView *tableView;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
