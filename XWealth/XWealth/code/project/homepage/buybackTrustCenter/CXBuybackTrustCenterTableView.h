//
//  CXBuybackTrustCenterTableView.h
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXBuybackTrustCenterTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXBuybackTrustCenterTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, weak) id <CXBuybackTrustCenterTableViewDelegate> delegate;

- (void) configData:(NSArray *)sourceDatas;

@end
