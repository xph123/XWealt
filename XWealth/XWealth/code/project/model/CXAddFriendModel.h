//
//  CXAddFriendModel.h
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAddFriendModel : NSObject

typedef enum Friend_state
{
    FRIEND_NO,
    FRIEND_YES,
    FRIEND_REFUSE
}FriendState;

// 接口数据
@property (nonatomic, assign) long userId;  // 用户ID
@property (nonatomic, strong) NSString *applyInfo; // 验证信息
@property (nonatomic, assign) int isFriend; // 是否是好友，1为好友，0为非好友，2为拒绝加好友
@property (nonatomic, strong) NSString *dateline;

@property (nonatomic, strong) CXUserModel *user; // userId 对应的用户

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
