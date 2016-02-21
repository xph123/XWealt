//
//  CXShareIndexView.m
//  XWealth
//
//  Created by gsycf on 16/1/18.
//  Copyright © 2016年 rasc. All rights reserved.
//

#import "CXShareIndexView.h"

@implementation CXShareIndexView

-(id)initSourceDatas:(NSMutableArray *)sourceData
{
    self=[super init];
    if (self) {
        self.sourceDatas=sourceData;
        self.userInteractionEnabled=YES;
        self.backgroundColor=kControlBgColor;
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    
    CGRect scrollViewFrame=self.bounds;
    scrollViewFrame.size.width =kScreenWidth;
    scrollViewFrame.size.height =kshareIndexHeight;
    _scrollView=[[UIScrollView alloc]initWithFrame:scrollViewFrame];
    _scrollView.alwaysBounceHorizontal=YES;
//    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor=kControlBgColor;
    _scrollView.bounces=NO;
    [_scrollView setDelegate:self];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [_scrollView setContentSize:CGSizeMake(_sourceDatas.count*(kshareIndexWidth+0.5)-0.5, 0)];
    [self addSubview:_scrollView];
    
    
    for (int i=0; i<_sourceDatas.count; i++) {
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(i*(kshareIndexWidth+0.5),0, kshareIndexWidth, kshareIndexHeight)];
        backView.backgroundColor=UIColorFromRGB(0xfb8b6f);
        [_scrollView addSubview:backView];
        
        //指数
        UILabel *currPriceLable=[[UILabel alloc]initWithFrame:CGRectMake(kMiddleMargin, kshareIndexHeight/2-kSmallLabelHeight/2+kSmallMargin, kshareIndexWidth-kMiddleMargin, kSmallLabelHeight)];
        currPriceLable.textColor=[UIColor whiteColor];
        currPriceLable.textAlignment=NSTextAlignmentLeft;
        //currPriceLable.backgroundColor=[UIColor blueColor];
        //[UIFont fontWithName:@"Arial Rounded MT Bold" size:kLargeTextFontSize]
        currPriceLable.font=kLargeTextFont;
        currPriceLable.numberOfLines=1;
        [backView addSubview:currPriceLable];
        
        //名称
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(kMiddleMargin, currPriceLable.frame.origin.y-kminLabelHeight-kSmallMargin, kshareIndexWidth-kMiddleMargin, kminLabelHeight)];
        titleLable.textColor=[UIColor whiteColor];
        titleLable.textAlignment=NSTextAlignmentLeft;
        titleLable.font=kSmallTextFont;
        //titleLable.backgroundColor=[UIColor redColor];
        titleLable.numberOfLines=1;
        [backView addSubview:titleLable];
        

        //增幅降幅
        UILabel *priceLable=[[UILabel alloc]initWithFrame:CGRectMake(kMiddleMargin, currPriceLable.frame.origin.y+currPriceLable.frame.size.height,  (kshareIndexWidth-kMiddleMargin)/2, kminLabelHeight)];
        priceLable.textColor=[UIColor whiteColor];
        priceLable.textAlignment=NSTextAlignmentLeft;
        priceLable.font=[UIFont systemFontOfSize:10];
        priceLable.numberOfLines=1;
        [backView addSubview:priceLable];
        
        UILabel *percentPriceLable=[[UILabel alloc]initWithFrame:CGRectMake(priceLable.frame.origin.x+priceLable.frame.size.width, currPriceLable.frame.origin.y+currPriceLable.frame.size.height, (kshareIndexWidth-kDefaultMargin)/2, kminLabelHeight)];
        percentPriceLable.textColor=[UIColor whiteColor];
        percentPriceLable.textAlignment=NSTextAlignmentLeft;
        percentPriceLable.font=[UIFont systemFontOfSize:10];;
        percentPriceLable.numberOfLines=1;
        [backView addSubview:percentPriceLable];
        
        CXShareIndexModel *shareIndexModel=self.sourceDatas[i];
        titleLable.text=shareIndexModel.sharesName;
        
        currPriceLable.text=shareIndexModel.curr_price;
        priceLable.text=shareIndexModel.price;
        double percent=[shareIndexModel.percent_price doubleValue];
        percentPriceLable.text=[NSString stringWithFormat:@"%0.2f%%",percent];
        if ([shareIndexModel.price hasPrefix:@"+"]) {
            backView.backgroundColor=UIColorFromRGB(0xfb8b6f);
            //backView.backgroundColor=[UIColor redColor]
            //            currPriceLable.textColor=[UIColor redColor];
            //            priceLable.textColor=[UIColor redColor];
            //            percentPriceLable.textColor=[UIColor redColor];
        }
        else
        {
            backView.backgroundColor=UIColorFromRGB(0x2ccc91);
            //            currPriceLable.textColor=[UIColor greenColor];
            //            priceLable.textColor=[UIColor greenColor];
            //            percentPriceLable.textColor=[UIColor greenColor];
            
        }
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

@end
