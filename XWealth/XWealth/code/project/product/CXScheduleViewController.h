//
//  CXScheduleViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXScheduleTableView.h"
#import "PullUpLoadMoreView.h"
@interface CXScheduleViewController : XViewController<CXScheduleTableViewDelegate, PullUpLoadMoreViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXScheduleTableView *tableView;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, assign) NSInteger delIndex;

@end
