//
//  CSHttpInterface.m
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XHttpInterface.h"

@implementation XHttpInterface

+ (XHttpInterface *)sharedManager
{
    static XHttpInterface *_sharedHttpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHttpManager = [[XHttpInterface alloc] init];
    });
    
    return _sharedHttpManager;
}

+ (NSString *) getSessionId
{
    return kAppDelegate.sessionId;
}

// 协议模板
- (void)protocolGetTemplateWithParameters:(NSDictionary *)parameters
                                      url:(NSString *)url
                             successBlock:(HttpConnectionSuccessBlock)successBlock
                             failureBlock:(HttpConnectionFailureBlock)failureBlock
{
    XHttpClient *client = [XHttpClient sharedClient];
    
    [client.requestSerializer setValue:@"Cookie" forHTTPHeaderField:[NSString stringWithFormat:@"JSESSIONID=%@; Path=/", [XHttpInterface getSessionId]]];
    
    [client GET:url parameters:parameters success:successBlock failure:failureBlock];
//        [client GET:url parameters:nil success:successBlock failure:failureBlock];
}

- (void)protocolPostTemplateWithParameters:(NSDictionary *)parameters
                                       url:(NSString *)url
                              successBlock:(HttpConnectionSuccessBlock)successBlock
                              failureBlock:(HttpConnectionFailureBlock)failureBlock
{
    XHttpClient *client = [XHttpClient sharedClient];
    [client.requestSerializer setValue:@"Cookie" forHTTPHeaderField:[NSString stringWithFormat:@"JSESSIONID=%@; Path=/", [XHttpInterface getSessionId]]];
    
    [client POST:url parameters:parameters success:successBlock failure:failureBlock];
}

-(void)protocolPostFormWithParameters:(NSDictionary *)parameters
                                  url:(NSString *)url
                   multipartFormBlock:(MultipartFormDataBlock)multipartFormBlock
                         successBlock:(HttpConnectionSuccessBlock)successBlock
                         failureBlock:(HttpConnectionFailureBlock)failureBlock
{
    XHttpClient* client=[XHttpClient sharedClient];
    [client.requestSerializer setValue:@"Cookie" forHTTPHeaderField:[NSString stringWithFormat:@"JSESSIONID=%@; Path=/", [XHttpInterface getSessionId]]];
    [client POST:url parameters:parameters constructingBodyWithBlock:multipartFormBlock success:successBlock failure:failureBlock];
}


@end
