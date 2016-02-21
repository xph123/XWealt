//
//  CXTrustTransferCenterDetailViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTrustTransferCenterDetailTableView.h"
#import "MJRefreshHeaderView.h"
#import "PullUpLoadMoreView.h"
#import "CXTrustTransferDetailOperatorView.h"
#import "CXTrustTransferDetailHeadView.h"

@interface CXTrustTransferCenterDetailViewController : XViewController<PullUpLoadMoreViewDelegate,CXTrustTransferCenterDetailTableViewDelegate,UIActionSheetDelegate>;

@property (nonatomic, strong) CXTrustTransferCenterDetailTableView *tableView;
@property (nonatomic, strong) CXTrustTransferDetailOperatorView *operatorView;
@property (nonatomic, strong) CXBenefitModel *benefitModel;
@property (nonatomic, strong) NSMutableArray *sourceDatas;      //认购记录
@property (nonatomic, assign) long productId;
@property (nonatomic, assign) long benefitId;

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@end
