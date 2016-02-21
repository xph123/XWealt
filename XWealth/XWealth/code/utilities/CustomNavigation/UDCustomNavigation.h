//
//  UDCustomNavigation.h
//  XWealth
//
//  Created by gsycf on 15/11/18.
//  Copyright © 2015年 rasc. All rights reserved.
//
//自定义状态栏显示和隐藏
#import <UIKit/UIKit.h>

@interface UDCustomNavigation : UINavigationController

@property(nonatomic,strong)UIView *alphaView;
-(void)setAlpha:(BOOL)state andAnimation:(BOOL)AnimationState;
-(void)setRecoverySystemStyle:(BOOL)state;
@end
