//
//  CXInformationViewController.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationTableView.h"
#import "CXProjectBtnView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"
#import "CXLeftRightMeueView.h"

@interface CXInformationViewController : UIViewController<CXInformationTableViewDelegate, PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate,CXLeftRightMeueViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *rightCategoryArray;
@property (nonatomic, strong) CXInformationTableView *tableView;

@property (nonatomic, strong) CXCategoryModel *leftCategoryModel;
@property (nonatomic, strong) CXCategoryModel *rightCategoryModel;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新

@property(nonatomic,strong)CXLeftRightMeueView *MeueView;
@property (nonatomic, strong) NSMutableArray *leftBtnData;    //左边按钮数据
@property (nonatomic, strong) NSMutableArray *rightBtnData;   //右边按钮数据

@end
