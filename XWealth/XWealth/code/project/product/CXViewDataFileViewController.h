//
//  CXViewDataFileViewController.h
//  XWealth
//
//  Created by chx on 15/6/30.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXViewDataFileViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *viewTitle;
@property (nonatomic,strong) NSString *shareName;

@end
