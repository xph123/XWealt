//
//  CXInformationDetailViewController.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationDetailTableView.h"
#import "CXCommentView.h"
#import "showImageArr.h"

@interface CXInformationDetailViewController : XViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;
@property (nonatomic, strong) CXInformationDetailTableView *tableView;
@property (nonatomic, strong) CXCommentView *commentView;
@property (nonatomic, assign) NSInteger informationId;

@end
