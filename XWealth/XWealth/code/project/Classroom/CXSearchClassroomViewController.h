//
//  CXSearchClassroomViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "XViewController.h"
#import "CXClassroomListCollectionView.h"
#import "PullUpLoadMoreView.h"
@interface CXSearchClassroomViewController : XViewController<UISearchBarDelegate, UIAlertViewDelegate, CXClassroomListCollectionViewDelegate,PullUpLoadMoreViewDelegate>
{
    BOOL _reload;
    BOOL _hasMore;
    BOOL _isLoadingMore;
}

@property (nonatomic, strong) CXClassroomListCollectionView *collectionView;
@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UILabel *noFriend;

@property (nonatomic, strong) NSMutableArray *informationList;

@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@end
