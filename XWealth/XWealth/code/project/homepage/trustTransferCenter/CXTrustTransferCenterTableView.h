//
//  CXTrustTransferCenterTableView.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBenefitReleaseTableView.h"
#import "PullUpLoadMoreView.h"
@protocol CXTrustTransferCenterTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXTrustTransferCenterTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, weak) id <CXTrustTransferCenterTableViewDelegate> delegate;

- (void) configData:(NSArray *)sourceDatas;

@end
