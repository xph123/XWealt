//
//  CXTrustTransferDetailHeadView.h
//  XWealth
//
//  Created by gsycf on 15/10/28.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXTrustTransferDetailHeadView : UIView
@property (nonatomic, strong) CXBenefitModel *benefitModel;

@property (nonatomic, strong) UILabel *nameLable;          //名称
@property (nonatomic, strong) UILabel *deadlineLable;      //产品期限
@property (nonatomic, strong) UILabel *moneyLable;         //认购金额
@property (nonatomic, strong) UILabel *profitLable;        //预期收益
@property (nonatomic, strong) UILabel *userNameLable;      //客户姓名
@property (nonatomic, strong) UILabel *phoneLable;         //电话号码
@property (nonatomic, strong) UILabel *establishDateLable; //成立日期
@property (nonatomic, strong) UILabel *daysLable;          //剩余天数
@property (nonatomic, strong) UILabel *preProfitLable;     //预计收益
@property (nonatomic, strong) UILabel *acceptDisCountLable; //折扣
@property (nonatomic, strong) UILabel *payTypeLable;        //付息方式

-(id)initWithModel:(CXBenefitModel *)benefitModel;
- (CGRect) headViewRect;
@end
