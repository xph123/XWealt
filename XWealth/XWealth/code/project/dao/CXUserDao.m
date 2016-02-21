//
//  CXUserDao.m
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserDao.h"


@implementation CXUserDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT)",USER_TABLE, column_user_userId, column_user_userName, column_user_nickName, column_user_headImg, column_user_signature, column_user_telePhone, column_user_mail, column_user_address, column_user_occupation, column_user_sex, column_user_grade, column_user_integral, column_user_remarksName, column_user_remarksEmail];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) insertUser:(CXUserModel *)model
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


- (BOOL) insertUsers:(NSArray*)userList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
//        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",USER_TABLE];
//        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXUserModel *model in userList) {
            NSString *sqlInsertData = [self insertUserSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) replaceIntoUser:(CXUserModel *)model
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

- (BOOL) replaceIntoUsers:(NSArray *)userList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        for (CXUserModel *model in userList) {
            NSString *sqlInsertData = [self replaceIntoUserSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) deleteUserWithUserId:(long)userId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld",USER_TABLE, column_user_userId, userId];
        
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
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ ",USER_TABLE];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (CXUserModel*) queryUserWithUserId:(long)userId
{
    CXUserModel  *model = [[CXUserModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@  where %@ = %ld",USER_TABLE, column_user_userId, userId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [CXUserDao analyseUserFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model;
}

- (NSMutableArray*) queryUsers
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",USER_TABLE];
        
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

- (NSString*) insertUserSqlString:(CXUserModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %d, %d, %d, '%@', '%@')",USER_TABLE, column_user_userId, column_user_userName, column_user_nickName, column_user_headImg, column_user_signature, column_user_telePhone, column_user_mail, column_user_address, column_user_occupation, column_user_sex, column_user_grade, column_user_integral, column_user_remarksName, column_user_remarksEmail, model.userId, model.userName, model.nickName, model.headImg, model.signature, model.telePhone, model.mail, model.address, model.occupation, model.sex, model.grade, model.integral, model.remarksName, model.remarksEmail];
    
    return sqlInsertData;
}

- (NSString*) replaceIntoUserSqlString:(CXUserModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"REPLACE INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %d, %d, %d, '%@', '%@')",USER_TABLE, column_user_userId, column_user_userName, column_user_nickName, column_user_headImg, column_user_signature, column_user_telePhone, column_user_mail, column_user_address, column_user_occupation, column_user_sex, column_user_grade, column_user_integral, column_user_remarksName, column_user_remarksEmail, model.userId, model.userName, model.nickName, model.headImg, model.signature, model.telePhone, model.mail, model.address, model.occupation, model.sex, model.grade, model.integral, model.remarksName, model.remarksEmail];
    
    return sqlInsertData;
}


+ (CXUserModel*) analyseUserFMResultSet:(FMResultSet *)rs
{
    CXUserModel  *model = [[CXUserModel alloc] init];
    model.userId = [rs longForColumn:column_user_userId];
    model.userName = [rs stringForColumn:column_user_userName];
    model.nickName = [rs stringForColumn:column_user_nickName];
    model.headImg = [rs stringForColumn:column_user_headImg];
    model.signature = [rs stringForColumn:column_user_signature];
    model.telePhone = [rs stringForColumn:column_user_telePhone];
    model.mail = [rs stringForColumn:column_user_mail];
    model.address = [rs stringForColumn:column_user_address];
    model.occupation = [rs stringForColumn:column_user_occupation];
    model.sex = [rs intForColumn:column_user_sex];
    model.grade = [rs intForColumn:column_user_grade];
    model.integral = [rs intForColumn:column_user_integral];
    
    model.remarksName = [rs stringForColumn:column_user_remarksName];
    model.remarksEmail = [rs stringForColumn:column_user_remarksEmail];
    
    return model;
}


@end
