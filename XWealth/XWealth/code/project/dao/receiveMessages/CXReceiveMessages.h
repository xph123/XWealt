//
//  CXReceiveMessages.h
//  XWealth
//
//  Created by gsycf on 15/12/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXReceiveMessages : NSObject
@property(nonatomic,assign)NSString *MessageFileName;
//通知中心数据库操作
//创建新用户文件夹
+ (void) creatFile:(NSString *)fileName;
// 建资讯表并添加数据
+ (void) createInformationTable:(NSDictionary *)userInfo andFileName:(NSString *)fileName;

// 查询信息表
+ (NSMutableArray*) querytable:(NSString *)fileName;
// 查询信息表最后一条数据
+ (NSString *) queryLastDatatable:(NSString *)fileName;
// 根据类型查询信息
+ (NSMutableArray*) querytable:(NSString *)fileName andType:(long)type andcurPage:(long)curPage;


// 查询未读信息
+ (BOOL) querytableUnread:(NSString *)fileName;
//  根据类型查询信息状态
+ (BOOL) querytableState:(NSString *)fileName andType:(NSInteger)type;

// 修改整个类型信息状态
+ (BOOL) updateFriendStateFromType:(int)state withMessageType:(NSInteger)type andfileName:(NSString *)fileName;
// 修改信息状态
+ (BOOL) updateFriendState:(int)state withMessageId:(NSString *)messageID andfileName:(NSString *)fileName;
// 更新本地数据（离线获取消息）
+ (BOOL) updateLocalData:(NSMutableArray *)array andfileName:(NSString *)fileName;
// 删除所有数据
+ (BOOL) deleteFile;
@end
