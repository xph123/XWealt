//
//  CXTextFildSet.h
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTextFildSet : NSObject
// 名称隐藏部分
+ (NSString *) getNameHide:(NSString *)str;
// 手机隐藏部分
+ (NSString *) getPhoneHide:(NSString *)str;
// 调整金钱单位
+ (NSString *) getMoneyUnit:(int)num;
@end
