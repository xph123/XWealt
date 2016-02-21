//
//  CXSearchMyTrackView.m
//  XWealth
//
//  Created by gsycf on 15/12/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSearchMyTrackView.h"
#define TIMESTATE_BUTTON_WIDTH    90
@implementation CXSearchMyTrackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.clipsToBounds=YES;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    //    self.curCategory = 0;
    //    [self initCategoryList];
    _subscribeList=[[NSMutableArray alloc]init];
    _deadlineList=[[NSMutableArray alloc]init];
    _profitList=[[NSMutableArray alloc]init];
    [self initAllData];
    
    CGFloat width = self.frame.size.width - 2 * kDefaultMargin;
    
    CGRect frame = self.frame;
    frame.origin.x += 0;
    frame.origin.y = 0;
    frame.size.height -= kDefaultMargin;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = kColorWhite;
    [self addSubview:bgView];
    
    CGFloat moneyY = kDefaultMargin;
    CGFloat titleWidth = 80;
    CGFloat unitWidth  = 30;
    CGFloat inputWidth = width - titleWidth - 4 * kDefaultMargin - unitWidth;
    
    UILabel *moneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, moneyY, titleWidth, kTextFieldHeight)];
    moneyTitle.font = kMiddleTextFont;
    moneyTitle.textColor = kTextColor;
    moneyTitle.text = StringProductSubscribe;
    moneyTitle.backgroundColor = kColorClear;
    moneyTitle.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:moneyTitle];
    
    
    
    UIButton *mySubscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mySubscribeBtn.frame = CGRectMake(titleWidth + 2 * kDefaultMargin, moneyY,  inputWidth, kTextFieldHeight);
    mySubscribeBtn.layer.borderColor = kLineColor.CGColor;
    mySubscribeBtn.layer.borderWidth = 1;
    mySubscribeBtn.layer.cornerRadius = kRadius;
    mySubscribeBtn.titleLabel.font = kMiddleTextFont;
    //[mySubscribeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [mySubscribeBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [mySubscribeBtn setTitle:StringProductUnlimited forState:UIControlStateNormal];
    [mySubscribeBtn addTarget:self action:@selector(mySubscribeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:mySubscribeBtn];
    self.subscribeBtn = mySubscribeBtn;
    
    
    
    CGFloat lineY2 = moneyY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY2, width, 0.5)];
    lineView2.backgroundColor = kLineColor;
    [bgView addSubview:lineView2];
    
    
    CGFloat numberY = lineY2 + 1 + kDefaultMargin;
    
    UILabel *numberTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, numberY, titleWidth, kTextFieldHeight)];
    numberTitle.font = kMiddleTextFont;
    numberTitle.textColor = kTextColor;
    numberTitle.text =  StringProductDeadline;
    numberTitle.backgroundColor = kColorClear;
    numberTitle.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:numberTitle];
    
    UIButton *numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    numberBtn.frame = CGRectMake(titleWidth + 2 * kDefaultMargin, numberY,  inputWidth, kTextFieldHeight);
    numberBtn.layer.borderColor = kLineColor.CGColor;
    numberBtn.layer.borderWidth = 1;
    numberBtn.layer.cornerRadius = kRadius;
    numberBtn.titleLabel.font = kMiddleTextFont;
    [numberBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [numberBtn setTitle:StringProductUnlimited forState:UIControlStateNormal];
    [numberBtn addTarget:self action:@selector(numberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:numberBtn];
    self.deadlineBtn = numberBtn;
    
    
    
    CGFloat lineY3 = numberY + kDefaultMargin + kTextFieldHeight;
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, lineY3, width, 0.5)];
    lineView3.backgroundColor = kLineColor;
    [bgView addSubview:lineView3];
    
    
    CGFloat profitY = lineY3 + 1 + kDefaultMargin;
    
    UILabel *profitTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, profitY, titleWidth, kTextFieldHeight)];
    profitTitle.font = kMiddleTextFont;
    profitTitle.textColor = kTextColor;
    profitTitle.text =  StringProductProfit;
    profitTitle.backgroundColor = kColorClear;
    profitTitle.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:profitTitle];
    
    UIButton *myProfitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myProfitBtn.frame =CGRectMake(titleWidth + 2 * kDefaultMargin, profitY,  inputWidth, kTextFieldHeight);
    myProfitBtn.layer.borderColor = kLineColor.CGColor;
    myProfitBtn.layer.borderWidth = 1;
    myProfitBtn.layer.cornerRadius = kRadius;
    myProfitBtn.titleLabel.font = kMiddleTextFont;
    [myProfitBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [myProfitBtn setTitle:StringProductUnlimited forState:UIControlStateNormal];
    [myProfitBtn addTarget:self action:@selector(myProfitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:myProfitBtn];
    self.profitBtn = myProfitBtn;
    
    
    
}
-(void)notificationClick:(NSNotificationCenter *)no
{
    
}
#pragma mark data & network data
- (void) initAllData
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"category" andIntValue:0];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTCONDCATEGORY result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get moneyInto list success");
            _subscribeArr=(NSMutableArray *)mainPlate.anyModels[0][0];
            _deadlineArr=(NSMutableArray *)mainPlate.anyModels[0][1];
            _profitArr=(NSMutableArray *)mainPlate.anyModels[0][2];
            
            if (_subscribeArr&& _subscribeArr.count > 0)
            {
                
                for (int i = 0; i < _subscribeArr.count; i++)
                {
                    CXCategoryModel *ListInvestCategory = [_subscribeArr objectAtIndex:i];
                    
                    [_subscribeList addObject:ListInvestCategory];
                }
            }
            if (_deadlineArr&& _deadlineArr.count > 0)
            {
                
                for (int i = 0; i < _deadlineArr.count; i++)
                {
                    CXCategoryModel *ListInvestCategory = [_deadlineArr objectAtIndex:i];
                    
                    [_deadlineList addObject:ListInvestCategory];
                }
            }
            if (_profitArr&& _profitArr.count > 0)
            {
                
                for (int i = 0; i < _profitArr.count; i++)
                {
                    CXCategoryModel *ListInvestCategory = [_profitArr objectAtIndex:i];
                    
                    [_profitList addObject:ListInvestCategory];
                }
            }
            
            
            
        }
        else
        {
            XLog(@"get moneyInto list fail");
        }
    }];
}


#pragma mark - buttonClick
-(void)mySubscribeBtnClick
{
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_subscribeList.count];
    
    for (CXCategoryModel *ListInvestCategory in _subscribeList)
    {
        [arr addObject:ListInvestCategory.name];
    }
    [self.delegate setSubscribeList:arr andIndex:self.subscribeCategory];
    
}
-(void)numberBtnClick
{
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_deadlineList.count];
    
    for (CXCategoryModel *ListInvestCategory in _deadlineList)
    {
        [arr addObject:ListInvestCategory.name];
    }
    [self.delegate setDeadlineList:arr andIndex:self.deadlineCategory];
    
}
-(void)myProfitBtnClick
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:_profitList.count];
    
    for (CXCategoryModel *ListInvestCategory in _profitList)
    {
        [arr addObject:ListInvestCategory.name];
    }
    [self.delegate setProfitList:arr andIndex:self.profitCategory];
    
}

@end
