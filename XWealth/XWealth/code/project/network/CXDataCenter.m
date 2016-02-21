//
//  CSBusinessProcess.m
//  xProject
//
//  Created by yi.chen on 14-4-28.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXDataCenter.h"

#import "CXJsonDataParsing.h"
#import "JSONKit.h"

@implementation CXDataCenter

// 获取数据的接口
+ (void)queryParams:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcess)bProcess
{
    HttpConnectionSuccessBlock sucess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"json data : %@", responseObject);
        NSInteger code = [[responseObject objectForKey:@"ret"] intValue];
        
        if (code == 0)
        {
            id model = [CXJsonDataParsing parsingServiceJsonData:responseObject stringURL:url];
            bProcess(model, nil);
        }
        else
        {
            NSString *errorMsg = [CXErrorCode getErrorCode:code];
            bProcess(nil, errorMsg);
        }
        
    };
    HttpConnectionSuccessBlock fail = ^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"error : %@", err);
//        bProcess(nil, [err description]);
        bProcess(nil, PromptNoNetWork);
    };
    [[XHttpInterface sharedManager] protocolGetTemplateWithParameters:params url:url successBlock:sucess failureBlock:fail];
}

// 上传数据的接口
+ (void)submitParmas:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcessSubmitStatus)bProcess
{
    HttpConnectionSuccessBlock sucess = ^(AFHTTPRequestOperation *operation, id responseObject){
        short code = [[responseObject objectForKey:@"ret"] intValue];
        NSLog(@"json data : %@", responseObject);
        if(code != 0)
        {
            NSString *errorMsg = [CXErrorCode getErrorCode:code];
            NSLog(@"返回状态：%@", errorMsg);
        }
        else
        {
            id model = [CXJsonDataParsing parsingServiceJsonData:responseObject stringURL:url];
            bProcess(model, nil);

        }
    };
    HttpConnectionSuccessBlock fail = ^(AFHTTPRequestOperation *operation, NSError *err) {
//        NSLog(@"error : %@", err);
//        bProcess(nil,err);
        bProcess(nil, PromptNoNetWork);
    };
    [[XHttpInterface sharedManager] protocolPostTemplateWithParameters:params url:url successBlock:sucess failureBlock:fail];
}

// 发送带文件的接口
+(void)sendFilesParams:(NSDictionary *)params strURL:(NSString *)url formBlock:(MultipartFormDataBlock)formBlock resultBlock:(BusinessProcessSubmitStatus)forumProcess
{
    HttpConnectionSuccessBlock success = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"json data : %@", responseObject);
        NSDictionary* responseDict=(NSDictionary *)responseObject;
        NSInteger code = [[responseDict objectForKey:@"ret"] integerValue];
        
        if (code==0)
        {
            id model = [CXJsonDataParsing parsingServiceJsonData:responseObject stringURL:url];
            forumProcess(model,nil);
        }
        else
        {
            NSString *errorMsg = [CXErrorCode getErrorCode:code];
            forumProcess(nil, errorMsg);
        }
        
    };
    
    HttpConnectionFailureBlock fail = ^(AFHTTPRequestOperation *operation, NSError *err) {
//        NSLog(@"error : %@", err);
//        forumProcess(nil,err);
        forumProcess(nil, PromptNoNetWork);
    };
    
    [[XHttpInterface sharedManager] protocolPostFormWithParameters:params url:url multipartFormBlock:formBlock successBlock:success failureBlock:fail];
}


// 登录接口，需要解析sessionId
+ (void)queryParamsForLogin:(NSDictionary *)params strURL:(NSString *)url result:(BusinessProcess)bProcess
{
    HttpConnectionSuccessBlock sucess = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        XLog(@"json data : %@", responseObject);
        NSInteger code = [[responseObject objectForKey:@"ret"] intValue];
        
        if (code == 0)
        {
            //解析并存储Session数据
            NSString * nsSessionID = [self parserResponseDataAndGetSessionID:(operation.response)];
            
            id model = [CXJsonDataParsing parsingServiceJsonData:responseObject stringURL:url];
            
            CXMainPlate *mPlate = model;
            mPlate.service = nsSessionID;
            
            bProcess(mPlate, nil);
        }
        else
        {
            NSString *errorMsg = [CXErrorCode getErrorCode:code];
            bProcess(nil, errorMsg);
        }
    };
    HttpConnectionSuccessBlock fail = ^(AFHTTPRequestOperation *operation, NSError *err) {
//        NSLog(@"error : %@", err);
//        bProcess(nil, [err description]);
        bProcess(nil, PromptNoNetWork);
    };
    [[XHttpInterface sharedManager] protocolGetTemplateWithParameters:params url:url successBlock:sucess failureBlock:fail];
    
}

#pragma mark - Handle  Session
+(NSString *)parserResponseDataAndGetSessionID:(NSHTTPURLResponse *)nsHttpUrlResponseData
{
    if(nil == nsHttpUrlResponseData){
        return nil;
    }
    
    NSString *nsCookie = [[NSString alloc] init];
    NSHTTPURLResponse * nsHttpURLResponse = [[NSHTTPURLResponse alloc] init];
    nsHttpURLResponse = nsHttpUrlResponseData;
    
    //获得HTTP的响应数据头
    NSDictionary *  nsAllHeadFieldData= [nsHttpURLResponse allHeaderFields];
    
    //获得Cookie
    nsCookie = [nsAllHeadFieldData valueForKey:@"Set-Cookie"];
    if(nil == nsCookie){
        return nil;
    }
    
    //获得JSESSIONID
    NSRange nsStartRange = [nsCookie rangeOfString:@"JSESSIONID"];
    NSString *nsSessionID= [[NSString alloc] init];
    if(nsStartRange.location != NSNotFound)
    {
        NSRange nsEndRange = [nsCookie rangeOfString:@";"];
        NSRange nsSessionRange = NSMakeRange(nsStartRange.location+nsStartRange.length+1,nsEndRange.location-nsStartRange.location-nsStartRange.length-1);
        nsSessionID = [nsCookie substringWithRange:nsSessionRange];
    }
    else
    {
        nsSessionID = nil;
    }
    
    //返回JSESSION数据
    return nsSessionID;
}

+(NSString *)parserResponseDataAndGetCookie:(NSHTTPURLResponse *)nsHttpUrlResponseData
{
    if(nil == nsHttpUrlResponseData){
        return nil;
    }
    
    NSString *nsCookie = [[NSString alloc] init];
    NSHTTPURLResponse * nsHttpURLResponse = [[NSHTTPURLResponse alloc] init];
    nsHttpURLResponse = nsHttpUrlResponseData;
    
    //获得HTTP的响应数据头
    NSDictionary *  nsAllHeadFieldData= [nsHttpURLResponse allHeaderFields];
    
    //获得Cookie
    nsCookie = [nsAllHeadFieldData valueForKey:@"Set-Cookie"];
    if(nil == nsCookie){
        return nil;
    }
    
    //返回Cookie数据
    return nsCookie;
}

@end







