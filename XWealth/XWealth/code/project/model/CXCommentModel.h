//
//  CXCommentModel.h
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCommentModel : NSObject

@property (nonatomic, assign) long commentId; // 评论ID
@property (nonatomic, assign) long taskId; // 任务ID
@property (nonatomic, strong) NSString *content; // 评论内容
@property (nonatomic, assign) long userId; // 评论人
@property (nonatomic, strong) NSString *userName; // 评论人名字
@property (nonatomic, strong) NSString *head; //  评论人头像
@property (nonatomic, strong) NSString *beCommnetUserName; // 被回复者 名字
@property (nonatomic, assign) long beCommentUserId; // 被回复者ID
@property (nonatomic, strong) NSString *dateline; // 评论时间

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
