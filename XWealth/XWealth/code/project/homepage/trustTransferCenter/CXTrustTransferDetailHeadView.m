//
//  CXTrustTransferDetailHeadView.m
//  XWealth
//
//  Created by gsycf on 15/10/28.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferDetailHeadView.h"
#define LABLE_WIDTH      (180.0f)
@implementation CXTrustTransferDetailHeadView
-(id)initWithModel:(CXBenefitModel *)benefitModel
{
    self=[super init];
    if (self) {
        self.backgroundColor=kColorWhite;
        self.benefitModel=benefitModel;
        [self initSubviews];
        [self getData];
    }
    return  self;
    
}

-(void)initSubviews
{

    UIView *backView=[[UIView alloc]initWithFrame:[self backViewRect]];
    backView.backgroundColor=kColorWhite;
    [self addSubview:backView];

    UILabel *nameLable=[[UILabel alloc]initWithFrame:[self nameLableRect]];
    nameLable.font=kMiddleTextFont;
    nameLable.textColor=kTitleTextColor;
    nameLable.numberOfLines=2;
    nameLable.textAlignment=NSTextAlignmentLeft;
    [backView addSubview:nameLable];
    self.nameLable=nameLable;
    
    UIView *oneLine = [[UIView alloc] initWithFrame:[self oneLineRect]];
    oneLine.backgroundColor = kLineColor;
    [self addSubview:oneLine];

    UILabel *deadlineTitleLab=[[UILabel alloc]initWithFrame:[self deadlineTitleLabRect]];
    deadlineTitleLab.font = kMiddleTextFont;
    deadlineTitleLab.textColor = kAssistTextColor;
    deadlineTitleLab.text = [NSString stringWithFormat:@"%@",StringProductDeadline];
    deadlineTitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:deadlineTitleLab];
    
    UILabel *deadlineLable=[[UILabel alloc]initWithFrame:[self deadlineLableRect]];
    deadlineLable.font = kMiddleTextFont;
    deadlineLable.textColor = kAssistTextColor;
    deadlineLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:deadlineLable];
    self.deadlineLable=deadlineLable;
    
    UIView *twoLine = [[UIView alloc] initWithFrame:[self twoLineRect]];
    twoLine.backgroundColor = kLineColor;
    [self addSubview:twoLine];
    
    //
    UILabel *moneyTitleLab=[[UILabel alloc]initWithFrame:[self moneyTitleLabRect]];
    moneyTitleLab.font = kMiddleTextFont;
    moneyTitleLab.textColor = kAssistTextColor;
    moneyTitleLab.text = [NSString stringWithFormat:@"转让金额"];
    moneyTitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:moneyTitleLab];
    
    UILabel *moneyLable=[[UILabel alloc]initWithFrame:[self moneyLableRect]];
    moneyLable.font = kMiddleTextFont;
    moneyLable.textColor = kAssistTextColor;
    moneyLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:moneyLable];
    self.moneyLable=moneyLable;
    
    UIView *thereLine = [[UIView alloc] initWithFrame:[self thereLineRect]];
    thereLine.backgroundColor = kLineColor;
    [self addSubview:thereLine];
    
    UILabel *profitTitleLab=[[UILabel alloc]initWithFrame:[self profitTitleLabRect]];
    profitTitleLab.font = kMiddleTextFont;
    profitTitleLab.textColor = kAssistTextColor;
    profitTitleLab.text = [NSString stringWithFormat:@"%@",StringProductProfit];
    profitTitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:profitTitleLab];
    
    UILabel *profitLable=[[UILabel alloc]initWithFrame:[self profitLableRect]];
    profitLable.font = kMiddleTextFont;
    profitLable.textColor = kAssistTextColor;
    profitLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:profitLable];
    self.profitLable=profitLable;

    UIView *fourLine = [[UIView alloc] initWithFrame:[self fourLineRect]];
    fourLine.backgroundColor = kLineColor;
    [self addSubview:fourLine];
    
    UILabel *userNameTitleLab=[[UILabel alloc]initWithFrame:[self userNameTitleLabRect]];
    userNameTitleLab.font = kMiddleTextFont;
    userNameTitleLab.textColor = kAssistTextColor;
    userNameTitleLab.text = [NSString stringWithFormat:@"%@",StringProductUserName];
    userNameTitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:userNameTitleLab];
    
    UILabel *userNameLable=[[UILabel alloc]initWithFrame:[self userNameLableRect]];
    userNameLable.font = kMiddleTextFont;
    userNameLable.textColor = kAssistTextColor;
    userNameLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:userNameLable];
    self.userNameLable=userNameLable;
    
    UIView *fiveLine = [[UIView alloc] initWithFrame:[self fiveLineRect]];
    fiveLine.backgroundColor = kLineColor;
    [self addSubview:fiveLine];
    
    UILabel *phoneTitleLab=[[UILabel alloc]initWithFrame:[self phoneTitleLabRect]];
    phoneTitleLab.font = kMiddleTextFont;
    phoneTitleLab.textColor = kAssistTextColor;
    phoneTitleLab.text = [NSString stringWithFormat:@"%@",StringConnectionPhone];
    phoneTitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:phoneTitleLab];
    
    UILabel *phoneLable=[[UILabel alloc]initWithFrame:[self phoneLableRect]];
    phoneLable.font = kMiddleTextFont;
    phoneLable.textColor = kAssistTextColor;
    phoneLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:phoneLable];
    self.phoneLable=phoneLable;
    
    UIView *sixLine = [[UIView alloc] initWithFrame:[self sixLineRect]];
    sixLine.backgroundColor = kLineColor;
    [self addSubview:sixLine];
    
    //
    UILabel *establishDateLitleLab=[[UILabel alloc]initWithFrame:[self establishDateLitleLabRect]];
    establishDateLitleLab.font = kMiddleTextFont;
    establishDateLitleLab.textColor = kAssistTextColor;
    establishDateLitleLab.text = [NSString stringWithFormat:@"%@",StringProductEstablishDate];
    establishDateLitleLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:establishDateLitleLab];
    
    UILabel *establishDateLable=[[UILabel alloc]initWithFrame:[self establishDateLableRect]];
    establishDateLable.font = kMiddleTextFont;
    establishDateLable.textColor = kAssistTextColor;
    establishDateLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:establishDateLable];
    self.establishDateLable=establishDateLable;
    
    UILabel *daysLable=[[UILabel alloc]initWithFrame:[self daysLableRect]];
    daysLable.font = kMiddleTextFont;
    daysLable.textColor = kAssistTextColor;
    daysLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:daysLable];
    self.daysLable=daysLable;
    
    UILabel *preProfitLable=[[UILabel alloc]initWithFrame:[self preProfitLableRect]];
    preProfitLable.font = kMiddleTextFont;
    preProfitLable.textColor = kAssistTextColor;
    preProfitLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:preProfitLable];
    self.preProfitLable=preProfitLable;
    
    UILabel *acceptDisCountLable=[[UILabel alloc]initWithFrame:[self acceptDisCountLableRect]];
    acceptDisCountLable.font = kMiddleTextFont;
    acceptDisCountLable.textColor = kAssistTextColor;
    acceptDisCountLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:acceptDisCountLable];
    self.acceptDisCountLable=acceptDisCountLable;
    
    UILabel *payTypeLable=[[UILabel alloc]initWithFrame:[self payTypeLableRect]];
    payTypeLable.font = kMiddleTextFont;
    payTypeLable.textColor = kAssistTextColor;
    payTypeLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:payTypeLable];
    self.payTypeLable=payTypeLable;
}
-(void)getData
{
    self.nameLable.text=self.benefitModel.name;
    int deadlineInt=self.benefitModel.deadline;
    if (deadlineInt >= 12)
    {
        if (deadlineInt % 12 == 0)
        {
            self.deadlineLable.text = [NSString stringWithFormat:@"%d年", deadlineInt / 12];
        }
        else
        {
            self.deadlineLable.text = [NSString stringWithFormat:@"%d月", deadlineInt];
        }
    }
    else
    {
        self.deadlineLable.text = [NSString stringWithFormat:@"%d月", deadlineInt];
    }
    
    self.moneyLable.text=[CXTextFildSet getMoneyUnit:self.benefitModel.money];
    self.moneyLable.textColor=[UIColor redColor];
    
    self.profitLable.text=[NSString stringWithFormat:@"%.1f%%",self.benefitModel.profit];
    //折扣
    if ([self.benefitModel.acceptDisCount isEqualToString:@"1"]) {
        self.acceptDisCountLable.text=[NSString stringWithFormat:@"折扣           是"];
    }
    else
    {
        self.acceptDisCountLable.text=[NSString stringWithFormat:@"折扣           无"];
    }
    //剩余天数
    if (self.benefitModel.days !=0) {
        self.daysLable.text=[NSString stringWithFormat:@"剩余天数    %d天",self.benefitModel.days];
    }
    else
    {
        self.daysLable.text=[NSString stringWithFormat:@"剩余天数    无"];
    }
    
    //预计收益
    if (self.benefitModel.preProfit !=0) {
//        self.preProfitLable.text=[NSString stringWithFormat:@"预计收益    %0.2f万",self.benefitModel.preProfit];
        NSString *profitStr=[NSString stringWithFormat:@"预计收益    %0.2f万",self.benefitModel.preProfit];
        NSRange profitRangecash = [profitStr rangeOfString:[NSString stringWithFormat:@"%0.2f万",self.benefitModel.preProfit]];
        NSMutableAttributedString *profitMutableStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
        [profitMutableStr addAttribute:NSForegroundColorAttributeName value:kColorRed range:profitRangecash];
        self.preProfitLable.attributedText = profitMutableStr;
    }
    else
    {
        self.preProfitLable.text=[NSString stringWithFormat:@"预计收益    无"];
    }
    
    
    NSString *establishDate=[self.benefitModel.establishDate substringToIndex:10];
    self.establishDateLable.text=establishDate;
    
    
    if (kAppDelegate.productPayTypeList && kAppDelegate.productPayTypeList.count > 2)
    {
        for (int i = 0; i < kAppDelegate.productPayTypeList.count; i++)
        {
            CXListInvestCategoryModel *ListInvestCategory = [kAppDelegate.productPayTypeList objectAtIndex:i];
            
            if (ListInvestCategory.Id==self.benefitModel.payType) {
                 self.payTypeLable.text=[NSString stringWithFormat:@"付息方式    %@",ListInvestCategory.name];
            }
           
           
        }

    }
    
    
    //姓名隐藏
        self.userNameLable.text=[CXTextFildSet getNameHide:self.benefitModel.userName];
    
    
    //联系方式
        self.phoneLable.text=[CXTextFildSet getPhoneHide:self.benefitModel.phone];
    
}
#pragma mark -LableRect
- (CGRect) headViewRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = kScreenWidth;
    CGFloat height = [self backViewRect].size.height+kDefaultMargin;
    return CGRectMake(x, y, width, height);
}
- (CGRect) backViewRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = kScreenWidth;
    CGFloat height = [self nameLableRect].size.height+[self deadlineTitleLabRect].size.height+[self moneyTitleLabRect].size.height+[self establishDateLitleLabRect].size.height+[self profitTitleLabRect].size.height+[self userNameTitleLabRect].size.height+[self phoneTitleLabRect].size.height+kSmallMargin*14;
    return CGRectMake(x, y, width, height);
}

- (CGRect) nameLableRect
{

    
    
    CGFloat x = kDefaultMargin;
    CGFloat y = kSmallMargin;
    
    CGFloat width = kScreenWidth-2*kDefaultMargin;
    CGFloat height = kLabelHeight;
    CGSize size = [self.benefitModel.name getSizeWithWidth:width fontSize:kMenuTextFontSize];
    if (size.height > kLabelHeight)
    {
        height = kTwoLineLabelHeight;
    }
    else
    {
        height = kLabelHeight;
    }
    return CGRectMake(x, y, width, height);
}
- (CGRect)oneLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect)deadlineTitleLabRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect)deadlineLableRect
{
    CGFloat x = kDefaultMargin+[self deadlineTitleLabRect].size.width;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = LABLE_WIDTH;
    CGFloat height = kLabelHeight;
    return CGRectMake(x, y, width, height);
}

- (CGRect) profitTitleLabRect
{
    CGFloat x = kScreenWidth/2;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) profitLableRect
{
    CGFloat x = kScreenWidth/2+[self deadlineTitleLabRect].size.width;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = LABLE_WIDTH;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect)twoLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self deadlineTitleLabRect].origin.y+[self deadlineTitleLabRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) moneyTitleLabRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self deadlineTitleLabRect].origin.y+[self deadlineTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) moneyLableRect
{
    CGFloat x = kDefaultMargin+[self deadlineTitleLabRect].size.width;
    CGFloat y = [self deadlineTitleLabRect].origin.y+[self deadlineTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = LABLE_WIDTH;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) acceptDisCountLableRect
{
    CGFloat x = kScreenWidth/2;
    CGFloat y = [self deadlineTitleLabRect].origin.y+[self deadlineTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth*2;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect)thereLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self moneyTitleLabRect].origin.y+[self moneyTitleLabRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) daysLableRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self moneyTitleLabRect].origin.y+[self moneyTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth*2;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) preProfitLableRect
{
    CGFloat x = kScreenWidth/2;
    CGFloat y = [self moneyTitleLabRect].origin.y+[self moneyTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth*2;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}


- (CGRect)fourLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self daysLableRect].origin.y+[self daysLableRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) establishDateLitleLabRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self daysLableRect].origin.y+[self daysLableRect].size.height+kSmallMargin*2;
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) establishDateLableRect
{
    CGFloat x = kDefaultMargin+[self deadlineTitleLabRect].size.width;
    CGFloat y = [self daysLableRect].origin.y+[self daysLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = LABLE_WIDTH;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) payTypeLableRect
{
    CGFloat x = kScreenWidth/2;
    CGFloat y = [self daysLableRect].origin.y+[self daysLableRect].size.height+kSmallMargin*2;
    
    CGFloat width = LABLE_WIDTH*2;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect)fiveLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self establishDateLitleLabRect].origin.y+[self establishDateLitleLabRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) userNameTitleLabRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self establishDateLitleLabRect].origin.y+[self establishDateLitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) userNameLableRect
{
    CGFloat x = kDefaultMargin+[self userNameTitleLabRect].size.width;
    CGFloat y = [self establishDateLitleLabRect].origin.y+[self establishDateLitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect)sixLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self userNameTitleLabRect].origin.y+[self userNameTitleLabRect].size.height+kSmallMargin;
    CGFloat width = kScreenWidth-kDefaultMargin;
    CGFloat height = 0.5;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) phoneTitleLabRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self userNameTitleLabRect].origin.y+[self userNameTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}

- (CGRect) phoneLableRect
{
    CGFloat x = kDefaultMargin+[self phoneTitleLabRect].size.width;
    CGFloat y = [self userNameTitleLabRect].origin.y+[self userNameTitleLabRect].size.height+kSmallMargin*2;
    
    CGFloat width = kLabelWidth+25;
    CGFloat height = kLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
@end
