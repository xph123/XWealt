//
//  CXUserDao.h
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUserDao : NSObject

// 建表
- (BOOL) createTable;
// 添加用户
- (BOOL) insertUser:(CXUserModel *)model;
// 添加用户表
- (BOOL) insertUsers:(NSArray*)userList;
// 添加用户，如果用户不存在，添加，如果用户存在，更新
- (BOOL) replaceIntoUser:(CXUserModel *)model;
// 添加用户表，如果用户不存在，添加，如果用户存在，更新
- (BOOL) replaceIntoUsers:(NSArray*)userList;
// 删除指定用户
- (BOOL) deleteUserWithUserId:(long)userId;
// 删除表数据
- (BOOL) deleteTable;
// 按ID查询
- (CXUserModel*) queryUserWithUserId:(long)userId;
// 查询用户表
- (NSMutableArray*) queryUsers;

+ (CXUserModel*) analyseUserFMResultSet:(FMResultSet *)rs;

@end
