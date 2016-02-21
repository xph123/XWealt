//
//  CXDropProjectBtn.h
//  XWealth
//
//  Created by gsycf on 15/9/11.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProjectSelectView.h"
#import "XMenuRightBtton.h"
#import "CXDropDownPullFunctionsView.h"

@protocol CXDropProjectBtnDelegate <NSObject>

-(void)didNavMenSelectTableAtIndex:(NSInteger)index;
@end

@interface CXDropProjectBtn : UIView<CXDropDownPullFunctionsViewDelegate>

@property(nonatomic,strong)CXDropDownPullFunctionsView *selectTableView;
@property (nonatomic, strong) XMenuRightBtton *menuRightButton;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *icons;

@property (nonatomic, weak) id <CXDropProjectBtnDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
