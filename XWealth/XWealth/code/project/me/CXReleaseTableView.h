//
//  CXReleaseTableView.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXReleaseCellFrame.h"

@protocol CXReleaseTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end

@interface CXReleaseTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, weak) id <CXReleaseTableViewDelegate> delegate;

- (void) configData:(NSArray *)sourceDatas;

@end
