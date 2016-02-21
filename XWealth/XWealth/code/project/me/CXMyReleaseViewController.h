//
//  CXMyReleaseViewController.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXReleaseTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXProductDetailViewController.h"

@interface CXMyReleaseViewController : XViewController<CXReleaseTableViewDelegate,PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXReleaseTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
