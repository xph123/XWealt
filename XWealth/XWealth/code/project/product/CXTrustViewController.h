//
//  CXTrustViewController.h
//  XWealth
//  信托
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"

@interface CXTrustViewController : UIViewController<CXProductTableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXProductTableView *tableView;

@end
