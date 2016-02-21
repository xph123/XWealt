//
//  CXScheduleTableView.h
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXScheduleTableViewDelegate <NSObject>
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
@end

@interface CXScheduleTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXScheduleTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas;

@end
