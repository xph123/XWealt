//
//  CXXintuoBaoModel.h
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXintuoBaoModel : NSObject

// 信托宝
@property (assign, nonatomic) long productId;    // 产品ID
@property (strong, nonatomic) NSString *name;   // 产品名称
@property (assign, nonatomic) int activity;     // 1 PC端专享标，2 APP专享标，3其他
@property (assign, nonatomic) int issuance;     // 募集总额（元）
@property (assign, nonatomic) float rate;       // 年化利率
@property (assign, nonatomic) int term;          // 期限（天）
@property (assign, nonatomic) float progress;    // 募集进度
@property (strong, nonatomic) NSString *isDesc;    // 信托宝返回的标签
@property (assign, nonatomic) int  flag;        // 1在售;2预售;3售罄;4冻结;5已回款
@property (strong, nonatomic) NSString *url;     // 产品URL


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
