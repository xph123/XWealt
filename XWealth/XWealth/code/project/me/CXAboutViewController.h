//
//  CXAboutViewController.h
//  XWealth
//
//  Created by chx on 15-3-22.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXAboutViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *connectionUrl;
@property(nonatomic,strong)NSString *name;
@end
