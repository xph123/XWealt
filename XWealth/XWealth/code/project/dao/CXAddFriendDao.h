//
//  CXAddFriendDao.h
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAddFriendDao : NSObject

// 建表
- (BOOL) createTable;
// 添加用户
- (BOOL) insertNewFriend:(CXAddFriendModel *)model;
// 添加好友表
- (BOOL) insertNewFriends:(NSArray*)friendList;
// 修改好友状态
- (BOOL) updateFriendState:(int)state withUserId:(long)userId;
// 删除指定用户
- (BOOL) deleteFriendWithUserId:(long)userId;
 // 按ID查询
- (CXAddFriendModel*) queryFriendWithUserId:(long)userId;
// 查询申请添加好友的好友表
- (NSMutableArray*) queryApplyFriends;
// 查询所有新的好友
- (NSMutableArray*) queryFriends;


@end
