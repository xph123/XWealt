//
//  CXWebViewController.h
//  Link
//
//  Created by chx on 15-2-25.
//  Copyright (c) 2015年 ruisk.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *titleName;
@end
