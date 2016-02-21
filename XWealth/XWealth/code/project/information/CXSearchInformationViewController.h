//
//  CXSearchInformationViewController.h
//  XWealth
//
//  Created by chx on 15-3-26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationTableView.h"

@interface CXSearchInformationViewController : XViewController<UISearchBarDelegate, UIAlertViewDelegate, CXInformationTableViewDelegate>
{
    BOOL _reload;
    BOOL _hasMore;
    BOOL _isLoadingMore;
}

@property (nonatomic, strong) CXInformationTableView *tableView;
@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UILabel *noFriend;

@property (nonatomic, strong) NSMutableArray *informationList;

@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end
