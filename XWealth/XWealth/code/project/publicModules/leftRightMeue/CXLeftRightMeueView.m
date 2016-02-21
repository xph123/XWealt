//
//  CXLeftRightMeueView.m
//  XWealth
//
//  Created by gsycf on 15/9/8.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXLeftRightMeueView.h"

@implementation CXLeftRightMeueView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        _leftBtnData=[[NSMutableArray alloc]init];
        _rightBtnData=[[NSMutableArray alloc]init];
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    CGFloat MeueViewX = self.frame.origin.x;
    CGFloat MeueViewY = 0;
    CGFloat MeueViewWidth = self.frame.size.width;
    CGFloat MeueViewHeight = self.frame.size.height;
    
    UIView *buttonBackView=[[UIView alloc]initWithFrame:CGRectMake(MeueViewX,MeueViewY, MeueViewWidth, MeueViewHeight)];
    buttonBackView.backgroundColor=[UIColor whiteColor];
    [self addSubview:buttonBackView];
    
    CGRect CentreBackViewFram=CGRectMake(self.frame.size.width/2, kButtonHeight/4, 1, kButtonHeight/2);
    UIView *CentreBackView=[[UIView alloc]initWithFrame:CentreBackViewFram];
    CentreBackView.backgroundColor=kGrayColor;
    [buttonBackView addSubview:CentreBackView];
    
    //左边的按钮
    CGRect leftFrame=CGRectMake(0, 0, self.frame.size.width/2-1, kButtonHeight);
    _leftBtn=[[CXLeftRightButtonView alloc] initWithFrame:leftFrame title:StringCategoryAll];
    _leftBtn.delegate=self;
    _leftBtn.items=_leftBtnData;
    _leftBtn.classroomButton.title.text=StringCategoryAll;
    
    [buttonBackView addSubview:_leftBtn];
    
    //右边的按钮
    CGRect RightFrame=CGRectMake(self.frame.size.width/2+1, 0, self.frame.size.width/2-1, kButtonHeight);
    _rightBtn=[[CXLeftRightButtonView alloc] initWithFrame:RightFrame title:StringClassify];
    _rightBtn.delegate=self;
    _rightBtn.items=_rightBtnData;
    _rightBtn.classroomButton.title.text=StringClassify;
    [buttonBackView addSubview:_rightBtn];
}
-(void)getLeftData:(NSMutableArray *)arr
{
    _leftBtnData=arr;
    _leftBtn.items=_leftBtnData;
}
-(void)getRightData:(NSMutableArray *)arr
{
    _rightBtnData=arr;
    _rightBtn.items=_rightBtnData;
}
#pragma mark - CXProjectBtnDelegate
-(void)didNavMenSelectTableAtIndex:(NSInteger)index andBool:(BOOL)isActive
{
    
    if (_leftBtn.classroomButton.isActive) {
        
        [self.delegate didSelectLeftAtIndex:index];
        _leftBtn.classroomButton.title.text=_leftBtnData[index];
        
        
    }
    else if (_rightBtn.classroomButton.isActive)
    {
        [self.delegate didSelectRightAtIndex:index];
        _rightBtn.classroomButton.title.text=_rightBtnData[index];
    }
    
}


@end
