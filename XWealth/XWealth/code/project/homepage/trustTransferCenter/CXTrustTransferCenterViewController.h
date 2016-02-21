//
//  CXTrustTransferCenterViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTrustTransferCenterTableView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefreshHeaderView.h"
#import "CXLoginViewController.h"
@interface CXTrustTransferCenterViewController : XViewController<CXTrustTransferCenterTableViewDelegate,PullUpLoadMoreViewDelegate, UIActionSheetDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXTrustTransferCenterTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新
@end
