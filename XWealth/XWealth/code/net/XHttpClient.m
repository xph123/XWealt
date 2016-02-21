//
//  CSHttpClient.m
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XHttpClient.h"

@implementation XHttpClient

+ (XHttpClient *)sharedClient
{
    static XHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
