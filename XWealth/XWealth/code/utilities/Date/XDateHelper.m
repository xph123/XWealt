//
//  XDateHelper.m
//  Link
//
//  Created by yi.chen on 14-8-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XDateHelper.h"
@interface XDateHelper()

+ (int)ordinality:(NSDate *)date_ ordinalitySign:(NSCalendarUnit)ordinalitySign_;

@end

@implementation XDateHelper

+ (NSString *) getCurrentDateline
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:MM:SS"];
    NSString *  strCreateTime = [dateformatter stringFromDate:senddate];
    
    return strCreateTime;
}

// 把字符串(2014-11-11)的时期转成NSDate
+ (NSDate *) stringPlanDateToNSDate:(NSString*) strDate
{
    NSString *nowDate = [NSString stringWithFormat:@"%@ 18:00:00", strDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:nowDate];
    
    return date;
}

// 把字符串（2014-11-11 11：11：11）的时期转成NSDate
+ (NSDate *) stringToNSDate:(NSString*) strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    return date;
}

// 指定时期的明天 strDate="2014-11-11"，返回 "2014-11-12"
+ (NSString *) nextDay:(NSString*) strDate
{
    NSString *nowDate = [NSString stringWithFormat:@"%@ 18:00:00", strDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:nowDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    
    [comps setHour:+24]; //+24表示获取下一天的date，-24表示获取前一天的date；
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *nextDate = [calendar dateByAddingComponents:comps toDate:date options:0];   //showDate表示某天的date，nowDate表示showDate的前一天或下一天的date
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  strNextDay = [dateFormatter stringFromDate:nextDate];
    
    return strNextDay;
}

// 把字符串（2014-11-11 11：11：11）的时期转成11:11
+ (NSString *)translateToDisplay:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    if ([XDateHelper isDateToday:date]) {
        int hour = [XDateHelper hour:date];
        [dateFormatter setDateFormat:@"HH:mm"];
        if (hour >=0 && hour < 6) {
            return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            //return [NSString stringWithFormat:@"凌晨%@",[dateFormatter stringFromDate:date]];
        }
        else if (hour >=6 && hour < 12) {
            return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            //return [NSString stringWithFormat:@"上午%@",[dateFormatter stringFromDate:date]];
        }
        else if (hour >=12 && hour < 18) {
            return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            //return [NSString stringWithFormat:@"下午%@",[dateFormatter stringFromDate:date]];
        }
        else {
            return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            //return [NSString stringWithFormat:@"晚上%@",[dateFormatter stringFromDate:date]];
        }
    }
    else if ([XDateHelper isDateYesterday:date]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天%@",[dateFormatter stringFromDate:date]];
        //        return @"昨天";
    }
    else if ([XDateHelper isDateThisWeek:date]) {
        [dateFormatter setDateFormat:@"EEEE HH:mm"];
        return [dateFormatter stringFromDate:date];
    }
    else if ([XDateHelper isDateThisYear:date]) {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }
    else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }
}

// 把字符串（2014-11-11 11：11：11）的时期转成信托宝显示方式
+ (NSString *)translateToXtbDisplay:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    return [dateFormatter stringFromDate:date];
}

// 周几和星期几获得
+ (NSInteger) weakDay:(NSDate *) data
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:data];
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
   
    return weekday;
}

// 今年的第几周
+ (NSInteger) weak:(NSDate *) data
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                         fromDate:data];
    
    NSInteger week = [comps week]; // 今年的第几周
    
    return week;
}

// 这个月的第几周
+ (NSInteger) weekdayOrdinal:(NSDate *) data
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                         fromDate:data];
    
    NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
    
    return weekdayOrdinal;
}

+ (int)second:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSSecondCalendarUnit];
    return ordinality;
}

+ (int)minute:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSMinuteCalendarUnit];
    return ordinality;
}

+ (int)hour:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSHourCalendarUnit];
    return ordinality;
}

+ (int)day:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSDayCalendarUnit];
    return ordinality;
}

+ (int)month:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSMonthCalendarUnit];
    return ordinality;
}

+ (int)year:(NSDate *)date_
{
    int ordinality = [self ordinality:date_ ordinalitySign:NSYearCalendarUnit];
    return ordinality;
}

//-(NSString *)compareDate:(NSDate *)date
//{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
//    NSDate *today = [cal dateFromComponents:components];
//    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
//    NSDate *otherDate = [cal dateFromComponents:components];
//    if([today isEqualToDate:otherDate]) {
//        return @"今天";
//    }
//}

+ (BOOL)isDateToday:(NSDate *)date_
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    //[cal setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSDayCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date_ timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isDateYesterday:(NSDate *)date_
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *yesterday=[NSDate dateWithTimeIntervalSinceNow:-86400];
    
    BOOL success= [cal rangeOfUnit:NSDayCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:yesterday];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date_ timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else{
        return NO;
    }
}

/* 判断date_是否在当前星期 */
+ (BOOL)isDateThisWeek:(NSDate *)date_
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    [cal setFirstWeekday:2];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSWeekCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date_ timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isDateThisMonth:(NSDate *)date_
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSMonthCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:today];

    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date_ timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isDateThisYear:(NSDate *)date_
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    [cal setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSYearCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date_ timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)twoDateIsSameYear:(NSDate *)fistDate_
                   second:(NSDate *)secondDate_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit =NSYearCalendarUnit;
    NSDateComponents *fistComponets = [calendar components:unit fromDate:fistDate_];
    NSDateComponents *secondComponets = [calendar components: unit fromDate: secondDate_];
    
    if ([fistComponets year] == [secondComponets year]){
        return YES;
    }
    return NO;
}

+ (BOOL)twoDateIsSameMonth:(NSDate *)fistDate_
                    second:(NSDate *)secondDate_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit =NSMonthCalendarUnit |NSYearCalendarUnit;
    NSDateComponents *fistComponets = [calendar components:unit fromDate:fistDate_];
    NSDateComponents *secondComponets = [calendar components:unit fromDate:secondDate_];
    
    if ([fistComponets month] == [secondComponets month] &&
        [fistComponets year] == [secondComponets year])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)twoDateIsSameDay:(NSDate *)fistDate_
                  second:(NSDate *)secondDate_
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *fistComponets = [calendar components: unit fromDate:fistDate_];
    NSDateComponents *secondComponets = [calendar components: unit fromDate:secondDate_];
    
    if ([fistComponets day] == [secondComponets day] &&
        [fistComponets month] == [secondComponets month] &&
        [fistComponets year] == [secondComponets year])
    {
        return YES;
    }
    return NO;
}

+ (int)numberDaysInMonthOfDate:(NSDate *)date_
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:date_];

    return range.length;
}

+ (NSDate *)dateByAddingComponents:(NSDate *)date_
                  offsetComponents:(NSDateComponents *)offsetComponents_
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *endOfWorldWar3 = [gregorian dateByAddingComponents:offsetComponents_
                                                        toDate:date_
                                                       options:0];
    return endOfWorldWar3;
}

+ (NSDate *)startDateInMonthOfDate:(NSDate *)date_
{
    double interval = 0;
    NSDate *beginningOfMonth = nil;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit
                           startDate:&beginningOfMonth
                            interval:&interval
                             forDate:date_];
    if (ok){
        return beginningOfMonth;
    }
    else{
        return nil;
    }
}

+ (NSDate *)endDateInMonthOfDate:(NSDate *)date_
{
    double interval = 0;
    NSDate *beginningOfMonth = nil;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit
                           startDate:&beginningOfMonth
                            interval:&interval
                             forDate:date_];
    if (ok){
        NSDate *endDate = [beginningOfMonth dateByAddingTimeInterval:interval];
        return endDate;
    }
    else{
        return nil;
    }
}

- (BOOL)isDateThisWeek:(NSDate *)date
{
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    NSDate *today=[NSDate date];
    BOOL success= [cal rangeOfUnit:NSWeekCalendarUnit
                         startDate:&start
                          interval:&extends
                           forDate:today];
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - 私有方法
+ (int)ordinality:(NSDate *)date_ ordinalitySign:(NSCalendarUnit)ordinalitySign_
{
    int ordinality = -1;
    if (ordinalitySign_ < NSEraCalendarUnit || ordinalitySign_ > NSWeekdayOrdinalCalendarUnit){
        return ordinality;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:ordinalitySign_ fromDate:date_];
    
    switch (ordinalitySign_)
    {
        case NSSecondCalendarUnit:
        {
            ordinality = [components second];
            break;
        }
            
        case NSMinuteCalendarUnit:
        {
            ordinality = [components minute];
            break;
        }
            
        case NSHourCalendarUnit:
        {
            ordinality = [components hour];
            break;
        }
            
        case NSDayCalendarUnit:
        {
            ordinality = [components day];
            break;
        }
            
        case NSMonthCalendarUnit:
        {
            ordinality = [components month];
            break;
        }
            
        case NSYearCalendarUnit:
        {
            ordinality = [components year];
            break;
        }
            
        default:
            break;
    }
    
    return ordinality;
}
+ (NSString *)getTimeToShowWithTimestamp:(NSString *)timestamp
{
    if ([timestamp isEqualToString:@"0"]) {
        return nil;
    }
    NSString *str=timestamp ;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
@end
