//
//  NSString+Teshuzifu.m
//  Link
//
//  Created by yi.chen on 14-6-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "NSString+Teshuzifu.h"
#import "sys/utsname.h"

@implementation NSString (Additions)

- (NSString *)tihuanTeshuzifu
{
    NSString *str;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\\\t\n\r\b\f"];
    str = [[self componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString:@""];
    
    return str;
    
    NSString *string;
    NSRange range1= [self rangeOfString:@"\\"];
    if (range1.length) {
        string = [self stringByReplacingOccurrencesOfString:@"\\" withString:@"、"];
        string = [string tihuanTeshuzifu];
    }
    
    NSRange range2= [self rangeOfString:@"\t"];  //tab
    if (range2.length) {
        string = [self stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        string = [string tihuanTeshuzifu];
    }
    
    NSRange range3= [self rangeOfString:@"\n"]; //换行
    if (range3.length) {
        string = [self stringByReplacingCharactersInRange:range3 withString:@""];
        string = [string tihuanTeshuzifu];
        //return string;
    }
    
    NSRange range4= [self rangeOfString:@"\r"]; //回车
    if (range4.length) {
        string = [self stringByReplacingCharactersInRange:range4 withString:@""];
        string = [string tihuanTeshuzifu];
        //return string;
    }
    
    if (string) {
        return string;
    }
    return self;
    
}

- (NSString *)getDeviceTokenString
{
    NSString *string = self;
    NSRange range= [self rangeOfString:@"<"];
    if (range.length) {
        string = [self substringWithRange:NSMakeRange(1, self.length-2)];
    }

    range= [string rangeOfString:@" "]; //空格
    if (range.length) {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
        string = [string getDeviceTokenString];
        return string;
    }

    return self;
}

- (CGSize)getSizeWithWidth:(CGFloat)width fontSize:(CGFloat)aSize
{
    UIFont *font = [UIFont systemFontOfSize:aSize];
    CGSize size;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    }
    else{
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    
    
    return size;
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}

- (NSString*)telephoneWithReformat
{
    NSString *string = self;
    if ([self containsString:@"-"])
    {
        string = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([self containsString:@" "])
    {
        string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([self containsString:@"("])
    {
        string = [self stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([self containsString:@")"])
    {
        string = [self stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    return string;
}

+ (NSString *)timeIntervalSince1970
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *mid = [NSString stringWithFormat:@"%lld",(unsigned long long)time];
    
    return mid;
}

- (NSString *)translateToStandardTime
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:confromTimesp];
    
    return currentDateStr;
}

- (NSString *)translateToIMTimeWithType:(IMTimeType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeInterval time = [self longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
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
        if (type == IMTimeTypeMessageUI) {
            [dateFormatter setDateFormat:@"EEEE"];
        }
        else {
            [dateFormatter setDateFormat:@"EEEE HH:mm"];
        }
        return [dateFormatter stringFromDate:date];
    }
    else if ([XDateHelper isDateThisYear:date]) {
        if (type == IMTimeTypeMessageUI) {
            [dateFormatter setDateFormat:@"MM/dd"];
        }
        else {
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        }
        return [dateFormatter stringFromDate:date];
    }
    else {
        if (type == IMTimeTypeMessageUI) {
            [dateFormatter setDateFormat:@"yyyy"];
        }
        else {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;
}

+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    
    return retStr;
}

- (NSString *)getFormateString
{
    NSString *todayString = self;
    if ([self isEqualToString:@"0:00"]) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-M-d"];
        todayString = [dateFormatter stringFromDate:date];
    }
    return todayString;
}

@end
