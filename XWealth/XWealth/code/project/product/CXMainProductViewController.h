//
//  CXMainProductViewController.h
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "CXProjectBtnView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"
#import "CXLeftRightMeueView.h"
#import "CXProductDetailWebViewController.h"


@interface CXMainProductViewController : UIViewController<CXProductTableViewDelegate, PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate,CXLeftRightMeueViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *rightCategoryArray;
@property (nonatomic, strong) CXProductTableView *tableView;

@property (nonatomic, strong) CXCategoryModel *leftCategoryModel;
@property (nonatomic, strong) CXCategoryModel *rightCategoryModel;
@property (nonatomic, strong) PullUpLoadMoreView *UploadMoreView;     //上拉加载更多
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新

@property(nonatomic,strong)CXLeftRightMeueView *MeueView;
@property (nonatomic, strong) NSMutableArray *leftBtnData;    //左边按钮数据
@property (nonatomic, strong) NSMutableArray *rightBtnData;   //右边按钮数据

@property (nonatomic,assign)NSInteger showType;  //0 直接显示，1 首页跳转到

@end
