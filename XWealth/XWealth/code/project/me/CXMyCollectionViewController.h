//
//  CXMyCollectionViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyCollectionTableView.h"
#import "PullUpLoadMoreView.h"

@interface CXMyCollectionViewController : XViewController<CXMyCollectionTableViewDelegate, PullUpLoadMoreViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXMyCollectionTableView *tableView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end
