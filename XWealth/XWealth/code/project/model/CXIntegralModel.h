//
//  CXIntegralModel.h
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXIntegralModel : NSObject

@property (nonatomic, assign) long integralId;
@property (nonatomic, assign) long userId;
@property (nonatomic, assign) long varyPoint;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) long oldPoint;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) long newPoint;
@property (nonatomic, assign) long eventId;
@property (nonatomic, strong) NSString *eventName;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
