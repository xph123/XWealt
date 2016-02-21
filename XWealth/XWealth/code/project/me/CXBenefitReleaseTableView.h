//
//  CXBenefitReleaseTableView.h
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBenefitReleaseCellFrame.h"
@protocol CXBenefitReleaseTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end

@interface CXBenefitReleaseTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, weak) id <CXBenefitReleaseTableViewDelegate> delegate;

- (void) configData:(NSArray *)sourceDatas;

@end
