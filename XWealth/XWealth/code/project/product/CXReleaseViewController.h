//
//  CXReleaseViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "XViewController.h"
#import "CXReleaseProductView.h"
#import "CXSelectTableViewController.h"
#import "CXReleaseBenefitView.h"
#import "CXListInvestCategoryModel.h"


@interface CXReleaseViewController : XViewController<UIScrollViewDelegate,CXReleaseProductViewDelegate,CXSelectTableViewControllerDelegate>

@property(nonatomic,strong)CXReleaseProductView *ReleaseProduct;
@property(nonatomic,strong)CXReleaseBenefitView *ReleaseBenefit;
@property(nonatomic,strong)UIScrollView *scrView;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,copy)void(^postBlock)(NSString *str);

-(void)selectView:(NSInteger)index;

@end
