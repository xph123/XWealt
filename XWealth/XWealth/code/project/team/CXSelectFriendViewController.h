//
//  CXSelectFriendViewController.h
//  Link
//  多选用户
//  Created by chx on 14-11-19.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectFriendView.h"

@protocol SelectFriendViewDelegate <NSObject>

- (void)setMutableSelectedFriends:(NSMutableArray *)friends andType:(NSString*)type;

@end

@interface CXSelectFriendViewController :  XViewController<UIAlertViewDelegate>

@property (nonatomic, strong) CXSelectFriendView *tableView;
@property (nonatomic, strong) NSString *resultType; // 申请的类型，mail，inspect
@property (nonatomic, strong) NSArray *alreadySelectFriends;


@property (nonatomic, weak) id <SelectFriendViewDelegate> delegate;

@end
