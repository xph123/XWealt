//
//  KDGoalSimpleBar.h
//  XWealth
//
//  Created by chx on 15/7/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KDGoalBarPercentLayer.h"

@protocol KDGoalSimpleBarDelegate <NSObject>

-(void)newValue:(NSNumber*)number fromControl:(id)control;
-(void)valueCommitted:(NSNumber*)number fromControl:(id)control;

@end


@interface KDGoalSimpleBar : UIControl
{
    UIImage * bg;
    
    
    UIImage * bgPressed;
    UIImage * thumb;
    UIImage * ridge;
    
    KDGoalBarPercentLayer *percentLayer;
    CALayer *imageLayer;
    CALayer *thumbLayer;
    CALayer *ridgeLayer;
    
    int finalPercent;
    BOOL dragging;
    BOOL thumbTouch;
    BOOL currentAnimating;
    
    CGFloat lastAngle;
    float maxTotal;
    CGFloat totalAngle;
    
    float lastValue;
    
    CGRect tappableRect;
    BOOL switchModes;
    
}

@property (nonatomic) BOOL allowDragging;
@property (nonatomic) BOOL allowTap;
@property (nonatomic) BOOL allowSwitching;
@property (nonatomic) BOOL allowDecimal;
@property (nonatomic) int currentGoal;
@property (nonatomic, assign) id<KDGoalSimpleBarDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *percentLabel;     //外圈颜色
@property (nonatomic, strong) UILabel *failLabel;
@property (nonatomic, strong) NSString *customText;
@property (nonatomic, strong) UIImageView *RoundIma;
- (void)setPercent:(float)percent andTitle:(NSString*)title andFail:(NSString*)fail animated:(BOOL)animated;
- (void)setPercentLabFont:(NSInteger)titleFont;//设置字体大小；
- (void)setBarColor:(UIColor *)color;   //圆圈背景颜色
- (void)setThumbEnabled:(BOOL)enabled;
- (BOOL)thumbEnabled;
- (void)moveThumbToPosition:(CGFloat)angle;
- (float)bailOutAnimation;
- (BOOL)thumbHitTest:(CGPoint)point;
- (void)displayChartMode;
-(void)setBackImage:(NSString *)image;
@end
