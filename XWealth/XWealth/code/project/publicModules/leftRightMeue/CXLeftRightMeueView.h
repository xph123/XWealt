//
//  CXLeftRightMeueView.h
//  XWealth
//
//  Created by gsycf on 15/9/8.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXLeftRightButtonView.h"
@protocol CXLeftRightMeueViewDelegate <NSObject>
-(void)didSelectLeftAtIndex:(NSInteger)index;
-(void)didSelectRightAtIndex:(NSInteger)index;
@end
@interface CXLeftRightMeueView : UIView<CXLeftRightButtonViewDelegate>

@property (nonatomic, weak) id <CXLeftRightMeueViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *leftBtnData;    //左边按钮数据
@property (nonatomic, strong) NSMutableArray *rightBtnData;   //右边按钮数据

@property(nonatomic,strong)CXLeftRightButtonView *leftBtn;
@property(nonatomic,strong)CXLeftRightButtonView *rightBtn;

@property(nonatomic,assign)NSInteger leftIndex;
@property(nonatomic,assign)NSInteger rightIndex;

-(void)getLeftData:(NSMutableArray *)arr;
-(void)getRightData:(NSMutableArray *)arr;

@end
