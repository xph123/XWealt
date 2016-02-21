//
//  CXCommentView.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXCommentView : UIView

@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *goodsButton;

- (void) setComments:(NSInteger) comments;
- (void) setCollect:(NSInteger) collect;
- (void) setGoods:(NSInteger) goods;

@property (nonatomic, copy) ActionClickBlk viewNumberBlk;
@property (nonatomic, copy) ActionClickBlk favorBlk;
@property (nonatomic, copy) ActionClickBlk collectBlk;
@end
