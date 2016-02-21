//
//  CSGridViewController.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@protocol CSGridViewDelegate <NSObject>
- (void)didBackgroundTap;
- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex;
@end

@interface XGridView : UIView<UIGridViewDelegate>

@property (nonatomic, strong) NSArray *projectList;

@property (nonatomic, weak) id <CSGridViewDelegate> menuDelegate;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)show;
- (void)hide;
- (void) reloadData;

@end
