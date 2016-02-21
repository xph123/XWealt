//
//  CXGroupMemberView.h
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@protocol CXGroupMemberViewDelegate <NSObject>

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex;
@end

@interface CXGroupMemberView : UIView<UIGridViewDelegate>

@property (nonatomic, strong) UIGridView *table;
@property (nonatomic, strong) NSArray *userList;
@property (nonatomic, weak) id <CXGroupMemberViewDelegate> grideDelegate;

- (id)initWithItems:(NSArray *)items;
- (int) numberOfRows;
- (void) reloadData;

@end
