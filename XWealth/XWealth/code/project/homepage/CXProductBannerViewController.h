//
//  CXProductBannerViewController.h
//  XWealth
//
//  Created by 12345 on 15-12-15.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXProductBannerViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView  *scrollView;      //声明一个UIScrollView
@property(nonatomic, strong)UIPageControl *pageControl;     //声明一个UIPageControl
@property(nonatomic, strong)NSArray  *arrData;          //存放数据数组
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组

- (id) initWithBanners:(NSArray *) data;


@end
