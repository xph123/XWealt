//
//  CXProjectSelectView.h
//  XWealth
//
//  Created by chx on 15/7/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXProjectSelectView;
@protocol CXProjectSelectViewDelegate <NSObject>

- (void)projectSelectView:(CXProjectSelectView *)projectSelectView didSelectIndex:(NSInteger)index;
- (void)didBackgroundTap;

@end

@interface CXProjectSelectView : UIView
{
    UIControl *_overlayView;
}

@property (nonatomic, strong) NSArray *projectList;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id <CXProjectSelectViewDelegate> delegate;

- (void)show;
- (void)dismiss;
- (id)initWithProjects:(NSArray *)projectList;

@end

