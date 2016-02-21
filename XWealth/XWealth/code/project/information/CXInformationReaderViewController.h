//
//  CXInformationReadersViewController.h
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXUserTableView.h"

@interface CXInformationReaderViewController : UIViewController

@property (nonatomic, assign) long informationId;
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXUserTableView *tableView;

@end
