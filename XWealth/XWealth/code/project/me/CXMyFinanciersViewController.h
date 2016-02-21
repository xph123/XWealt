//
//  CXMyFinanciersViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXMyFinanciersHeaderView.h"

@interface CXMyFinanciersViewController : XViewController<CXProductTableViewDelegate,PullUpLoadMoreViewDelegate>
@property (nonatomic, strong) CXMyFinanciersHeaderView *headView;
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXProductTableView *tableView;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
