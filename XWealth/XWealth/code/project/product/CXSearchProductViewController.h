//
//  CXSearchProductViewController.h
//  XWealth
//
//  Created by chx on 15-3-19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "CXConditionView.h"
#import "CXSelectTableViewController.h"
#import "CXProductDetailWebViewController.h"
typedef void (^ActionProductBlk)(NSInteger, NSString*);

@interface CXSearchProductViewController : XViewController<UISearchBarDelegate, UIAlertViewDelegate, CXProductTableViewDelegate,CXConditionViewDelegate,CXSelectTableViewControllerDelegate>
{
    BOOL _reload;
    BOOL _hasMore;
    BOOL _isLoadingMore;
}

@property (nonatomic, strong) CXProductTableView *tableView;
@property (nonatomic, strong) CXConditionView *conditionView;
@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UILabel *noFriend;
//三个按钮的要上传的id
@property(nonatomic,assign)NSInteger subscribeCategory;
@property(nonatomic,assign)NSInteger deadlineCategory;
@property(nonatomic,assign)NSInteger profitCategory;

@property (nonatomic, strong) NSMutableArray *productList;


@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, copy) ActionProductBlk selectProductBlk;

@end
