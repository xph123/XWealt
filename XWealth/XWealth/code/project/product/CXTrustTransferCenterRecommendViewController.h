//
//  CXTrustTransferCenterRecommendViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/6.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTrustTransferCenterTableView.h"
@interface CXTrustTransferCenterRecommendViewController : XViewController<CXTrustTransferCenterTableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXTrustTransferCenterTableView *tableView;

@property (strong, nonatomic) NSArray *subscribeList;

@end
