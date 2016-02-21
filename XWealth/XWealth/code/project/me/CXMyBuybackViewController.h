//
//  CXMyBuybackViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMyBuybackTableView.h"
#import "PullUpLoadMoreView.h"
//#import "CXProductDetailViewController.h"
@interface CXMyBuybackViewController : XViewController<CXMyBuybackTableViewDelegate,PullUpLoadMoreViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXMyBuybackTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
