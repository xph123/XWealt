//
//  CXPopActivityModel.h
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXPopActivityModel : NSObject

@property (nonatomic, assign) int activityId;
@property (nonatomic, assign) int infoId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *btnText;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, assign) int state; // 0,无效/关闭，1，有效/开启
@property (nonatomic, assign) int type; // 分类，0 默认活动，1 新注册推广活动，2 已注册用户活动
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, assign) int platform; // 平台，1 ios， 2 android
@property (nonatomic, assign) int joined; // 0 未参加， 1 参加

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;


@end
