//
//  DateTimeHelper.h
//  Link
//
//  Created by chx on 14-10-30.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDateTimeHelper : NSObject

@property (strong, nonatomic) NSString *dateTime; // "2014-10-30 11:10:09"
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *time;

- (id) initWithDate:(NSString*)date;
- (NSString *) getDate;
- (NSString *) getTime;
- (BOOL) isToday;

@end
