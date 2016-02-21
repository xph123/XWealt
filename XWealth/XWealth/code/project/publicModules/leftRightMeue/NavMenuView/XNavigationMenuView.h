//
//  CSNavigationMenuView.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGridView.h"
#import "XMenuTable.h"
#import "XMenuButton.h"

@protocol XNavigationMenuDelegate <NSObject>

- (void)didNavMenuSelectItemAtIndex:(NSUInteger)index;

@end

@interface XNavigationMenuView : UIView <CSGridViewDelegate>

@property (nonatomic, strong) XMenuButton *menuButton;
@property (nonatomic, weak) id <XNavigationMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) int resetting; // 0 正常，1 重设table

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)displayMenuInView:(UIView *)view;

@end
