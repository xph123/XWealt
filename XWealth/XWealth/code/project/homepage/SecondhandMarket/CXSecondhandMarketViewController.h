//
//  CXSecondhandMarketViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSecondhandMarketTableView.h"
#import "CXSecondhandMarketBannerCell.h"
#import "MJRefresh.h"
#import "CXBannerViewController.h"
#import "CXSecondHandMarketButtonBar.h"
@interface CXSecondhandMarketViewController : XViewController<CXSecondhandMarketTableViewDelegate,MJRefreshBaseViewDelegate>


@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) CXSecondhandMarketTableView *tableView;
@property (nonatomic, strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新
@property (nonatomic, strong) CXSecondHandMarketButtonBar *selectBtnsView;


@end
