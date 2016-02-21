//
//  CXHomePageViewController.h
//  XWealth
//
//  Created by chx on 15-3-2.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXHomePageCollectionView.h"
#import "MJRefresh.h"
#import "CXDropProjectBtn.h"
#import "CXProductTransferViewController.h"
#import "CXProductBuyBackViewController.h"
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import "CXProductDetailWebViewController.h"
@interface CXHomePageViewController : XViewController<CXHomePageCollectionViewDelegate,MJRefreshBaseViewDelegate,CXDropProjectBtnDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) NSMutableArray *SSEIndexDaatas;   //上证，深证等指数
@property (nonatomic, strong) CXHomePageCollectionView *collectionView;
@property (nonatomic, strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新


//@property (nonatomic, strong) BMKLocationService *locService;
@end
