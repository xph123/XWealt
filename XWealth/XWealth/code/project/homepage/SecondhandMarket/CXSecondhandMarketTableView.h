//
//  CXSecondhandMarketTableView.h
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXSecondhandMarketTableViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXSecondhandMarketTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXSecondhandMarketTableViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHaveSection;   //判断是否加section头

- (void)configData:(NSArray *)sourceDatas;
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas;
@property(nonatomic, strong)UINavigationController *navigationController;

@property (strong, nonatomic) ActionClickBlk firstBtnBlk;
@property (strong, nonatomic) ActionClickBlk secondBtnBlk;
@property (strong, nonatomic) ActionClickBlk thirdBtnBlk;
@property (strong, nonatomic) ActionClickBlk fourBtnBlk;
@end
