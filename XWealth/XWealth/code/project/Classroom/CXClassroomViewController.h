//
//  CXClassroomViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXClassroomCollectionView.h"
#import "CXProjectBtnView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"
#import "CXProjectBtn.h"

@interface CXClassroomViewController : XViewController<CXClassroomCollectionViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *buttonBarDatas;  //按钮数据
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) CXClassroomCollectionView *collectionView;
@property (nonatomic,strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新

@end
