//
//  CXProjectBtnView.h
//  XWealth
//
//  Created by chx on 15/7/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMenuButton.h"
#import "CXProjectSelectView.h"

@protocol CXProjectBtnViewDelegate <NSObject>

- (void)didNavMenuSelectItemAtIndex:(NSUInteger)index;

@end


@interface CXProjectBtnView : UIView<CXProjectSelectViewDelegate>

@property (nonatomic, strong) CXProjectSelectView *selectView;
@property (nonatomic, strong) XMenuButton *menuButton;
@property (nonatomic, strong) NSArray *items;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@property (nonatomic, weak) id <CXProjectBtnViewDelegate> delegate;

@end
