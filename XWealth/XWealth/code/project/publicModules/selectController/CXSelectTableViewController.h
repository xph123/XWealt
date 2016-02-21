//
//  CXSelectTableViewController.h
//  XWealth
//
//  Created by chx on 15/7/13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXSelectTableViewControllerDelegate <NSObject>

- (void)setSelected:(int)nameId andIndex:(int)index;

@end


@interface CXSelectTableViewController : XViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourceDatas;
@property(nonatomic,assign)int nameId;       //用来区分同一个界面掉用区别

@property (nonatomic, weak) id <CXSelectTableViewControllerDelegate> delegate;

- (id)initWithSourceData:(NSArray*)sourceDatas andSelect:(int)selectIndex;

@end
