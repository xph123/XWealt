//
//  CXHomePageTwoCell.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductBannerViewController.h"
#import "CXHomePageTwoCellFrame.h"
@interface CXHomePageTwoCell : UICollectionViewCell<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView  *scrollView;      //声明一个UIScrollView
@property(nonatomic, strong)UIPageControl *pageControl;     //声明一个UIPageControl
@property(nonatomic, strong)NSArray  *arrData;          //存放数据数组
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组
@property(nonatomic, strong)UINavigationController *navigationController;
- (void) addData:(NSArray *) data;

@end
