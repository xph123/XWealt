//
//  CSHttpInterface.h
//  xProject
//
//  Created by watson on 14-4-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPRequestOperationManager.h"

#import "XHttpClient.h"
#import "XHttpParameters.h"

//block for callback
typedef void (^HttpConnectionSuccessBlock)(AFHTTPRequestOperation *opration,id responseObject);
typedef void (^HttpConnectionFailureBlock)(AFHTTPRequestOperation *opration, NSError *error);

// add by happy
static void (^httpConnectionFailureBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *opration, NSError *error){
    
    //NSLog(@"error: %@",error);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
};

//block callback for download image
typedef void (^DownloadImageSuccessBlock)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image);
typedef void (^DonwloadIageFailureBlock)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error);

//block for post data call
typedef void (^MultipartFormDataBlock)(id <AFMultipartFormData> formData);
typedef void (^UploadProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
typedef void (^DownLoadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);


@interface XHttpInterface : NSObject

// singleton
+ (XHttpInterface *)sharedManager;
// 获得SessionID
+ (NSString *)getSessionId;

- (void)protocolGetTemplateWithParameters:(NSDictionary *)parameters
                                      url:(NSString *)url
                             successBlock:(HttpConnectionSuccessBlock)successBlock
                             failureBlock:(HttpConnectionFailureBlock)failureBlock;

- (void)protocolPostTemplateWithParameters:(NSDictionary *)parameters
                                       url:(NSString *)url
                              successBlock:(HttpConnectionSuccessBlock)successBlock
                              failureBlock:(HttpConnectionFailureBlock)failureBlock;

-(void)protocolPostFormWithParameters:(NSDictionary *)parameters
                                  url:(NSString *)url
                   multipartFormBlock:(MultipartFormDataBlock)multipartFormBlock
                         successBlock:(HttpConnectionSuccessBlock)successBlock
                         failureBlock:(HttpConnectionFailureBlock)failureBlock;
@end
