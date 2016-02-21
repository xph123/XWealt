//
//  CXXintuobaoView.h
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXXintuobaoViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void) showEarlyDatas;
@end

@interface CXXintuobaoView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <CXXintuobaoViewDelegate> delegate;
@property (nonatomic, strong) NSArray *hotSaleDatas;
@property (nonatomic, strong) NSArray *earlyDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,assign)BOOL Arrow; //判断是否打开

- (void)configData:(NSArray *)hotSaleDatas;
- (void)configEarlyData:(NSArray *)earlyDatas;

@end
