//
//  CXExpertViewLIstController.h
//  XWealth
//
//  Created by gsycf on 15/12/11.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXClassroomListCollectionView.h"
#import "CXProjectBtnView.h"
#import "PullUpLoadMoreView.h"
#import "MJRefresh.h"

@interface CXExpertViewLIstController : UIViewController<CXClassroomListCollectionViewDelegate, PullUpLoadMoreViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXClassroomListCollectionView *collectionView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@property (nonatomic, strong) MJRefreshHeaderView *DownLoadMoreView;   //下拉刷新
@property (nonatomic, assign) NSInteger specailistId;


@end
