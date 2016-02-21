//
//  CXSelectFinanciersTableView.h
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXMyCollectionTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)deleteItemAtIndex:(NSInteger)index;
@end
@interface CXSelectFinanciersTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXMyCollectionTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas;

@end
