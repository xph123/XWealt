//
//  CXApplyModel.h
//  Link
//  用于申请加好友、加群的显示cell
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXApplyModel : NSObject

@property (nonatomic, assign) long applyId; // 用户ID或群ID
@property (nonatomic, strong) NSString *name; // 用户名
@property (nonatomic, strong) NSString *logo; // 头像
@property (nonatomic, strong) NSString *signature; // 签名
@property (nonatomic, assign) int isFriend;

@end
