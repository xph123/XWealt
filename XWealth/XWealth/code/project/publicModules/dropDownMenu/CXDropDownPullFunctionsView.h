//
//  CXDropDownPullFunctionsView.h
//  XWealth
//
//  Created by gsycf on 15/9/11.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXDropDownPullFunctionsView;
@protocol CXDropDownPullFunctionsViewDelegate <NSObject>

- (void)pullFunctionsView:(CXDropDownPullFunctionsView *)pullFunctionsView didSelectIndex:(NSInteger)index;
- (void)didBackgroundTap;
@end
@interface CXDropDownPullFunctionsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIControl *_overlayView;
}

@property (nonatomic, strong) NSArray *functionIcons;
@property (nonatomic, strong) NSArray *functionTitles;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, weak) id <CXDropDownPullFunctionsViewDelegate> delegate;

- (void)show;
- (void)dismiss;
- (id)initWithIcons:(NSArray *)functionIcons andTitles:(NSArray*)functionTitles;

@end
