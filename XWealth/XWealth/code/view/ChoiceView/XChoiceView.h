//
//  XChoiceView.h
//  xProject
//
//  Created by yi.chen on 14-4-27.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XChoiceView;

@protocol XChoiceViewDelegate <NSObject>

- (void)moduleChoiceView:(UIButton *)sender;

@end

@interface XChoiceView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
@private
    UIImageView *ivSlider_;
    UIScrollView *scrollView_;
    UIView *topView_;
    NSArray *module_;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *ivSlider;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *module;
@property (nonatomic, weak) id<XChoiceViewDelegate> delegate;

@property (nonatomic, assign) NSUInteger modsCount;

/*
 *  param:
 */
- (id)initWithFrame:(CGRect)frame mouldes:(NSArray *)keys views:(NSDictionary *)vs;

- (void)showPromptCountToOne:(int)count;

- (void)showPromptCountToTwo:(int)count;

@end



