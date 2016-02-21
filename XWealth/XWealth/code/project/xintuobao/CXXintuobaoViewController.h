//
//  CXXintuobaoViewController.h
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXXintuobaoView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"
#import "CXWebViewController.h"

@interface CXXintuobaoViewController : UIViewController<CXXintuobaoViewDelegate, PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *hotSaleDatas;
@property (nonatomic, strong) NSMutableArray *earlyDatas;
@property (nonatomic, strong) CXXintuobaoView *tableView;

@property (nonatomic, strong) PullUpLoadMoreView *UploadMoreView;     //上拉加载更多
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新

@property (nonatomic, strong) NSString *problemUrl;
@end
