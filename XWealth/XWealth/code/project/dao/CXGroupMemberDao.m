//
//  CXGroupMemberDao.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupMemberDao.h"

@implementation CXGroupMemberDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ INTEGER, %@ INTEGER)",GROUPMEMBER_TABLE, column_groupMember_Id, column_groupMember_groupId, column_groupMember_memberId];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) insertMember:(CXUserModel *)model andGroupId:(long)groupId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self insertUserSqlString:model andGroupId:groupId];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) insertMembers:(NSArray*)userList andGroupId:(long)groupId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",GROUPMEMBER_TABLE, column_groupMember_groupId, groupId];
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXUserModel *model in userList) {
            NSString *sqlInsertData = [self insertUserSqlString:model andGroupId:groupId];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


// 删除指定群里的指定用户
- (BOOL) deleteUser:(long)userId withGroupId:(long)groupId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",GROUPMEMBER_TABLE, column_groupMember_groupId, groupId];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

// 删除表数据
- (BOOL) deleteTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ ",GROUPMEMBER_TABLE];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

// 查询指定群的成员列表
- (NSMutableArray*) queryMembersWithGroupId:(long)groupId
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.* FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@=%ld", USER_TABLE, GROUPMEMBER_TABLE, USER_TABLE, GROUPMEMBER_TABLE, column_groupMember_memberId, USER_TABLE, column_user_userId, GROUPMEMBER_TABLE, column_groupMember_groupId, groupId];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            CXUserModel  *model = [CXUserDao analyseUserFMResultSet:rs];
            [array addObject:model];
        }
        
        [rs close];
        [kAppDelegate.db close];
    }
    
    return array;
}

#pragma mark - private methods

- (NSString*) insertUserSqlString:(CXUserModel*) model andGroupId:(long)groupId
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@')  VALUES (%ld, %ld)",GROUPMEMBER_TABLE, column_groupMember_groupId, column_groupMember_memberId, groupId, model.userId];
    
    return sqlInsertData;
}

@end
