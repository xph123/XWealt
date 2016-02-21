//
//  CXFriendDao.h
//  Link
//
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXFriendDao : NSObject

// 建表
- (BOOL) createTable;
// 查询好友是否存在
- (BOOL)isFriendExist:(long)userId;
// 添加好友
- (BOOL) insertFriend:(CXUserModel *)model;
// 添加好友表
- (BOOL) insertFriends:(NSArray*)friendList;
// 删除表数据
- (BOOL) deleteTable;
// 删除指定用户
- (BOOL) deleteFriendWithUserId:(long)userId;
// 按ID查询
- (CXUserModel*) queryFriendWithUserId:(long)userId;
// 查询好友
- (NSMutableArray*) queryFriends;

@end
