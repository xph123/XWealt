//
//  CXBuybackTrustCenterDetailHeadView.m
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterDetailHeadView.h"
#define LABLE_WIDTH      (130.0f)
#define ITEMVIEW_HEIGHT     (128.5)//(20 + kLabelHeight)
@implementation CXBuybackTrustCenterDetailHeadView
-(id)initWithModel:(CXBuyBackModel *)buyBackModel
{
    self=[super init];
    if (self) {
        self.backgroundColor=kColorWhite;
        self.buyBackModel=buyBackModel;
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
    nameLable.font=kMenuTextFont;
    nameLable.textColor=kTextColor;
    nameLable.numberOfLines=1;
    nameLable.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:nameLable];
    self.nameLable=nameLable;
    
    UILabel *deadlineLable=[[UILabel alloc]initWithFrame:[self deadlineLableRect]];
    deadlineLable.layer.borderWidth=0.5;
    deadlineLable.layer.borderColor=kxintuoOrangeColor.CGColor;
    deadlineLable.layer.cornerRadius=10.0f;
    deadlineLable.textColor=kxintuoOrangeColor;
    deadlineLable.font=[UIFont systemFontOfSize:10];
    deadlineLable.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:deadlineLable];
    self.deadlineLable=deadlineLable;
    
    
    
    UILabel *profitLable=[[UILabel alloc]initWithFrame:[self profitLableRect]];
    profitLable.layer.borderWidth=0.5f;
    profitLable.layer.borderColor=kxintuoOrangeColor.CGColor;
    profitLable.layer.cornerRadius=10.0f;
    profitLable.textColor=kxintuoOrangeColor;
    profitLable.font=[UIFont systemFontOfSize:10];
    profitLable.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:profitLable];
    self.profitLable=profitLable;
    
    UILabel *userLable=[[UILabel alloc]initWithFrame:[self userLableRect]];
    userLable.font = kSmallTextFont;
    userLable.textColor = kAssistTextColor;
    userLable.textAlignment = NSTextAlignmentLeft;
    userLable.text=@"客户";
    [backView addSubview:userLable];
    self.userLable=userLable;
    
    UILabel *userNameLable=[[UILabel alloc]initWithFrame:[self userNameLableRect]];
    userNameLable.font = kSmallTextFont;
    userNameLable.textColor = kAssistTextColor;
    userNameLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:userNameLable];
    self.userNameLable=userNameLable;
    
    
    UILabel *phoneLable=[[UILabel alloc]initWithFrame:[self phoneLableRect]];
    phoneLable.font = kSmallTextFont;
    phoneLable.textColor = kAssistTextColor;
    phoneLable.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:phoneLable];
    self.phoneLable=phoneLable;
    
//    UILabel *transactionLable=[[UILabel alloc]initWithFrame:[self transactionLableRect]];
//    transactionLable.font = kSmallTextFont;
//    transactionLable.textColor = kAssistTextColor;
//    transactionLable.textAlignment = NSTextAlignmentRight;
//    transactionLable.text=@"交易信息";
//    [backView addSubview:transactionLable];
//    self.transactionLable=transactionLable;
    
    UILabel *incomeLable=[[UILabel alloc]initWithFrame:[self incomeLableRect]];
    incomeLable.font=kSmallTextFont;
    incomeLable.textColor=kAssistTextColor;
    incomeLable.numberOfLines=1;
    incomeLable.textAlignment=NSTextAlignmentRight;
    [backView addSubview:incomeLable];
    self.incomeLable=incomeLable;
    
    UILabel *allowIncomeLable=[[UILabel alloc]initWithFrame:[self allowIncomeLableRect]];
    allowIncomeLable.font=kSmallTextFont;
    allowIncomeLable.textColor=kAssistTextColor;
    allowIncomeLable.numberOfLines=1;
    allowIncomeLable.textAlignment=NSTextAlignmentRight;
    [backView addSubview:allowIncomeLable];
    self.allowIncomeLable=allowIncomeLable;
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:[self leftLineRect]];
    leftLine.backgroundColor = [UIColor clearColor];
//    //添加背景图片
//    CGFloat top = 2; // 顶端盖高度
//    CGFloat bottom = 2 ; // 底端盖高度
//    CGFloat left = 1; // 左端盖宽度
//    CGFloat right = 1; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backIma=[UIImage imageNamed:@"lineLeft"];
//    UIImage *back2Ima=[backIma resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    leftLine.image=backIma;
    leftLine.contentMode=UIViewContentModeScaleAspectFill;
    leftLine.clipsToBounds=YES;
    [backView addSubview:leftLine];
    self.leftLine=leftLine;


    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:[self rightLineRect]];
    rightLine.backgroundColor = [UIColor clearColor];
//    //添加背景图片
//    CGFloat rightLineTop = 2; // 顶端盖高度
//    CGFloat rightLineBottom = 2 ; // 底端盖高度
//    CGFloat rightLineLeft = 1; // 左端盖宽度
//    CGFloat rightLineRight = 1; // 右端盖宽度
//    UIEdgeInsets rightLineInsets = UIEdgeInsetsMake(rightLineTop, rightLineBottom, rightLineLeft, rightLineRight);
    UIImage *rightLineBackIma=[UIImage imageNamed:@"lineRight"];
//    UIImage *rightLineBack2Ima=[rightLineBackIma resizableImageWithCapInsets:rightLineInsets resizingMode:UIImageResizingModeStretch];
    
    rightLine.image=rightLineBackIma;
    rightLine.contentMode=UIViewContentModeScaleAspectFill;
    rightLine.clipsToBounds=YES;
    [backView addSubview:rightLine];
    self.rightLine=rightLine;
    
    _datelineLabel = [[UILabel alloc] initWithFrame:[self datelineRect]];
    _datelineLabel.font = kExtralSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_datelineLabel];

    

    

}
- (NSString *)dateDifferent:(CGFloat)purchase
{
    NSString *dateContent;
    if (purchase==1) {
        dateContent=@"已结束";
    }
    else
    {
        dateContent=@"已认购";
    }
    
    return dateContent;
}
-(void)getData
{
    if (_firstGoalBar != nil)
    {
        [_firstGoalBar removeFromSuperview];
    }
    CGFloat purchase = (CGFloat)_buyBackModel.receipts *100 / _buyBackModel.money;
    NSString *dateDiff = [self dateDifferent:purchase];
    _firstGoalBar=[[KDGoalBar alloc]initWithFrame:[self firstGoalBarRect] andSetbackImage:@"circle_outBack" andLineSize:2];
    [_firstGoalBar setAllowDragging:NO];
    [_firstGoalBar setAllowSwitching:NO];
    
    [_firstGoalBar setPercent:purchase andTitle:@"" andFail:dateDiff animated:NO];
//    [_firstGoalBar setPercentLabFont:20.0f];
    [self addSubview:_firstGoalBar];
    
    
    [self addSubview:_firstGoalBar];
    
    NSString *cash = [NSString stringWithFormat:@"%@",[CXTextFildSet getMoneyUnit:_buyBackModel.receipts]];
    
    NSString *cashStr = [NSString stringWithFormat:@"已购：%@ ",cash];
    NSRange rangecash = [cashStr rangeOfString:cash];
    NSMutableAttributedString *cashMutableStr = [[NSMutableAttributedString alloc] initWithString:cashStr];
    [cashMutableStr addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:rangecash];
    self.incomeLable.attributedText = cashMutableStr;
    
    
    NSString *allowIncomeOther = [NSString stringWithFormat:@"%@",[CXTextFildSet getMoneyUnit:_buyBackModel.money-_buyBackModel.receipts]];
    NSString *allowIncomeStr = [NSString stringWithFormat:@"可购：%@",allowIncomeOther];
    NSRange allowIncomeRangeCash = [allowIncomeStr rangeOfString:allowIncomeOther];
    NSMutableAttributedString *allowIncomeMutableStr = [[NSMutableAttributedString alloc] initWithString:allowIncomeStr];
    [allowIncomeMutableStr addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:allowIncomeRangeCash];
    self.allowIncomeLable.attributedText = allowIncomeMutableStr;

    //资金投向
    NSString *productMoneyType=@"";
    for (int i=0; i<kAppDelegate.productMoneyIntoList.count; i++) {
        CXListInvestCategoryModel *listInvestCategory=[kAppDelegate.productMoneyIntoList objectAtIndex:i];
        
        if (_buyBackModel.investTypeId==listInvestCategory.Id) {
            productMoneyType=[NSString stringWithFormat:@"%@类",listInvestCategory.name];
        }
    }
    //产品类型
    NSString *categoryType=@"信托";
    for (int i=0; i<kAppDelegate.productCategoryList.count; i++) {
        CXCategoryModel *category=[kAppDelegate.productCategoryList objectAtIndex:i];
        if (_buyBackModel.categoryId==category.Id) {
            categoryType=category.name;
        }
    }
    
    NSString *titleStr=[NSString stringWithFormat:@"%@求购%@%@",[CXTextFildSet getMoneyUnit:_buyBackModel.money],productMoneyType,categoryType];
    NSRange productMoneyTypeRangecash = [titleStr rangeOfString:productMoneyType];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:productMoneyTypeRangecash];
    _nameLable.attributedText = str;

    self.nameLable.attributedText=str;
    
    int deadlineInt=self.buyBackModel.deadline;
    if (deadlineInt >= 12)
    {
        if (deadlineInt % 12 == 0)
        {
            self.deadlineLable.text=[NSString stringWithFormat:@"%@ %d年", StringInvestDeadline,deadlineInt / 12];
           
        }
        else
        {
            self.deadlineLable.text=[NSString stringWithFormat:@"%@ %d月",StringInvestDeadline, deadlineInt];
        }
    }
    else
    {
        self.deadlineLable.text=[NSString stringWithFormat:@"%@ %d月",StringInvestDeadline, deadlineInt];
    }
    
    self.profitLable.text=[NSString stringWithFormat:@"%@ %.1f%%",StringProductProfitRequirement,self.buyBackModel.profit];
    

    
    //姓名隐藏
    self.userNameLable.text=[NSString stringWithFormat:@"%@",[CXTextFildSet getNameHide:self.buyBackModel.userName]];
    
    //联系方式
    self.phoneLable.text=[NSString stringWithFormat:@"%@",[CXTextFildSet getPhoneHide:self.buyBackModel.phone]];
    
    //时间
    _datelineLabel.text = [NSString stringWithFormat:@"最进更新: %@",[XDateHelper translateToDisplay: _buyBackModel.dateline]];
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
    CGFloat height = [self firstGoalBarRect].size.height+[self firstGoalBarRect].origin.y+[self leftLineRect].size.height;
    return CGRectMake(x, y, width, height);
}
- (CGRect) nameLableRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = kDefaultMargin;
    CGFloat width = kScreenWidth-2*kDefaultMargin;
    CGFloat height = kLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect)deadlineLableRect
{
    CGFloat x = kSmallMargin;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height;
    CGFloat width = kScreenWidth/2-2*kSmallMargin;
    CGFloat height = kSmallLabelHeight;
    int deadlineInt=self.buyBackModel.deadline;
    NSString *deadlineStr;
    if (deadlineInt >= 12)
    {
        if (deadlineInt % 12 == 0)
        {
            deadlineStr = [NSString stringWithFormat:@" %@%d年 ", StringInvestDeadline,deadlineInt / 12];
        }
        else
        {
            deadlineStr = [NSString stringWithFormat:@" %@%d月 ",StringInvestDeadline, deadlineInt];
        }
    }
    else
    {
        deadlineStr = [NSString stringWithFormat:@" %@%d月 ",StringInvestDeadline, deadlineInt];
    }
    
    CGSize detailSize = [deadlineStr sizeWithFont:[UIFont systemFontOfSize:kSmallTextFontSize] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    width=detailSize.width;
    x=kScreenWidth/2-detailSize.width-kDefaultMargin;
    return CGRectMake(x, y, width, height);
}


- (CGRect) profitLableRect
{
    CGFloat x = kScreenWidth/2+kSmallMargin;
    CGFloat y = [self nameLableRect].origin.y+[self nameLableRect].size.height;
    CGFloat width = kScreenWidth/2-2*kSmallMargin;
    CGFloat height = kSmallLabelHeight;
     NSString *profitStr=[NSString stringWithFormat:@" %@%.1f%% ",StringProductProfitRequirement,self.buyBackModel.profit];
    CGSize detailSize = [profitStr sizeWithFont:[UIFont systemFontOfSize:kSmallTextFontSize] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
   
    width=detailSize.width;
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) userLableRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self deadlineLableRect].origin.y+[self deadlineLableRect].size.height+kDefaultMargin+ITEMVIEW_HEIGHT/2-kSmallLabelHeight;
    CGFloat width = (kScreenWidth-ITEMVIEW_HEIGHT)/2-kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) userNameLableRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self deadlineLableRect].origin.y+[self deadlineLableRect].size.height+kDefaultMargin+ITEMVIEW_HEIGHT/2;
    CGFloat width = (kScreenWidth-ITEMVIEW_HEIGHT)/2-kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}


- (CGRect) phoneLableRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self userNameLableRect].origin.y+[self userNameLableRect].size.height;
    CGFloat width = (kScreenWidth-ITEMVIEW_HEIGHT)/2-kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
    
}
- (CGRect) firstGoalBarRect
{
    
    CGFloat x = (kScreenWidth-ITEMVIEW_HEIGHT)/2;
    CGFloat y = [self deadlineLableRect].origin.y+[self deadlineLableRect].size.height+kDefaultMargin;
    CGFloat width = ITEMVIEW_HEIGHT;
    CGFloat height = ITEMVIEW_HEIGHT;
    return CGRectMake(x, y, width, height);
}
//- (CGRect) transactionLableRect
//{
//    CGFloat x = kScreenWidth/2+kDefaultMargin;
//    CGFloat y = [self deadlineLableRect].origin.y+[self deadlineLableRect].size.height+kDefaultMargin+ITEMVIEW_HEIGHT/2-kSmallLabelHeight;
//    CGFloat width = kScreenWidth/2-kDefaultMargin*2;
//    CGFloat height = kSmallLabelHeight;
//    return CGRectMake(x, y, width, height);
//}

- (CGRect) incomeLableRect
{
    CGFloat x = kScreenWidth/2+kDefaultMargin;
    CGFloat y = [self deadlineLableRect].origin.y+[self deadlineLableRect].size.height+kDefaultMargin+ITEMVIEW_HEIGHT/2;
    CGFloat width = kScreenWidth/2-kDefaultMargin*2;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) allowIncomeLableRect
{
    CGFloat x = kScreenWidth/2+kDefaultMargin;
    CGFloat y = [self incomeLableRect].origin.y+[self incomeLableRect].size.height;
    CGFloat width = kScreenWidth/2-kDefaultMargin*2;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) leftLineRect
{
    CGFloat x = kDefaultMargin;
    CGFloat y = [self phoneLableRect].origin.y+[self phoneLableRect].size.height;
    CGFloat width = kScreenWidth/2-kDefaultMargin;
    CGFloat height = (kScreenWidth/2-kDefaultMargin)/4.09;
    return CGRectMake(x, y, width, height);
}
- (CGRect) rightLineRect
{
    CGFloat x = kScreenWidth/2;
    CGFloat y = [self phoneLableRect].origin.y+[self phoneLableRect].size.height;
    CGFloat width = kScreenWidth/2-kDefaultMargin;
    CGFloat height = (kScreenWidth/2-kDefaultMargin)/4.09;
    return CGRectMake(x, y, width, height);
}

- (CGRect)datelineRect
{
        CGFloat x = kScreenWidth/2;
        CGFloat y = [self rightLineRect].origin.y +[self rightLineRect].size.height+kMinSmallMargin;
        CGFloat width = kScreenWidth/2-kDefaultMargin;
        CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}




@end
