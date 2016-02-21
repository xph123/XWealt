//
//  CXSelectFinanciersViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectFinanciersTableView.h"
#import "PullUpLoadMoreView.h"
@interface CXSelectFinanciersViewController : XViewController<CXMyCollectionTableViewDelegate, PullUpLoadMoreViewDelegate,UIActionSheetDelegate>
//选择专属理财师
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXSelectFinanciersTableView *tableView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;

@end
