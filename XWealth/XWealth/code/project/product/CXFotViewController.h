//
//  CXFotViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "CXProjectBtnView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"
#import "CXProductDetailWebViewController.h"

@interface CXFotViewController : UIViewController<CXProductTableViewDelegate, PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *rightCategoryArray;
@property (nonatomic, strong) CXProductTableView *tableView;

@property (nonatomic, strong) CXCategoryModel *leftCategoryModel;
@property (nonatomic, strong) CXCategoryModel *rightCategoryModel;
@property (nonatomic, strong) PullUpLoadMoreView *UploadMoreView;     //上拉加载更多
@property(nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新


@property (nonatomic, strong) NSMutableArray *leftBtnData;    //左边按钮数据
@property (nonatomic, strong) NSMutableArray *rightBtnData;   //右边按钮数据



@end
