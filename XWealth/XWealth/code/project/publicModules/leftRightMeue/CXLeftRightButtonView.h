//
//  CXLeftRightButtonView.h
//  XWealth
//
//  Created by gsycf on 15/10/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProjectSelectView.h"
#import "CXLeftRightButton.h"
#import "CXPullFunctionsView.h"
@protocol CXLeftRightButtonViewDelegate <NSObject>


-(void)didNavMenSelectTableAtIndex:(NSInteger)index andBool:(BOOL)isActive;
@end
@interface CXLeftRightButtonView : UIView<CXLeftRightButtonViewDelegate>
@property(nonatomic,strong)CXPullFunctionsView *selectTableView;
@property (nonatomic, strong) CXLeftRightButton *classroomButton;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id <CXLeftRightButtonViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
-(void)setButtonTitle:(NSString *)title;

@end
