//
//  CXMyshareApp2ViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXMyshareApp2ViewController : XViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong)CXMyshareModel *shareModel;
@end
