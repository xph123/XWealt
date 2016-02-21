//
//  CXPopularActivityViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/12.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXPopularActivityTableView.h"
#import "PullUpLoadMoreView.h"
@interface CXPopularActivityViewController : XViewController<CXMyCollectionTableViewDelegate, PullUpLoadMoreViewDelegate>
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXPopularActivityTableView *tableView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end
