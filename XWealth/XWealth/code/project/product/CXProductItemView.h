//
//  CXProductItemView.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXProductItemView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *value;

- (void) setViewFrame:(CGRect)frame;

-(void)setTitleLabelFrame:(CGRect)rect andSetTitlefont:(UIFont *)textFont;
-(void)setValueLabelFrame:(CGRect)rect andSetTitlefont:(UIFont *)textFont;
@end
