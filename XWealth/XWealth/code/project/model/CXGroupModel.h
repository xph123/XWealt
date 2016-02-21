//
//  CXGroupModel.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Group_Grade
{
    GROUP_GUEST = 0,
    GROUP_MEMBER,
    GROUP_MANAGER
}GroupGrade;

@interface CXGroupModel : NSObject

@property (nonatomic, assign) long groupID; // 群ID
@property (nonatomic, strong) NSString *groupName; // 群名称
@property (nonatomic, strong) NSString *groupDesc; // 群介绍
@property (nonatomic, strong) NSString *groupLogo; // 群图标
@property (nonatomic, strong) NSString *createDate; // 创建时间
@property (nonatomic, assign) long managerUserId; // 群主用户ID
@property (nonatomic, assign) int  memberCount;//群成员人数
@property (nonatomic, assign) int  remain; // 加群验证：0为需要身份验证，1为允许任何人加群，2为不允许任何人加群。默认为0

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
