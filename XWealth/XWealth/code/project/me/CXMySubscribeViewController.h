//
//  CXMySubscribeViewController.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSubscribeTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXProductDetailViewController.h"
@interface CXMySubscribeViewController : XViewController<CXSubscribeTableViewDelegate, PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXSubscribeTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
