//
//  CXSingleSelFriendViewController.h
//  Link
//  单选用户
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SingleSelFriendViewDelegate <NSObject>

- (void)setSingleSelecteFriend:(CXUserModel *)friendModel;

@end


@interface CXSingleSelFriendViewController : XViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
// 所有好友的名字表
@property (nonatomic, copy) NSMutableArray *allFriendName;
// 所有好友名字与CXUserModel的对应表
@property (nonatomic, copy) NSMutableDictionary *allFriendDic;
// section和右边显示的字母
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个字母下的名字表
@property(nonatomic,retain)NSMutableArray *LetterResultArr;


// 默认的执行者，外部传进来，用于选择后再次进来，默认选中
@property (nonatomic, strong) CXUserModel *defaultPerformUserModel;

@property (nonatomic, weak) id <SingleSelFriendViewDelegate> delegate;

@end
