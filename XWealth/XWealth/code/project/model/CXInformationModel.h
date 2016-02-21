//
//  CXInformation.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXInformationModel : NSObject

@property (nonatomic, assign) long informationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *sltImageUrl;   //图片1：版式一，2：版式二(原来默认)；3：版式三
@property (nonatomic, strong) NSString *sltImageUrl2;
@property (nonatomic, strong) NSString *sltImageUrl3;
@property (nonatomic, assign) int comments;
@property (nonatomic, assign) int goods;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, assign) int state; // 状态 ：0，关闭，1 开启
@property (nonatomic, assign) int category;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) int imgWidth;
@property (nonatomic, assign) int imgHeight;
@property (nonatomic, strong) NSString *pageType;    //判断第几个板式



- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
