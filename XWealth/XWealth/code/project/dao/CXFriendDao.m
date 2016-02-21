//
//  CXFriendDao.m
//  Link
//
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXFriendDao.h"


@interface CXFriendDao()
@end

@implementation CXFriendDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ INTEGER)",FRIEND_TABLE, column_friend_Id, column_friend_userId];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL)isFriendExist:(long)userId
{
    BOOL exist = NO;
    if ([kAppDelegate.db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where %@ = %ld", FRIEND_TABLE, column_friend_userId, userId];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        while ([rs next]) {
            exist = YES;
            break;
        }
        [kAppDelegate.db close];
    }
    return exist;
}


- (BOOL) insertFriend:(CXUserModel *)model
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
- (BOOL) insertFriends:(NSArray*)friendList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",FRIEND_TABLE];
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXUserModel *model in friendList) {
            NSString *sqlInsertData = [self insertFriendSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }

        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) deleteTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",FRIEND_TABLE];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) deleteFriendWithUserId:(long)userId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",FRIEND_TABLE, column_friend_userId, userId];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (CXUserModel*) queryFriendWithUserId:(long)userId
{
    CXUserModel  *model = [[CXUserModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.* FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@ = %ld", USER_TABLE, FRIEND_TABLE, USER_TABLE, FRIEND_TABLE, column_friend_userId, USER_TABLE, column_user_userId, FRIEND_TABLE, column_friend_userId, userId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [CXUserDao analyseUserFMResultSet:rs];
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
                          @"SELECT %@.* FROM %@ left join %@ on %@.%@=%@.%@ order by %@.%@ asc", USER_TABLE, FRIEND_TABLE, USER_TABLE, FRIEND_TABLE, column_friend_userId, USER_TABLE, column_user_userId, USER_TABLE, column_user_nickName];
        
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

- (NSString*) insertFriendSqlString:(CXUserModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@')  VALUES (%ld)",FRIEND_TABLE, column_friend_userId, model.userId];
    
    return sqlInsertData;
}

@end
