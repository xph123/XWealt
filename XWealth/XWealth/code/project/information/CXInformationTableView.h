//
//  CXInformationTableView.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXInformationTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
@end

@interface CXInformationTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXInformationTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;

- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas;

@end
