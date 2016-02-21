//
//  XDateHelper.h
//  Link
//
//  Created by yi.chen on 14-8-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDateHelper : NSObject

// 获取当前时间（2014-11-11 11：11：11）
+ (NSString *) getCurrentDateline;
// 把字符串(2014-11-11)的时期转成NSDate
+ (NSDate *) stringPlanDateToNSDate:(NSString*) strDate;
// 把字符串（2014-11-11 11：11：11）的时期转成NSDate
+ (NSDate *) stringToNSDate:(NSString*) strDate;

// 指定时期的明天 strDate="2014-11-11"，返回 "2014-11-12"
+ (NSString *) nextDay:(NSString*) strDate;

// 把字符串（2014-11-11 11：11：11）的时期转成11:11
+ (NSString *)translateToDisplay:(NSString *)strDate;

// 把字符串（2014-11-11 11：11：11）的时期转成信托宝显示方式
+ (NSString *)translateToXtbDisplay:(NSString *)strDate;

// 周几和星期几获得
+ (NSInteger) weakDay:(NSDate *) data;
// 今年的第几周
+ (NSInteger) weak:(NSDate *) data;
// 这个月的第几周
+ (NSInteger) weekdayOrdinal:(NSDate *) data;

//获取日期（date_）对用的元素
+ (int)second:(NSDate *)date_;
+ (int)minute:(NSDate *)date_;
+ (int)hour:(NSDate *)date_;
+ (int)day:(NSDate *)date_;
+ (int)month:(NSDate *)date_;
+ (int)year:(NSDate *)date_;

//判断date_是否和当前日期在指定的范围之内
+ (BOOL)isDateToday:(NSDate *)date_;
+ (BOOL)isDateYesterday:(NSDate *)date_;
+ (BOOL)isDateThisWeek:(NSDate *)date_;
+ (BOOL)isDateThisMonth:(NSDate *)date_;
+ (BOOL)isDateThisYear:(NSDate *)date_;
 
//判断两个时间是否在指定的范围之内

+ (BOOL)twoDateIsSameYear:(NSDate *)fistDate_ second:(NSDate *)secondDate_;
+ (BOOL)twoDateIsSameMonth:(NSDate *)fistDate_ second:(NSDate *)secondDate_;
+ (BOOL)twoDateIsSameDay:(NSDate *)fistDate_ second:(NSDate *)secondDate_;

// 获取指定日期所在月的天数
+ (int)numberDaysInMonthOfDate:(NSDate *)date_;
+ (NSDate *)dateByAddingComponents:(NSDate *)date_ offsetComponents:(NSDateComponents *)offsetComponents_;

//获取指定日期所在的月对应的月开始时间和月结束时间
+ (NSDate *)startDateInMonthOfDate:(NSDate *)date_;
+ (NSDate *)endDateInMonthOfDate:(NSDate *)date_;

//判断指定日期是否是本周
- (BOOL)isDateThisWeek:(NSDate *)date;
//把时间戳装换成时间
+ (NSString *)getTimeToShowWithTimestamp:(NSString *)timestamp;
@end
