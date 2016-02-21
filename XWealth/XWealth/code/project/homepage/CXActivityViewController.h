//
//  CXActivityViewController.h
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXActivityViewController : XViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) CGFloat webViewHeight;
//标题名称
@property (nonatomic, strong) NSString *titleName;

//分享的数据
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *nameUrl;

@property (nonatomic, strong) NSString *shareUrl; //可以默认为url，也可做特殊处理
//可选
@property (nonatomic, strong) NSString *imageUrl;  //分享的图标
@property (nonatomic, assign) NSInteger infoId;   //活动分享id


@property (nonatomic, assign) NSInteger activityType;  //活动类型，默认 0热门活动， 1 弹窗活动，
@end
