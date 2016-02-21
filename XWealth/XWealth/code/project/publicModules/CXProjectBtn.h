//
//  CXProjectBtn.h
//  XWealth
//
//  Created by gsycf on 15/8/13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProjectSelectView.h"
#import "XMenuRightBtton.h"
#import "CXPullFunctionsView.h"

@protocol CXProjectBtnDelegate <NSObject>


-(void)didNavMenSelectTableAtName:(NSString *)Name;
@end


@interface CXProjectBtn : UIView<CXPullFunctionsViewDelegate>

@property(nonatomic,strong)CXPullFunctionsView *selectTableView;
@property (nonatomic, strong) XMenuRightBtton *menuRightButton;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id <CXProjectBtnDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
