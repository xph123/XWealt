//
//  CXReceiveMessages.m
//  XWealth
//
//  Created by gsycf on 15/12/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXReceiveMessages.h"

@implementation CXReceiveMessages

//创建新用户文件夹
+ (void) creatFile:(NSString *)fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Path=[paths[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/messages/%@",fileName]];
    // 若不存在userFolder，则建立该文件夹
    if (![fileManager fileExistsAtPath:Path])
    {
        [fileManager createDirectoryAtPath:Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
// 建消息表并添加数据
+ (void) createInformationTable:(NSDictionary *)userInfo andFileName:(NSString *)fileName;
{

    NSDictionary *arrCamp = [userInfo objectForKey:@"aps"];
    CXNotificationModel *notificationModel=[[CXNotificationModel alloc]initWithDictionary:userInfo];
    notificationModel.content=[arrCamp objectForKey:@"alert"];
    
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if (![dataBase open]) {
        NSLog(@"open dataBase fail");
    }
    if (![dataBase executeUpdate:@"create table if not exists message(id integer primary key autoincrement,messageID text,type text,title text,content text,format text,file text,fileType integer,senderId text,receiverId text,senderName text,senderHead text,receiverHead text,receiverName text,eventId text,timestamp text,status text)"]) {
        NSLog(@"create message table fail");
    }
    if (![dataBase executeUpdate:[NSString stringWithFormat:@"insert into message(messageID,type,title,content,format,file,fileType,senderId,receiverId,senderName,senderHead,receiverHead,receiverName,eventId,timestamp,status) values('%@','%ld','%@','%@','%@','%@','%d','%ld','%ld','%@','%@','%@','%@','%ld','%ld','%ld')",notificationModel.id,notificationModel.type,notificationModel.title,notificationModel.content,notificationModel.format,notificationModel.file,notificationModel.fileType,notificationModel.senderId,notificationModel.receiverId,notificationModel.senderName,notificationModel.senderHead,notificationModel.receiverHead,notificationModel.receiverName,notificationModel.eventId,notificationModel.timestamp,notificationModel.status]]) {
        NSLog(@"insert message data fail");
    }
}
// 查询用户表
+ (NSMutableArray*) querytable:(NSString *)fileName;
{
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM message order by id desc"];
        
        FMResultSet *rs=[dataBase executeQuery:sql];
        
        while ([rs next]) {
            CXNotificationModel  *model = [[CXNotificationModel alloc] init];
            model.id = [rs stringForColumn:@"messageID"];
            model.type = [rs longForColumn:@"type"];
            model.title= [rs stringForColumn:@"title"];
           model.content= [rs stringForColumn:@"content"];
            model.format= [rs stringForColumn:@"format"];
            model.file= [rs stringForColumn:@"file"];
            model.fileType = [rs intForColumn:@"fileType"];
            model.senderId = [rs longForColumn:@"senderId"];
            model.receiverId = [rs longForColumn:@"receiverId"];
            model.senderName= [rs stringForColumn:@"senderName"];
            model.senderHead= [rs stringForColumn:@"senderHead"];
            model.receiverHead= [rs stringForColumn:@"receiverHead"];
            model.receiverName= [rs stringForColumn:@"receiverName"];
            model.eventId = [rs longForColumn:@"eventId"];
            model.timestamp= [rs longForColumn:@"timestamp"];
            model.status = [rs longForColumn:@"status"];
            [array addObject:model];
        }
    }
    
    return array;

}

// 根据类型查询信息
+ (NSMutableArray*) querytable:(NSString *)fileName andType:(long)type andcurPage:(long)curPage
{
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        long stateNum=(curPage-1)*10;
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM message  where type = '%d' order by id desc  limit %ld,10",type,stateNum];
        
        FMResultSet *rs=[dataBase executeQuery:sql];
        
        while ([rs next]) {
            CXNotificationModel  *model = [[CXNotificationModel alloc] init];
            model.id = [rs stringForColumn:@"messageID"];
            model.type = [rs longForColumn:@"type"];
            model.title= [rs stringForColumn:@"title"];
            model.content= [rs stringForColumn:@"content"];
            model.format= [rs stringForColumn:@"format"];
            model.file= [rs stringForColumn:@"file"];
            model.fileType = [rs intForColumn:@"fileType"];
            model.senderId = [rs longForColumn:@"senderId"];
            model.receiverId = [rs longForColumn:@"receiverId"];
            model.senderName= [rs stringForColumn:@"senderName"];
            model.senderHead= [rs stringForColumn:@"senderHead"];
            model.receiverHead= [rs stringForColumn:@"receiverHead"];
            model.receiverName= [rs stringForColumn:@"receiverName"];
            model.eventId = [rs longForColumn:@"eventId"];
            model.timestamp= [rs longForColumn:@"timestamp"];
            model.status = [rs longForColumn:@"status"];
            [array addObject:model];
        }
    }
    
    return array;
}
// 查询未读信息
+ (BOOL) querytableUnread:(NSString *)fileName
{
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM message where status !='3' and type !='10' order by id desc"];
        
        FMResultSet *rs=[dataBase executeQuery:sql];
        
        while ([rs next]) {
            CXNotificationModel  *model = [[CXNotificationModel alloc] init];
            model.id = [rs stringForColumn:@"messageID"];
            model.type = [rs longForColumn:@"type"];
            model.title= [rs stringForColumn:@"title"];
            model.content= [rs stringForColumn:@"content"];
            model.format= [rs stringForColumn:@"format"];
            model.file= [rs stringForColumn:@"file"];
            model.fileType = [rs intForColumn:@"fileType"];
            model.senderId = [rs longForColumn:@"senderId"];
            model.receiverId = [rs longForColumn:@"receiverId"];
            model.senderName= [rs stringForColumn:@"senderName"];
            model.senderHead= [rs stringForColumn:@"senderHead"];
            model.receiverHead= [rs stringForColumn:@"receiverHead"];
            model.receiverName= [rs stringForColumn:@"receiverName"];
            model.eventId = [rs longForColumn:@"eventId"];
            model.timestamp= [rs longForColumn:@"timestamp"];
            model.status = [rs longForColumn:@"status"];
            [array addObject:model];
            if (array!=nil&&[array count]>0) {
                
                return YES;
                break;
            }
        }
    }
    
    return NO;

}
// 根据类型查询信息状态
+ (BOOL) querytableState:(NSString *)fileName andType:(NSInteger)type
{
    
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM message where type = '%d' and status !='3' order by id desc",type];
        
        FMResultSet *rs=[dataBase executeQuery:sql];
        
        while ([rs next]) {
            CXNotificationModel  *model = [[CXNotificationModel alloc] init];
            model.id = [rs stringForColumn:@"messageID"];
            model.type = [rs longForColumn:@"type"];
            model.title= [rs stringForColumn:@"title"];
            model.content= [rs stringForColumn:@"content"];
            model.format= [rs stringForColumn:@"format"];
            model.file= [rs stringForColumn:@"file"];
            model.fileType = [rs intForColumn:@"fileType"];
            model.senderId = [rs longForColumn:@"senderId"];
            model.receiverId = [rs longForColumn:@"receiverId"];
            model.senderName= [rs stringForColumn:@"senderName"];
            model.senderHead= [rs stringForColumn:@"senderHead"];
            model.receiverHead= [rs stringForColumn:@"receiverHead"];
            model.receiverName= [rs stringForColumn:@"receiverName"];
            model.eventId = [rs longForColumn:@"eventId"];
            model.timestamp= [rs longForColumn:@"timestamp"];
            model.status = [rs longForColumn:@"status"];
            [array addObject:model];
            if (array!=nil&&[array count]>0) {
                
                return YES;
                break;
            }
                }
    }
    
    return NO;

}
// 查询信息表最后一条数据
+ (NSString*) queryLastDatatable:(NSString *)fileName
{
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    NSString *dataStr=@"";
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM message "];
        
        FMResultSet *rs=[dataBase executeQuery:sql];
        
        while ([rs next]) {
            dataStr=[rs stringForColumn:@"messageID"];
            
        }
        
    }
    return dataStr;
}
// 修改整个类型信息状态
+ (BOOL) updateFriendStateFromType:(int)state withMessageType:(NSInteger)type andfileName:(NSString *)fileName
{
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if (![dataBase open]) {
        NSLog(@"open dataBase fail");
        return NO;
    }
    if (![dataBase executeUpdate:[NSString stringWithFormat:@"update message set status = '%d' where type = '%ld'",state,type]]) {
        NSLog(@"update message data fail");
        return NO;
    }
    return YES;

}
// 修改信息状态
+ (BOOL) updateFriendState:(int)state withMessageId:(NSString *)messageID andfileName:(NSString *)fileName
{
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if (![dataBase open]) {
        NSLog(@"open dataBase fail");
        return NO;
    }
    if (![dataBase executeUpdate:[NSString stringWithFormat:@"update message set status = '%d' where messageID = '%@'",state,messageID]]) {
        NSLog(@"update message data fail");
        return NO;
    }
    return YES;

}
// 更新本地数据（离线获取消息）
+ (BOOL) updateLocalData:(NSMutableArray *)array andfileName:(NSString *)fileName
{
    NSLog(@"%@",NSHomeDirectory());
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/messages/%@/message.rdb",fileName]];
    FMDatabase *dataBase=[FMDatabase databaseWithPath:path];
    if (![dataBase open]) {
        NSLog(@"open dataBase fail");
    }
    if (![dataBase executeUpdate:@"create table if not exists message(id integer primary key autoincrement,messageID text,type text,title text,content text,format text,file text,fileType integer,senderId text,receiverId text,senderName text,senderHead text,receiverHead text,receiverName text,eventId text,timestamp text,status text)"]) {
        NSLog(@"create message table fail");
    }
    for (CXNotificationModel *notificationModel in array) {
    if (![dataBase executeUpdate:[NSString stringWithFormat:@"insert into message(messageID,type,title,content,format,file,fileType,senderId,receiverId,senderName,senderHead,receiverHead,receiverName,eventId,timestamp,status) values('%@','%ld','%@','%@','%@','%@','%d','%ld','%ld','%@','%@','%@','%@','%ld','%ld','2')",notificationModel.id,notificationModel.type,notificationModel.title,notificationModel.content,notificationModel.format,notificationModel.file,notificationModel.fileType,notificationModel.senderId,notificationModel.receiverId,notificationModel.senderName,notificationModel.senderHead,notificationModel.receiverHead,notificationModel.receiverName,notificationModel.eventId,notificationModel.timestamp]]){
        NSLog(@"insert message data fail");
        return NO;
    }
    }
    return YES;
}
// 删除所有数据
+ (BOOL) deleteFile
{
    
    return YES;
}

@end
