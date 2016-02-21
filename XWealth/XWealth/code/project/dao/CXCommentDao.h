//
//  CXCommentDao.h
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCommentDao : NSObject

// 建表
- (BOOL) createTable;
// 添加评论
- (BOOL) insertComment:(CXCommentModel *)model;
// 添加评论表
- (BOOL) insertComments:(NSArray*)commentList;
// 添加评论，如果评论不存在，添加，如果评论存在，更新
- (BOOL) replaceIntoComment:(CXCommentModel *)model;
// 添加评论表，如果评论不存在，添加，如果评论存在，更新
- (BOOL) replaceIntoComments:(NSArray*)commentList;
// 删除指定评论
- (BOOL) deleteCommentWithCommentId:(long)commentId andTaskId:(long)taskId;
// 删除指定任务的评论
- (BOOL) deleteCommentWithTaskId:(long)taskId;
// 删除表数据
- (BOOL) deleteTable;
// 按ID查询
- (CXCommentModel*) queryCommentWithCommentId:(long)commentId;
// 查询评论表
- (NSMutableArray*) queryCommentsWithTaskId:(long)taskId;

- (long) queryMaxCommentId:(long)taskId; // 查找taskId下的最大的评论ID，用于测试

@end
