//
//  CXSubscribeModel.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSubscribeModel : NSObject

@property (nonatomic, assign) long subscribeId;
@property (nonatomic, assign) long userId;
@property (nonatomic, assign) long productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *requirement;
@property (nonatomic, assign)  double money;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) int payment;
@property (nonatomic, strong) NSString *more;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, assign) int state;// 状态，0 客服未处理，1 客服已处理。 2.  购买成功  3.  未购买
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *idno;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
