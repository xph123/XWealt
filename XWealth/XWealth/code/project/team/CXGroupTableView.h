//
//  CXGroupTableView.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXGroupTableViewDelegate <NSObject>

- (void)groupTableDidSelectItemAtIndex:(id)data;

@end


@interface CXGroupTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *sourceData;

@property (nonatomic, weak) id <CXGroupTableViewDelegate> delegate;

- (void)configData:(NSArray *)groupList;

@end
