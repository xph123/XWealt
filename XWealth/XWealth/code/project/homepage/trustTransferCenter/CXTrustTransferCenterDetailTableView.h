//
//  CXTrustTransferCenterDetailTableView.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXTrustTransferCenterDetailTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end
@interface CXTrustTransferCenterDetailTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXTrustTransferCenterDetailTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;
@property (nonatomic, assign) NSInteger  countNum;   //投资总数

- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas countNum:(NSInteger)count;

@end
