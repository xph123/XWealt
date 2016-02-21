//
//  CXFriendTableView.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXFriendTableViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(id)data;
- (void)entryNewFriendViewControler;

@end


@interface CXFriendTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CXUserView *addFriendView;
// 所有好友的名字表
@property (nonatomic, copy) NSMutableArray *allFriendName;
// 所有好友名字与CXUserModel的对应表
@property (nonatomic, copy) NSMutableDictionary *allFriendDic;
// section和右边显示的字母
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个字母下的名字表
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@property (nonatomic) NSInteger addFriendNum;

@property (nonatomic, weak) id <CXFriendTableViewDelegate> delegate;

- (void)configData:(NSArray *)friendList;

// 画小红点和数字
- (void)addNewFriendsTips:(NSString *)number;

@end
