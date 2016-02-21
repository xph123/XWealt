//
//  CXProductDetailViewController.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductDetailTableView.h"
#import "CXProductOperatorView.h"

@interface CXProductDetailViewController : XViewController

@property (nonatomic, strong) CXProductDetailTableView *tableView;
@property (nonatomic, strong) CXProductModel *productModel;
@property (nonatomic, assign) long productId;
@property (nonatomic, strong) CXProductOperatorView *operatorView;
@property (nonatomic, assign) int isAttentioned;

@property (nonatomic, strong) NSArray *sourceData;
@property (nonatomic, strong) NSArray *sectionData;

@end
