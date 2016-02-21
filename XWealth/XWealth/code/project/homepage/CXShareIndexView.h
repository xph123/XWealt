//
//  CXShareIndexView.h
//  XWealth
//
//  Created by gsycf on 16/1/18.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXShareIndexView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSMutableArray *sourceDatas;
@property(nonatomic, strong)NSMutableArray *viewController; //存放UIViewController的可变数组
-(id)initSourceDatas:(NSMutableArray *)sourceData;

@end
