//
//  CXAddFriendDao.m
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXAddFriendDao.h"

@implementation CXAddFriendDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY, %@ TEXT, %@ INTEGER)",ADDFRIEND_TABLE, column_addFriend_userId, column_addFriend_applyInfo, column_addFriend_isFriend];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) insertNewFriend:(CXAddFriendModel *)model
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self insertFriendSqlString:model];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}

// 添加整块的好友时，先删除现有的数据，再重新加入
- (BOOL) insertNewFriends:(NSArray*)friendList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",ADDFRIEND_TABLE];
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXAddFriendModel *model in friendList) {
            NSString *sqlInsertData = [self insertFriendSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) updateFriendState:(int)state withUserId:(long)userId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE %@ SET %@ = %d WHERE %@ = %ld",
                               ADDFRIEND_TABLE, column_addFriend_isFriend, state,  column_addFriend_userId, userId];
        
        res = [kAppDelegate.db executeUpdate:updateSql];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) deleteFriendWithUserId:(long)userId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",ADDFRIEND_TABLE, column_addFriend_userId, userId];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (CXAddFriendModel*) queryFriendWithUserId:(long)userId
{
    CXAddFriendModel  *model = [[CXAddFriendModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.*, %@.%@, %@.%@ FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@ = %ld", USER_TABLE, ADDFRIEND_TABLE, column_addFriend_applyInfo, ADDFRIEND_TABLE, column_addFriend_isFriend, ADDFRIEND_TABLE, USER_TABLE, ADDFRIEND_TABLE, column_addFriend_userId, USER_TABLE, column_user_userId, ADDFRIEND_TABLE, column_addFriend_userId, userId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [self analyseFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model;
}

- (NSMutableArray*) queryFriends
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.*, %@.%@ , %@.%@ FROM %@ left join %@ on %@.%@=%@.%@", USER_TABLE, ADDFRIEND_TABLE, column_addFriend_applyInfo, ADDFRIEND_TABLE, column_addFriend_isFriend, ADDFRIEND_TABLE, USER_TABLE, ADDFRIEND_TABLE, column_addFriend_userId, USER_TABLE, column_user_userId];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            CXAddFriendModel  *model = [self analyseFMResultSet:rs];
            [array addObject:model];
        }
        
        [rs close];
        [kAppDelegate.db close];
    }
    
    return array;
}

// 查询申请添加好友的好友表
- (NSMutableArray*) queryApplyFriends
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.*, %@.%@, %@.%@ FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@ = %d", USER_TABLE, ADDFRIEND_TABLE, column_addFriend_applyInfo, ADDFRIEND_TABLE, column_addFriend_isFriend, ADDFRIEND_TABLE, USER_TABLE, ADDFRIEND_TABLE, column_addFriend_userId, USER_TABLE, column_user_userId, ADDFRIEND_TABLE, column_addFriend_isFriend, FRIEND_NO];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            CXAddFriendModel  *model = [self analyseFMResultSet:rs];
            [array addObject:model];
        }
        
        [rs close];
        [kAppDelegate.db close];
    }
    
    return array;
}

#pragma mark - private methods

- (NSString*) insertFriendSqlString:(CXAddFriendModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@')  VALUES (%ld, '%@', %d)",ADDFRIEND_TABLE, column_addFriend_userId, column_addFriend_applyInfo, column_addFriend_isFriend, model.userId, model.applyInfo, model.isFriend];
    
    return sqlInsertData;
}

- (CXAddFriendModel*) analyseFMResultSet:(FMResultSet *)rs
{
    CXAddFriendModel *addFriendModel = [[CXAddFriendModel alloc] init];
    addFriendModel.isFriend = [rs longForColumn:column_addFriend_isFriend];
    addFriendModel.userId = [rs longForColumn:column_addFriend_userId];
    addFriendModel.applyInfo = [rs stringForColumn:column_addFriend_applyInfo];
    
    CXUserModel  *model = [CXUserDao analyseUserFMResultSet:rs];
    
    addFriendModel.user = model;
    
    return addFriendModel;
}


@end
