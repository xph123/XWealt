//
//  CXProductHeaderView.m
//  XWealth
//
//  Created by chx on 15-4-14.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductHeaderView.h"

@implementation CXProductHeaderView

- (id)initWithFrame:(CGRect)frame andProduct:(CXProductModel*)productModel
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorWhite;
        self.clipsToBounds=YES;
        self.productModel = productModel;
        self.headViewHeight = 0;
        
        [self initSubviews];
        
    }
    return self;
}

- (NSString *)dateDifferent:(NSString *)endDateStr
{
    NSString *dateContent;
    
    NSString *endStr;
    if (endDateStr && endDateStr.length > 19)
    {
        endStr = [endDateStr substringToIndex:19];
    }
    else
    {
        endStr = endDateStr;
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *  senddate=[NSDate date];
    //结束时间
    NSDate *endDate = [dateFormatter dateFromString:endStr];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
//    int minute = ((int)time)%(3600*24)%3600/60;
    
//    if (days <= 0 && hours <= 0 && minute <= 0)
//        dateContent=@"0天0小时0分钟";
//    else
//        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];
    
    if (days <= 0 && hours <= 0)
        dateContent=@"已结束";
    else if (days<=0)
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i小时",hours];
    else if (days>0&&hours==0)
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i天",days];
    else
        dateContent=[[NSString alloc] initWithFormat:@"剩余%i天%i小时",days,hours];
    
    return dateContent;
}

- (NSString*)makeMoneyString:(int) value
{
    NSString *saleStr;
    int saleInt = value;
    
    if (saleInt >= 10000)
    {
        int remain = saleInt % 10000;
        if (remain == 0)
        {
            saleStr = [NSString stringWithFormat:@"%d亿", saleInt / 10000 ];
        }
        else
        {
            saleStr = [NSString stringWithFormat:@"%d亿%d万", saleInt / 10000, saleInt % 10000 ];
        }
    }
    else
    {
        saleStr = [NSString stringWithFormat:@"%d万", saleInt];
    }

    return saleStr;
}

- (void)initSubviews
{
    CGFloat purchase = (CGFloat)_productModel.receipts * 100 / _productModel.scale;
    NSString *dateDiff = [self dateDifferent:_productModel.establishDate];
    
    CGFloat x = (kScreenWidth - 170) / 2;
    CGRect frame = CGRectMake(x, 15, 170, 170);
    _firstGoalBar = [[KDGoalBar alloc] initWithFrame:frame];
    [_firstGoalBar setAllowDragging:NO];
    [_firstGoalBar setAllowSwitching:NO];

    [_firstGoalBar setPercent:purchase andTitle:@"已进款" andFail:dateDiff animated:NO];
    
    [self addSubview:_firstGoalBar];
    
    // 公司员工，显示费用
    if (kAppDelegate.currentUserModel.grade <= 6 && kAppDelegate.currentUserModel.grade > 0)
    {
        UIButton * costBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 150, 30, 30)];
        [costBtn setBackgroundColor:[UIColor clearColor]];
        [costBtn setImage:IMAGE(@"product_info") forState: UIControlStateNormal];
        [costBtn addTarget:self action:@selector(costBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: costBtn];
    }
    
    UILabel *cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, kScreenWidth - 40, kLabelHeight)];
    cashLabel.font = kMiddleTextFont;
    cashLabel.textColor = kTextColor;
    cashLabel.numberOfLines = 1;
    cashLabel.textAlignment = NSTextAlignmentCenter;
    cashLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:cashLabel];
    
    NSString *cash = [self makeMoneyString:_productModel.receipts ];
    NSString *cashOther = [self makeMoneyString:(_productModel.scale - _productModel.receipts) ];
   
    NSString *cashStr = [NSString stringWithFormat:@"已进款：%@，还可进款：%@", cash, cashOther];
    NSRange rangecash = [cashStr rangeOfString:cash];
    NSRange rangecashOther = [cashStr rangeOfString:cashOther];
    NSMutableAttributedString *cashMutableStr = [[NSMutableAttributedString alloc] initWithString:cashStr];
    [cashMutableStr addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:rangecash];
    [cashMutableStr addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:rangecashOther];
    cashLabel.attributedText = cashMutableStr;
    
    
    CGFloat line1Y = 190 + kLabelHeight;
    
    if (![self.productModel.progressDesc isEmpty])
    {
        CGFloat textWidth = kScreenWidth - kIconSmallHeight - 3 * kDefaultMargin;
        CGSize size = [self.productModel.progressDesc getSizeWithWidth:(textWidth) fontSize:kMiddleTextFontSize];
        
        CGFloat height = size.height + 6;
        if (height < kLabelHeight)
        {
            height = kLabelHeight;
        }
        
        UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, line1Y, kScreenWidth, height)];
        infoView.backgroundColor = UIColorFromRGB(0xff6765);
        [self addSubview:infoView];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kIconSmallWidth, kIconSmallHeight)];
        [imgView setImage:IMAGE( @"volume_trans")];
        [infoView addSubview:imgView];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin * 2 + kIconSmallWidth, 0, textWidth , height)];
        descLabel.font = kMiddleTextFont;
        descLabel.textColor = kColorWhite;
        descLabel.numberOfLines = 0;
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.text = self.productModel.progressDesc;
        [infoView addSubview:descLabel];
        
        line1Y = line1Y + height;
    }
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line1Y, kScreenWidth-20 , kLabelHeight)];
    timeLabel.font = kSmallTextFont;
    timeLabel.textColor = kAssistTextColor;
    timeLabel.numberOfLines = 1;
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    
    NSString *dateline = [NSString stringWithFormat:@"%@",_productModel.dateline];
    NSString *datelineTime=[dateline substringToIndex:16];
    NSString *saledStr = [NSString stringWithFormat:@"最近更新：%@", datelineTime];
    NSMutableAttributedString *saledMutableStr = [[NSMutableAttributedString alloc] initWithString:saledStr];
    timeLabel.attributedText = saledMutableStr;
   
    self.headViewHeight = line1Y + kLabelHeight;
}

- (void) costBtnClick:(UIButton *)btn
{
    if (self.costBtnBlk) {
        self.costBtnBlk();
    }
}

@end
