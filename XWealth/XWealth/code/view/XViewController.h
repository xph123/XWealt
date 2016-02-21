//
//  XViewController.h
//  Link
//
//  Created by yi.chen on 14-5-29.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XDataCenter.h"
//#import <AliyunOpenServiceSDK/ASIHTTPRequest.h>
#import "MBProgressHUD.h"

@interface XViewController : UIViewController // <XDataCenterDelegate>

//@property (nonatomic, strong) XDataCenter *dataCenter;

@property (nonatomic, strong) MBProgressHUD *HUD;

- (void) ShowProgressHUB:(NSString*)msg;
- (void) ShowProgressHUB:(NSString*)title andMsg:(NSString*)msg;

@end
