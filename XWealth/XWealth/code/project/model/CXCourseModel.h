//
//  CXCourseModel.h
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCourseModel : NSObject
// 知识点
@property (assign, nonatomic) long classId;
@property (strong, nonatomic)  NSString *name;             // 产品名称
@property (strong, nonatomic)  NSString *imageUrl;             // 配图
@property (strong, nonatomic)  NSString *sltImageUrl;             // 缩略图
@property (assign, nonatomic)  int readers;               // 浏览次数
@property (assign, nonatomic)  int goods;               // 点赞次数
@property (assign, nonatomic)  int comments;               // 评论次数
@property (strong, nonatomic)  NSString *url;          //资讯详情url
@property (strong, nonatomic)  NSString *dateline;          //创建时间
@property (assign, nonatomic) int state;                // 状态 ：0，关闭，1 开启，2 推荐
@property (strong, nonatomic) NSString *source;              // 来源
@property (strong, nonatomic) NSString *author;              // 作者
@property (strong, nonatomic) NSString *content;              // 封闭期限
@property (assign, nonatomic) int category;                // 分类：1 银行， 2 信托， 3 证券基金， 4 保险，5 其它
@property (assign, nonatomic) int type;                // 法律用1，解读用2


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
