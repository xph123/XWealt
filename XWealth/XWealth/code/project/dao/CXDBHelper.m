//
//  CXDBHelper.m
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXDBHelper.h"

@implementation CXDBHelper

+ (id)sharedDBHelper
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedDBHelper = nil;
    dispatch_once(&pred, ^{
        _sharedDBHelper = [[[self class] alloc] init];// or some other init method
    });
    return _sharedDBHelper;
}

- (void) createDB:(NSString*)dbName
{
    kAppDelegate.db = [FMDatabase databaseWithPath:dbName];
    kAppDelegate.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbName];
    
    self.groupDao = [[CXGroupDao alloc] init];
    [self.groupDao createTable];
    
    self.groupMemberDao = [[CXGroupMemberDao alloc] init];
    [self.groupMemberDao createTable];
    
    self.friendDao = [[CXFriendDao alloc] init];
    [self.friendDao createTable];
    
    self.userDao = [[CXUserDao alloc] init];
    [self.userDao createTable];
    
    self.addFriendDao = [[CXAddFriendDao alloc] init];
    [self.addFriendDao createTable];
    
    self.commentDao = [[CXCommentDao alloc] init];
    [self.commentDao createTable];
    
    
}


- (id) getFriendDao
{
    return self.friendDao;
}

- (id) getUserDao
{
    return self.userDao;
}

- (id) getAddFriendDao
{
    return self.addFriendDao;
}

- (id) getCommentDao
{
    return self.commentDao;
}

- (id) getGroupDao
{
    return self.groupDao;
}

- (id) getGroupMemberDao
{
    return self.groupMemberDao;
}

@end
