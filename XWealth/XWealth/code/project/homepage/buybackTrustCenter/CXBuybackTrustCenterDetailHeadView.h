//
//  CXBuybackTrustCenterDetailHeadView.h
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"
@interface CXBuybackTrustCenterDetailHeadView : UIView
@property (nonatomic, strong) CXBuyBackModel  *buyBackModel;

@property (nonatomic, strong) UILabel *nameLable;          //名称
@property (nonatomic, strong) UILabel *deadlineLable;      //投资期限
@property (nonatomic, strong) UILabel *profitLable;        //收益要求

@property (nonatomic, strong) UILabel *userLable;          //用户
@property (nonatomic, strong) UILabel *userNameLable;      //客户姓名
@property (nonatomic, strong) UILabel *phoneLable;         //电话号码
@property (strong, nonatomic) KDGoalBar *firstGoalBar;

@property (nonatomic, strong) UILabel *transactionLable;      //交易信息
@property (nonatomic, strong) UILabel *incomeLable;          //已进款
@property (nonatomic, strong) UILabel *allowIncomeLable;      //还可进款

@property (nonatomic, strong) UIImageView *leftLine;          //中线
@property (nonatomic, strong) UIImageView *rightLine;          //中线

@property (nonatomic, strong) UILabel *datelineLabel;          //时间


-(id)initWithModel:(CXBuyBackModel *)buyBackModel;
- (CGRect) headViewRect;
@end
