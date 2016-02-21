//
//  CXCommentDao.m
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCommentDao.h"

@implementation CXCommentDao

- (BOOL) createTable
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
//        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT)",COMMENT_TABLE, column_comment_commentId, column_comment_taskId, column_comment_commentUserId, column_comment_content, column_comment_beCommnetUserName, column_comment_dateline];
         NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER, %@ INTEGER, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ TEXT, %@ TEXT, primary key (%@, %@))",COMMENT_TABLE, column_comment_commentId, column_comment_taskId, column_comment_commentUserId, column_comment_commentUserName, column_comment_commentUserHead, column_comment_content, column_comment_beCommnetUserId, column_comment_beCommnetUserName, column_comment_dateline, column_comment_commentId, column_comment_taskId];
        
        res = [kAppDelegate.db executeUpdate:sqlCreateTable];
        [kAppDelegate.db close];
    }

    return res;
}

- (BOOL) insertComment:(CXCommentModel *)model
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self insertCommentSqlString:model];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) insertComments:(NSArray*)commentList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        //        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@",COMMENT_TABLE];
        //        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        for (CXCommentModel *model in commentList) {
            NSString *sqlInsertData = [self insertCommentSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) replaceIntoComment:(CXCommentModel *)model
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqlInsertData = [self replaceIntoCommentSqlString:model];
        res = [kAppDelegate.db executeUpdate:sqlInsertData];
        [kAppDelegate.db close];
    }
    
    return res;
}

- (BOOL) replaceIntoComments:(NSArray *)commentList
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        for (CXCommentModel *model in commentList) {
            NSString *sqlInsertData = [self replaceIntoCommentSqlString:model];
            res = [kAppDelegate.db executeUpdate:sqlInsertData];
        }
        
        [kAppDelegate.db close];
    }
    
    return res;
}


- (BOOL) deleteCommentWithCommentId:(long)commentId andTaskId:(long)taskId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld and %@ = %ld",COMMENT_TABLE, column_comment_commentId, commentId, column_comment_taskId, taskId];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

// 删除指定任务的评论
- (BOOL) deleteCommentWithTaskId:(long)taskId
{
    BOOL res = false;
    
    if ([kAppDelegate.db open])
    {
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ where %@ = %ld ",COMMENT_TABLE, column_comment_taskId, taskId];
        
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
        NSString *sqldelete =  [NSString stringWithFormat:@"delete from %@ ",COMMENT_TABLE];
        
        res = [kAppDelegate.db executeUpdate:sqldelete];
        
        [kAppDelegate.db close];
    }
    
    return res;
}

- (CXCommentModel*) queryCommentWithCommentId:(long)commentId
{
    CXCommentModel  *model = [[CXCommentModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                         @"SELECT %@.*, %@.* FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@ = %ld",COMMENT_TABLE, USER_TABLE, COMMENT_TABLE, USER_TABLE, COMMENT_TABLE, column_comment_commentUserId, USER_TABLE, column_user_userId, COMMENT_TABLE, column_comment_commentId, commentId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [self analyseFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model;
}

- (NSMutableArray*) queryCommentsWithTaskId:(long)taskId
{
    NSMutableArray *array = [NSMutableArray array];
    
    if ([kAppDelegate.db open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT %@.*, %@.* FROM %@ left join %@ on %@.%@=%@.%@ where %@.%@ = %ld",COMMENT_TABLE, USER_TABLE, COMMENT_TABLE, USER_TABLE, COMMENT_TABLE, column_comment_commentUserId, USER_TABLE, column_user_userId, COMMENT_TABLE, column_comment_taskId, taskId];
        
        FMResultSet *rs=[kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            CXCommentModel  *model = [self analyseFMResultSet:rs];
            [array addObject:model];
        }
        
        [rs close];
        [kAppDelegate.db close];
    }
    
    return array;
}

// 查找taskId下的最大的评论ID，用于测试
- (long) queryMaxCommentId:(long)taskId
{
    CXCommentModel  *model = [[CXCommentModel alloc] init];
    
    if ([kAppDelegate.db open])
    {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ WHERE %@=%ld order by %@ desc", COMMENT_TABLE, column_comment_taskId, taskId, column_comment_commentId];
        
        FMResultSet * rs = [kAppDelegate.db executeQuery:sql];
        
        while ([rs next]) {
            model = [self analyseFMResultSet:rs];
            break;
        }
        [kAppDelegate.db close];
    }
    
    return model.commentId;
}

#pragma mark - private methods

- (NSString*) insertCommentSqlString:(CXCommentModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, %ld, %ld, '%@', '%@','%@', %ld, '%@', '%@')",COMMENT_TABLE, column_comment_commentId, column_comment_taskId, column_comment_commentUserId, column_comment_commentUserName, column_comment_commentUserHead, column_comment_content, column_comment_beCommnetUserId, column_comment_beCommnetUserName, column_comment_dateline, model.commentId, model.taskId, model.userId, model.userName, model.head, model.content, model.beCommentUserId, model.beCommnetUserName, model.dateline];
    
    return sqlInsertData;
}

- (NSString*) replaceIntoCommentSqlString:(CXCommentModel*) model
{
    NSString *sqlInsertData =  [NSString stringWithFormat:@"REPLACE INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')  VALUES (%ld, %ld, %ld, '%@', '%@','%@', %ld, '%@', '%@')",COMMENT_TABLE, column_comment_commentId, column_comment_taskId, column_comment_commentUserId, column_comment_commentUserName, column_comment_commentUserHead, column_comment_content, column_comment_beCommnetUserId, column_comment_beCommnetUserName, column_comment_dateline, model.commentId, model.taskId, model.userId, model.userName, model.head, model.content, model.beCommentUserId, model.beCommnetUserName, model.dateline];
    
    return sqlInsertData;
}


- (CXCommentModel*) analyseFMResultSet:(FMResultSet *)rs
{
    CXCommentModel  *commentModel = [[CXCommentModel alloc] init];
    commentModel.userId = [rs longForColumn:column_comment_commentUserId];
    commentModel.userName = [rs stringForColumn:column_comment_commentUserName];
    commentModel.head = [rs stringForColumn:column_comment_commentUserHead];
    commentModel.commentId = [rs longForColumn:column_comment_commentId];
    commentModel.taskId = [rs longForColumn:column_comment_taskId];
    commentModel.content = [rs stringForColumn:column_comment_content];
    commentModel.beCommentUserId = [rs longForColumn:column_comment_beCommnetUserId];
    commentModel.beCommnetUserName = [rs stringForColumn:column_comment_beCommnetUserName];
    commentModel.dateline = [rs stringForColumn:column_comment_dateline];
    
    return commentModel;
}


@end
