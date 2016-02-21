//
//  CXExpertViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXExpertTableView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"

@interface CXExpertViewController : UIViewController<PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXExpertTableView *tableView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新

@end
