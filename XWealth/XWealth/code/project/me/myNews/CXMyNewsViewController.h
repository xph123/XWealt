//
//  CXMyNewsViewController.h
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyNewsTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXMyNewsDetailViewController.h"
#import "UDCustomNavigation.h"
@interface CXMyNewsViewController :  XViewController<CXMyNewsTableViewDelegate, PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXMyNewsTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;
@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;


@end
