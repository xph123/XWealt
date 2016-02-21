//
//  CXMyNewsDetailTableView.h
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXMyNewsDetailTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end



@interface CXMyNewsDetailTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) id <CXMyNewsDetailTableViewDelegate> delegate;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *sourceDatas;

- (void) configData:(NSArray *)sourceDatas;
@end
