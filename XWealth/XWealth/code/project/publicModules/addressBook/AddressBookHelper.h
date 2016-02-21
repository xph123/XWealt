//
//  AddressBookHelper.h
//  Link
//
//  Created by wangqi on 14-8-18.
//  Copyright (c) 2014年 51sole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookHelper : NSObject

+ (NSDictionary *)getAllContact;
+ (NSString *)getPhones;
+ (void)addPeopleWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber companyName:(NSString *)companyName department:(NSString *)department email:(NSString *)email headImg:(UIImage *)headImg;
@end
