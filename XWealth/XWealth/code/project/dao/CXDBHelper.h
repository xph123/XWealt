//
//  CXDBHelper.h
//  Link
//
//  Created by chx on 14-11-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface CXDBHelper : NSObject

- (void) createDB:(NSString*)dbName;
+ (id)sharedDBHelper;
- (id)getFriendDao;
- (id)getUserDao;
- (id)getAddFriendDao;
- (id)getCommentDao;
- (id)getGroupDao;
- (id)getGroupMemberDao;

@property (nonatomic, strong) CXFriendDao *friendDao;
@property (nonatomic, strong) CXUserDao *userDao;
@property (nonatomic, strong) CXAddFriendDao *addFriendDao;
@property (nonatomic, strong) CXCommentDao *commentDao;
@property (nonatomic, strong) CXGroupDao *groupDao;
@property (nonatomic, strong) CXGroupMemberDao *groupMemberDao;
@end
