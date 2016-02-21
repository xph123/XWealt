//
//  CXClassroomCommentView.h
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXClassroomCommentView : UIView
@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *goodsButton;

- (void) setComments:(NSInteger) comments;
- (void) setGoods:(NSInteger) goods;

@property (nonatomic, copy) ActionClickBlk viewNumberBlk;
@property (nonatomic, copy) ActionClickBlk favorBlk;
@property (nonatomic, copy) ActionClickBlk favorUsersBlk;
@end
