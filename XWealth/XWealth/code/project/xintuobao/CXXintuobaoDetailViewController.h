//
//  CXXintuobaoDetailViewController.h
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXXintuobaoDetailViewController : XViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;


@property (strong, nonatomic) CXXintuoBaoModel *xintuobaoModel;

@end
