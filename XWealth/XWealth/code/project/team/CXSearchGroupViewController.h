//
//  CXSearchGroupViewController.h
//  Link
//  搜索群，用于添加群
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSearchGroupViewController : XViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    BOOL _reload;
    BOOL _hasMore;
    BOOL _isLoadingMore;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UILabel *noFriend;

@property (nonatomic, copy) NSMutableArray *allCustomUser;
@property (nonatomic, strong) NSMutableArray *groupList;

@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end
