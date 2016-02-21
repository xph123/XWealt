//
//  CXModifyTextViewController.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXModifyTextViewController : XViewController<UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSString *type;

- (id) initWithType:(NSString*)type andDefaultText:(NSString*)text;

@end
