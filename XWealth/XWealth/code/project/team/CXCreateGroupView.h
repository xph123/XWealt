//
//  CXCreateGroupView.h
//  Link
//  创建群的头部
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXCreateGroupView : UIView<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UIImageView *groupLogoImageView;

@property (strong, nonatomic) ActionClickBlk clickAddPictureBlk;
@property (strong, nonatomic) ActionClickBlk longPressAddPictureBlk;

@end
