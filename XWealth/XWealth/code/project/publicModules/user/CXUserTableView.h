//
//  CXUserTableView.h
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXUserTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

- (void)configData:(NSArray *)sourceDatas;

@end
