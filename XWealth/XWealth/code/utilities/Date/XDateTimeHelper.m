//
//  DateTimeHelper.m
//  Link
//
//  Created by chx on 14-10-30.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XDateTimeHelper.h"

@implementation XDateTimeHelper

- (id) initWithDate:(NSString*)date
{
    self = [super init];
    
    if (self)
    {
        // "2014-10-30 11:10:09"
        self.dateTime = date;
        
        if (self.dateTime && self.dateTime.length > 0)
        {
            NSUInteger rangeStr = [self.dateTime rangeOfString:@" "].location;
            NSString *dateStr = [self.dateTime substringWithRange:NSMakeRange(0,rangeStr)];
            NSString *timeStr = [self.dateTime substringWithRange:NSMakeRange(rangeStr + 1, self.dateTime.length - rangeStr - 1)];
            
            self.date = dateStr; // [dateStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
            
            if (timeStr && timeStr.length == 8)
            {
                self.time = [timeStr substringWithRange:NSMakeRange(0,5)];
            }
        }
    }
    
    return self;
}

- (BOOL) isToday
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    

    if (self.date && [self.date isEqualToString:locationString])
    {
        return true;
    }
    
    return false;
}

- (NSString *) getDate
{
    return self.date;
}

- (NSString *) getTime
{
    return self.time;
}


@end
