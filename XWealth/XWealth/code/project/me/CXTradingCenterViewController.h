//
//  CXTradingCenterViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXTradingCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)NSArray *tableDatas;
@property(nonatomic, strong)NSArray *tableImageDatas;
@property(nonatomic, strong)UITableView *tableView;
@end
