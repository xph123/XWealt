//
//  CXNotificationModel.m
//  XWealth
//
//  Created by gsycf on 15/11/25.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXNotificationModel.h"

@implementation CXNotificationModel
- (id)init
{
    if (self = [super init]) {

        _id=@"";
        _type=0;
        _title=@"";
        _content=@"";
        _format=@"";
        _file=@"";
        _fileType=0;
        _senderId=0;
        _receiverId=0;
        _senderName=@"";
        _senderHead=@"";
        _receiverHead=@"";
        _receiverName=@"";
        _eventId=0;
        _timestamp=0;
        _status=2;
        
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {

//        NSDictionary *otherDataDictionary=[dictionary objectForKey:@"otherData"];
        _id=[dictionary objectForKey:@"id"];
        _type=[[dictionary objectForKey:@"type"] integerValue];
        _title=[dictionary objectForKey:@"title"];
        _content=[dictionary objectForKey:@"content"];
        _format=[dictionary objectForKey:@"format"];
        _file=[dictionary objectForKey:@"file"];
        _fileType=[[dictionary objectForKey:@"fileType"] intValue];
        _senderId=[[dictionary objectForKey:@"senderId"] integerValue];
        _receiverId=[[dictionary objectForKey:@"receiverId"] integerValue];
        _senderName=[dictionary objectForKey:@"senderName"];
        _senderHead=[dictionary objectForKey:@"senderHead"];
        _receiverHead=[dictionary objectForKey:@"receiverHead"];
        _receiverName=[dictionary objectForKey:@"receiverName"];
        _eventId=[[dictionary objectForKey:@"eventId"] integerValue];
        if ([dictionary objectForKey:@"timestamp"]!=nil) {
             NSString *timeStr=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"timestamp"]];
             _timestamp=[[timeStr substringToIndex:10] integerValue] ;
        }
       

        
        
        _status=[[dictionary objectForKey:@"status"] integerValue];

    }
    return self;
}

@end
