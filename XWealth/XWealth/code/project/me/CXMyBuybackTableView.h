//
//  CXMyBuybackTableView.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXMyBuybackTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end
@interface CXMyBuybackTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, weak) id <CXMyBuybackTableViewDelegate> delegate;

- (void) configData:(NSArray *)sourceDatas;

@end
