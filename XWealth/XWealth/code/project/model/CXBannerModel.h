//
//  CXBannerModel.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBannerModel : NSObject

@property (nonatomic, assign) int bannerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) long productId;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, assign) int state; // 0,无效/关闭，1，有效/开启
@property (nonatomic, assign) int indexs; // 手机端显示序号（1，2.3）按123进行显示
@property (nonatomic, assign) int ptypeId; // 分类，用于识别banner的类型，1 为产品，2 为理财学堂，3为资讯

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
