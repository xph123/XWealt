//
//  CXModifyTextFieldViewController.h
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXModifyTextFieldViewController : XViewController<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSString *type;

@property (strong, nonatomic) CXUserModel *userModel;

- (id) initWithType:(NSString*)type andDefaultText:(NSString*)text;

@end
