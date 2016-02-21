//
//  CXClassroomReaderViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/27.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXUserTableView.h"
@interface CXClassroomReaderViewController : UIViewController

@property (nonatomic, assign) long informationId;
@property (nonatomic, strong) NSMutableArray *sourceDatas;
@property (nonatomic, strong) CXUserTableView *tableView;

@end
