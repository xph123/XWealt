//
//  CSHttpClient.h
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"


@interface XHttpClient : AFHTTPRequestOperationManager

+ (XHttpClient *)sharedClient;

@end
