//
//  CXSelectGroupViewController.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXSelectGroupViewDelegate <NSObject>

- (void)setSelectedGroup:(CXGroupModel *)model;

@end

@interface CXSelectGroupViewController :  XViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *sourceDatas;

@property (nonatomic, weak) id <CXSelectGroupViewDelegate> delegate;

@end
