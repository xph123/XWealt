//
//  CXSelectFriendView.h
//  Link
//  选择多用户的表格
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSelectFriendView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
// 所有好友的名字表
@property (nonatomic, copy) NSMutableArray *allFriendName;
// 所有好友名字与CXUserModel的对应表
@property (nonatomic, copy) NSMutableDictionary *allFriendDic;
// section和右边显示的字母
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个字母下的名字表
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

- (void)configData:(NSArray *)friendList andAlreadySelects:(NSArray*)alreadySelectedFriends;
@end
