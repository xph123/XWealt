//
//  CXXtbAccount.h
//  XWealth
//  信托宝账户信息
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXXtbAccountModel : NSObject

@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) int hasOpenAutoBid;// 是否开启自动投标：1否，2是
@property (nonatomic, strong) NSString *accountId;// 帐户ID
@property (nonatomic, strong) NSString *trueName;// 帐户对应的真实姓名
@property (nonatomic, strong) NSString *openTime;// 开通帐户的时间戳
@property (nonatomic, strong) NSString *bankCode;// 银行代号
@property (nonatomic, strong) NSString *cardNo;// 银行卡号
@property (nonatomic, strong) NSString *bindTime;// 绑定银行卡的时间戳
@property (nonatomic, strong) NSString *addFundUrl;// 充值URL
@property (nonatomic, strong) NSString *getFundUrl;// 提现URL
@property (nonatomic, strong) NSString *openUrl;	// 开户URL
@property (nonatomic, strong) NSString *autoBidUrl; //自动投标URL
@property (nonatomic, strong) NSString *cashUrl; //我的红包URL
@property (nonatomic, strong) NSString *inviteRewardUrl; //邀请返利URL
@property (nonatomic, strong) NSString *updatePayPwd; //修改支付密码
@property (nonatomic, strong) NSString *fundCustodyUrl; //账户管理
@property (nonatomic, strong) NSString *saleUrl; //资金交易
@property (nonatomic, strong) NSString *gsbInvestStream; //资金流水
@property (nonatomic, strong) NSString *gsbInvestRecord; //投资记录

@property (nonatomic, assign) CGFloat totalFund;// 总资产
@property (nonatomic, assign) CGFloat availableFund;// 可用金额
@property (nonatomic, assign) CGFloat freezeFund;// 冻结金额
@property (nonatomic, assign) CGFloat dueFund;// 待收资产
@property (nonatomic, assign) CGFloat addIncome;// 累计收益

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
