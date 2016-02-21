//
//  CXGroupMemberDao.h
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXGroupMemberDao : NSObject

// 建表
- (BOOL) createTable;
// 添加群
- (BOOL) insertMember:(CXUserModel *)model andGroupId:(long)groupId;
// 添加群列表
- (BOOL) insertMembers:(NSArray*)userList andGroupId:(long)groupId;
// 删除指定群里的指定用户
- (BOOL) deleteUser:(long)userId withGroupId:(long)groupId;
// 删除表数据
- (BOOL) deleteTable;
// 查询指定群的成员列表
- (NSMutableArray*) queryMembersWithGroupId:(long)groupId;

@end
