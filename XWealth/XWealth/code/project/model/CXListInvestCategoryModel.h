//
//  CXListInvestCategoryModel.h
//  XWealth
//
//  Created by gsycf on 15/8/17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXListInvestCategoryModel : NSObject
@property (assign, nonatomic) int Id;  // 投向（下拉）* 地产、基建、企业贷款、证券、新三板、其它
                                       //还有付息方式
@property (strong, nonatomic) NSString *name; //
@property (strong, nonatomic) NSString *logoUrl; // logo的url路径
@property (strong, nonatomic) NSString *dateline; // 创建时间
@property (assign, nonatomic) NSInteger state;    // 发布状态，0 有效，1失效
@property (assign, nonatomic) NSInteger categoryId;  // 分类ID


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;
@end
