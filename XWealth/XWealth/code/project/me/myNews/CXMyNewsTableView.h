//
//  CXMyNewsTableView.h
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXMyNewsTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end

@interface CXMyNewsTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXMyNewsTableViewDelegate> delegate;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

- (void) configData:(NSArray *)sourceDatas;

@end
