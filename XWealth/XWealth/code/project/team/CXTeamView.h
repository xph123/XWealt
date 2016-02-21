//
//  CXTeamView.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXFriendTableView.h"
#import "CXGroupTableView.h"

@protocol CXTeamViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(id)data andChoiceIndex:(NSInteger) index;
- (void)entryNewFriendViewControler;
@end

@interface CXTeamView : UIView

// 指派给我的任务
@property (nonatomic, strong) CXFriendTableView *friendTable;
@property (nonatomic, strong) NSArray *friendData;
// 外派的任务
@property (nonatomic, strong) CXGroupTableView *groupTable;
@property (nonatomic, strong) NSArray *groupData;


- (void)configFriendData:(NSArray *)friendData;
- (void)configGroupData:(NSArray *)groupData;

// 新的好友的个数
- (void)configNewFriends:(NSString *)number;

@property (nonatomic, weak) id <CXTeamViewDelegate> delegate;

@end
