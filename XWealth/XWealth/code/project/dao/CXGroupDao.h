//
//  CXGroupDao.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXGroupDao : NSObject

// 建表
- (BOOL) createTable;
// 添加群
- (BOOL) insertGroup:(CXGroupModel *)model;
// 添加群列表
- (BOOL) insertGroups:(NSArray*)groupList;
// 添加群，如果群不存在，添加，如果群存在，更新
- (BOOL) replaceIntoGroup:(CXGroupModel *)model;
// 添加群列表，如果群不存在，添加，如果群存在，更新
- (BOOL) replaceIntoGroups:(NSArray*)groupList;
// 删除指定群
- (BOOL) deleteGroupWithGroupId:(long)groupId;
// 删除表数据
- (BOOL) deleteTable;
- (int) queryMaxGroupId; // 查找最大的GroupId
// 按ID查询
- (CXGroupModel*) queryGroupWithGroupId:(long)groupId;
// 查询群列表
- (NSMutableArray*) queryGroups;


@end
