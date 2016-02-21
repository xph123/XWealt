//
//  CXMyTrackViewController.h
//  XWealth
//
//  Created by 12345 on 15-8-23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTrackTableView.h"
#import "PullUpLoadMoreView.h"
#import "CXAddTrackViewController.h"
#import "CXMyTrackCellHeight.h"

@interface CXMyTrackViewController : XViewController<CXTrackTableViewDelegate,PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXTrackTableView *tableView;



@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;
@end
