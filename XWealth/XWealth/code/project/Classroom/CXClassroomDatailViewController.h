//
//  CXClassroomDatailViewController.h
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "XViewController.h"
//#import "CXClassroomTableView.h"
#import "CXClassroomCommentView.h"
#import "showImageArr.h"
#import "SJAvatarBrowser.h"

@interface CXClassroomDatailViewController : XViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;
@property (nonatomic, strong) CXClassroomCommentView *commentView;
@property (nonatomic, assign) NSInteger courseId;
@end
