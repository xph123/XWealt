//
//  CXUserDetailFunctionCell.h
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXUserDetailFunctionCell : UITableViewCell

@property (nonatomic, strong) UIButton *addFriendBtn; 
@property (nonatomic, strong) UIButton *addAppointBtn;
@property (nonatomic, strong) UIButton *addReportBtn;

@property (strong, nonatomic) ActionClickBlk addFriendBtnBlk;
@property (strong, nonatomic) ActionClickBlk addAppointBtnBlk;
@property (strong, nonatomic) ActionClickBlk addReportBtnBlk;

@property (assign, nonatomic) NSInteger isFriend;
@property (assign, nonatomic) NSInteger isRequest;

- (void)setIsFriend:(NSInteger)isFriend andIsRequest:(NSInteger)isRequest;
@end
