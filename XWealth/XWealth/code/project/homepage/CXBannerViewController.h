//
//  CXBannerViewController.h
//  eLearning
//  banner 的滚动视图
//  Created by watson on 14-5-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXBannerViewController : UIViewController<UIScrollViewDelegate>

{
    BOOL isFromStart;
}

@property(nonatomic, strong)UIScrollView  *scrollView;      //声明一个UIScrollView
@property(nonatomic, strong)UIPageControl *pageControl;     //声明一个UIPageControl
@property(nonatomic, strong)NSArray  *arrayImages;          //存放图片的数组
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组
@property(nonatomic, strong)UINavigationController *navigationController;

- (id) initWithBanners:(NSArray *) arrayImages;

@property (strong, nonatomic) NSTimer *scrollTimer;
@property (strong, nonatomic) NSTimer *stopScrollTimer;
@property (assign, nonatomic) int stopNum;

@end
