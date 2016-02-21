//
//  CSBusinessProcess.h
//  xProject
//
//  Created by yi.chen on 14-4-28.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BusinessProcess)(CXMainPlate *mainPlate, id err);
typedef void (^BusinessProcessSubmitStatus)(id object, id err);

@interface CXDataCenter : NSObject

+ (void)queryParams:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcess)bProcess;


+ (void)submitParmas:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcessSubmitStatus)bProcess;

// 发送带文件的接口
+(void)sendFilesParams:(NSDictionary *)params strURL:(NSString *)url formBlock:(MultipartFormDataBlock)formBlock resultBlock:(BusinessProcessSubmitStatus)forumProcess;

// 登录接口，需要解析sessionId
+ (void)queryParamsForLogin:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcess)bProcess;
@end
