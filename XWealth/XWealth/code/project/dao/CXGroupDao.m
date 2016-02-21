//
//  CXGroupDao.m
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupDao.h"

@interface CXGroupDao()
@end

@implementation CXGroupDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER)",GROUP_TABLE, column_group_groupId, column_group_groupName, column_group_groupDesc, column_group_groupLogo, column_group_createDate, column_group_managerUserId, column_group_memberCount, column_group_remain];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) insertGroup:(CXGroupModel *)model
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self insertUserSqlString:model];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) insertGroups:(NSArray *)groupList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",GROUP_TABLE];
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXGroupModel *model in groupList) {
            NSString *sqlInsertData = [self insertUserSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) replaceIntoGroup:(CXGroupModel *)model
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self replaceIntoUserSqlString:model];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) replaceIntoGroups:(NSArray *)groupList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        for (CXGroupModel *model in groupList) {
            NSString *sqlInsertData = [self replaceIntoUserSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) deleteGroupWithGroupId:(long)groupId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",GROUP_TABLE, column_group_groupId, groupId];
        
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
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ ",GROUP_TABLE];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

// 查找最大的GroupId
- (int) queryMaxGroupId
{
    CXGroupModel  *model = [[CXGroupModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@  order by %@ desc",GROUP_TABLE, column_group_groupId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [self analyseFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model.groupID;

}

-(CXGroupModel *) queryGroupWithGroupId:(long)groupId
{
    CXGroupModel  *model = [[CXGroupModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@  where %@ = %ld", GROUP_TABLE, column_group_groupId, groupId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [self analyseFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model;
}

- (NSMutableArray*) queryGroups
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",GROUP_TABLE];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            CXGroupModel  *model = [self analyseFMResultSet:rs];
            [array addObject:model];
        }
        
        [rs close];
        [kAppDelegate.db close];
    }
    
    return array;
}

#pragma mark - private methods

- (NSString*) insertUserSqlString:(CXGroupModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, '%@', '%@', '%@', '%@', %ld, %d, %d)",GROUP_TABLE, column_group_groupId, column_group_groupName, column_group_groupDesc, column_group_groupLogo, column_group_createDate, column_group_managerUserId, column_group_memberCount, column_group_remain, model.groupID, model.groupName, model.groupDesc, model.groupLogo, model.createDate, model.managerUserId, model.memberCount, model.remain];
    
    return sqlInsertData;
}

- (NSString*) replaceIntoUserSqlString:(CXGroupModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"REPLACE INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, '%@', '%@', '%@', '%@', %ld, %d, %d)",GROUP_TABLE, column_group_groupId, column_group_groupName, column_group_groupDesc, column_group_groupLogo, column_group_createDate, column_group_managerUserId, column_group_memberCount, column_group_remain, model.groupID, model.groupName, model.groupDesc, model.groupLogo, model.createDate, model.managerUserId, model.memberCount, model.remain];
    
    return sqlInsertData;
}


- (CXGroupModel*) analyseFMResultSet:(FMResultSet *)rs
{
    CXGroupModel  *model = [[CXGroupModel alloc] init];
    model.groupID = [rs longForColumn:column_group_groupId];
    model.groupName = [rs stringForColumn:column_group_groupName];
    model.groupDesc = [rs stringForColumn:column_group_groupDesc];
    model.groupLogo = [rs stringForColumn:column_group_groupLogo];
    model.createDate = [rs stringForColumn:column_group_createDate];
    model.managerUserId = [rs longForColumn:column_group_managerUserId];
    model.memberCount = [rs intForColumn:column_group_memberCount];
    model.remain = [rs intForColumn:column_group_remain];
    
    return model;
}


@end
