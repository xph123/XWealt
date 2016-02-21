//
//  CXMyshareModel.h
//  XWealth
//
//  Created by gsycf on 15/12/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMyshareModel : NSObject
//分享有礼数据
@property (assign, nonatomic) long Id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;           //内容
@property (strong, nonatomic) NSString *intro;           // url
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *shareUrl;           // 分享
@property (strong, nonatomic) NSString *inviteId;
@property (strong, nonatomic) NSString *integral;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
