//
//  CXBuybackTrustCenterDetailViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBuybackTrustCenterDetailTableView.h"
#import "MJRefreshHeaderView.h"
#import "PullUpLoadMoreView.h"
#import "CXBuybackTrustCenterDetailOperatorView.h"
#import "CXBuybackTrustCenterDetailHeadView.h"

@interface CXBuybackTrustCenterDetailViewController : XViewController<PullUpLoadMoreViewDelegate,CXBuybackTrustCenterDetailTableViewDelegate,UIActionSheetDelegate>;

@property (nonatomic, strong) CXBuybackTrustCenterDetailTableView *tableView;
@property (nonatomic, strong) CXBuybackTrustCenterDetailOperatorView *operatorView;
@property (nonatomic, strong) CXBuyBackModel  *buyBackModel;
@property (nonatomic, strong) NSMutableArray *sourceDatas;      //认购记录

@property (nonatomic, strong) PullUpLoadMoreView *loadMoreView;

@property (nonatomic, assign)long buybackId;  //产品id
@property (nonatomic, assign)int benefitId;  //转让产品id

@end
