//
//  CXBuybackTrustCenterRecommendViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/6.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBuybackTrustCenterTableView.h"

@interface CXBuybackTrustCenterRecommendViewController : XViewController<CXBuybackTrustCenterTableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXBuybackTrustCenterTableView *tableView;




@end
