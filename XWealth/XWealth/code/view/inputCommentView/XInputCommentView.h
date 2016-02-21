//
//  FasongView.h
//  Link
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XInputCommentView : UIView<UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *placeHolder;
@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) NSString *sendType;
@property (strong, nonatomic) ActionClickBlk sendBlk;
@property (strong, nonatomic) ActionClickBlk risingView;
@property (strong, nonatomic) ActionClickBlk fallingView;

@property (assign, nonatomic) CGRect baseFrame;
// 点发送后，调用这个函数复原
- (void) recover;

@end
