//
//  CXProductView.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXProductTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
@end

@interface CXProductTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXProductTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;   //判断是否加section头

- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas;

@end
