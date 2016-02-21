//
//  PullUpLoadMoreView.h
//  Link
//
//  Created by wangqi on 14-9-19.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

//typedef NS_ENUM(NSUInteger, LoadMoreState) {
//    LoadMoreStateNormal = 0,  //正常状态----"加载更多"
//    LoadMoreStateIsLoading,   //加载状态----"正在加载. . . "
//    LoadMoreStateComplete,    //加载完成----"加载完成"
//    LoadMoreStateFail,        //加载失败----"加载失败"
//    LoadMoreStateNoData       //没有数据----"没有数据"
//};

@protocol PullUpLoadMoreViewDelegate <NSObject>

- (void)loadMore;
- (void)updateDelegateView;

@end

@interface PullUpLoadMoreView : UICollectionReusableView
{
    UIButton *_statusBtn;
    UILabel *_statusLabel;
	UIActivityIndicatorView *_activityView;
    UIImageView *_refreshView;
}

@property (nonatomic, weak) id<PullUpLoadMoreViewDelegate> delegate;
@property (nonatomic, assign) LoadMoreState state;
@property (nonatomic, strong) NSString *noData;

- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)updateWithCurrentLoadCount:(NSInteger)currentLoadCount
                    totalLoadCount:(NSInteger)totalLoadCount
                          pageSize:(NSString *)pageSize;

@end

