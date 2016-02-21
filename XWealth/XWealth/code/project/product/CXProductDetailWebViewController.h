//
//  CXProductDetailWebViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/6.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXInformationDetailTableView.h"
#import "showImageArr.h"
#import "CXProductOperatorView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "CXBuybackTrustCenterViewController.h"
#import "CXViewDataFileViewController.h"
@interface CXProductDetailWebViewController : XViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;
//标题名称
@property (nonatomic, strong) NSString *titleName;

//分享的数据
@property (nonatomic, strong) NSString *url;


@property (nonatomic, strong) CXProductModel *productModel;
@property (nonatomic, assign) long productId;
@property (nonatomic, strong) CXProductOperatorView *operatorView;
@property (nonatomic, assign) int isAttentioned;


@end
