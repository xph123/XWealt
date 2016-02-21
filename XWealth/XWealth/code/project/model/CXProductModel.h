//
//  CXProductModel.h
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductModel : NSObject

@property (nonatomic, assign) long productId;
@property (nonatomic, strong) NSString *title; // 产品全称
@property (nonatomic, strong) NSString *proImage; // 产品图片
@property (nonatomic, assign) int category; // 产品分类：0其它、1信托、2资管、3私募
@property (nonatomic, strong) NSString *moneyInto; // 投资方向
@property (nonatomic, assign) int scale; // 发行规模，单位万

@property (nonatomic, strong) NSString *deadline; // 产品期限
@property (nonatomic, strong) NSString *fullDeadline; // 新增产品期限（字段）
@property (nonatomic, strong) NSString *profit; // 预期年化收益
@property (nonatomic, strong) NSString *fullProfit; // 新增预期年化收益

@property (nonatomic, strong) NSString *subscribe; // 认购起点，投资门槛
@property (nonatomic, strong) NSString *bank; // 托管行
@property (nonatomic, strong) NSString *account; // 账号
@property (nonatomic, strong) NSString *accountName; // 户名
@property (nonatomic, strong) NSString *accountBank;// 用户行
@property (nonatomic, strong) NSString *assign; // 分配方式
@property (nonatomic, strong) NSString *proportion; // 配   比

@property (nonatomic, strong) NSString *source; // 还款来源
@property (nonatomic, strong) NSString *riskControl; // 风控措施
@property (nonatomic, strong) NSString *intro; // 项目情况
@property (nonatomic, strong) NSString *introPic; // 项目情况图片
@property (nonatomic, strong) NSString *transContr; // 交易结构

@property (nonatomic, strong) NSString *region; // 投资方向 项目区域
@property (nonatomic, strong) NSString *financing; // 基金经理
@property (nonatomic, strong) NSString *guarantor; // 担保方
@property (nonatomic, strong) NSString *organization; // 投资顾问

@property (nonatomic, strong) NSString *dateline; // 创建时间

@property (nonatomic, assign) int state; // 1：删除；2：停售；3：在售；5：预售；8：热卖；11：包销；15：总包 其中
// 11：包销；15：总包，是新加的
@property (nonatomic, strong) NSString * comment; // 专家点评
@property (nonatomic, assign) int choice; // 是否精选 1为精选，0为普通

@property (nonatomic, strong) NSString *incrementalScale; // 投资递增规模
@property (nonatomic, strong) NSString *establishDate; // 预计成立日期
@property (nonatomic, strong) NSString *playMomeyDate; // 预计打款日期
@property (nonatomic, strong) NSString *earningNote; // 收益说明
@property (nonatomic, strong) NSString *finacingNote; // 基金经理说明
@property (nonatomic, strong) NSString *organizationNote; // 投资顾问说明
@property (nonatomic, strong) NSString *fundPurpose; // 资金用途
@property (nonatomic, strong) NSString *brightSpot; // 产品亮点

@property (nonatomic, assign) int purchase; // 已抢购
@property (nonatomic, assign) int receipts; // 已进款

@property (nonatomic, assign) float buyFee;	//认购费（百分之）
@property (nonatomic, assign) float mgrFee;	//管理费（百分之）
@property (nonatomic, assign) float trustteeFee;	//境内外银行托管费（百分之）
@property (nonatomic, assign) float qdiiFee;		//QDII专户费（百分之）
@property (nonatomic, strong) NSString *reward;		//业绩报酬
@property (nonatomic, strong) NSString *lockArea; // 锁定期

@property (nonatomic, strong) NSString *progressDesc; // 产品进度描述
@property (nonatomic, strong) NSString *cost; // 费用，（公司员工显示费用）

@property (nonatomic, strong) NSString *contract; // 合同
@property (nonatomic, strong) NSString *specification; // 说明书
@property (nonatomic, strong) NSString *material; // 基础材料
@property (nonatomic, strong) NSString *survey; // 尽调报告

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)init;

@end
