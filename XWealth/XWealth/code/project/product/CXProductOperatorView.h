//
//  CXProductOperatorView.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXProductOperatorView : UIView

@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UIButton *mailButton;
@property (nonatomic, strong) UIButton *tradeButton;
@property (nonatomic, strong) UIButton *scheduleButton;

@property (nonatomic, copy) ActionClickBlk attentionBlk;
@property (nonatomic, copy) ActionClickBlk mailBlk;
@property (nonatomic, copy) ActionClickBlk tradeBlk;
@property (nonatomic, copy) ActionClickBlk scheduleBlk;
@end
