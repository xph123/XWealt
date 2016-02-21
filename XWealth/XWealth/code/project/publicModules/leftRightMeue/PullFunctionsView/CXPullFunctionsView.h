//
//  CXPullFunctionsView.h
//  Link
//  下拉的功能按钮视图
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXPullFunctionsView;
@protocol CXPullFunctionsViewDelegate <NSObject>

- (void)pullFunctionsView:(CXPullFunctionsView *)pullFunctionsView didSelectIndex:(NSInteger)index;
- (void)didBackgroundTap;
@end

@interface CXPullFunctionsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIControl *_overlayView;
    UIControl *_UpOverlayView;
}

@property (nonatomic, strong) NSArray *functionIcons;
@property (nonatomic, strong) NSArray *functionTitles;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *selectStr;   //选中的名称
@property (nonatomic, assign) CGRect *btnHight;   

@property (nonatomic, weak) id <CXPullFunctionsViewDelegate> delegate;

- (void)show;
- (void)dismiss;
- (id)initWithIcons:(NSArray *)functionIcons andTitles:(NSArray*)functionTitles;

@end
