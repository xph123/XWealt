//
//  CSMainPlate.h
//  xProject
//
//  Created by yi.chen on 14-4-28.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMainPlate : NSObject

@property (nonatomic, copy)  NSString *service;
@property (nonatomic, copy)  NSString *code;
@property (nonatomic, strong) NSArray *anyModels;
@property (nonatomic, strong) NSArray *additionalModels;
@end
