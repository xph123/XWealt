//
//  CXProductListScheduleModel.h
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductListScheduleModel : NSObject
@property (nonatomic, assign) long Id;
@property (nonatomic, assign) NSInteger productId;//
@property (nonatomic, assign) NSInteger total;//金额
@property (nonatomic, assign) NSString *type;// 类型：1代表 开始    2代表 打款进度     3代表 结束
@property (nonatomic, strong) NSString *dateline;// 时间
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
