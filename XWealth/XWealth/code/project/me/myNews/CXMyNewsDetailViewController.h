//
//  CXMyNewsDetailViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyNewsDetailTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXProductDetailViewController.h"
#import "UDCustomNavigation.h"
@interface CXMyNewsDetailViewController : XViewController<CXMyNewsDetailTableViewDelegate, PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXMyNewsDetailTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic,assign) NSInteger type;
@end
