//
//  CXRecommentViewController.h
//  XWealth
//  邀请
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXRecommentTableView.h"
#import <MessageUI/MessageUI.h>

@interface CXRecommentViewController : XViewController <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) CXRecommentTableView *tableView;
@property (nonatomic, copy) NSMutableArray *contactList;
@property (nonatomic, copy) NSMutableArray *recommentList; // 已注册的推荐好友
@property (nonatomic, strong) NSDictionary *contactDic;

- (id) initWithRedgisterList:(NSMutableArray *) registeredList;
@end
