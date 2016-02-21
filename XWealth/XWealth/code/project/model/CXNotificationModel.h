//
//  CXNotificationModel.h
//  XWealth
//
//  Created by gsycf on 15/11/25.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    FileTypeNone = 0,
    FileTypePicture = 1,
    FileTypeVoice = 2,
    FileTypeFile = 3,
    FileTypeCard = 4,
    FileTypePosition = 5,
}FileType;
//通知中心模型(消息)
@interface CXNotificationModel : NSObject
@property (strong, nonatomic) NSString *id;             //消息id
@property (assign, nonatomic) NSInteger type;           //消息类型，用户自定义消息类别
//0   普通消息（聊天消息）1  群发消息 2 系统消息 3  版本更新 4 活动公告 5 产品推介 6 发布产品 7 信托转让 8 信托受让 9 预约产品 16 发布产品(理财师) 17 信托转让(理财师) 18 信托受让(理财师)19 预约产品(理财师) 20 系统提醒(理财师)
@property (strong, nonatomic) NSString *title;          //消息标题
@property (strong, nonatomic) NSString *content;        //消息内容，于type 组合为任何类型消息，content 根据 format 可                                                   表示为 text,json ,xml数据格式
@property (strong, nonatomic) NSString *format;         //content 内容格式 "txt"
@property (strong, nonatomic) NSString *file;           //文件 url
@property (assign, nonatomic) FileType fileType;       //文件类型，可以是声音文件、图片、传送的文件
@property (assign, nonatomic) NSInteger senderId;       //消息发送者账号
@property (assign, nonatomic) NSInteger receiverId;     //消息发送者接收者
@property (strong, nonatomic) NSString *senderName;     //发送者显示名字
@property (strong, nonatomic) NSString *senderHead;     //发送者头像
@property (strong, nonatomic) NSString *receiverHead;   //接收者头像
@property (strong, nonatomic) NSString *receiverName;   //接收者显示名字
@property (assign, nonatomic) NSInteger eventId;        //消息类型对应的id，如产品id，资讯id
@property (assign, nonatomic) NSInteger timestamp;      //创建时间
@property (assign, nonatomic) NSInteger status;              //0: 未发送 1：已发送 2：已接收 3：已查看



- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
