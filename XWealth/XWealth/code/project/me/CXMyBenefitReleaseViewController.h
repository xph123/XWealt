//
//  CXMyBenefitReleaseViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBenefitReleaseTableView.h"
#import "PullUpLoadMoreView.h"

@interface CXMyBenefitReleaseViewController : XViewController<CXBenefitReleaseTableViewDelegate,PullUpLoadMoreViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXBenefitReleaseTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;


@property (nonatomic, assign)NSInteger type;   //默认0 我的信托转让，1，从二手信托进入点击选择
@property (nonatomic, assign)long buybackId;
@end
