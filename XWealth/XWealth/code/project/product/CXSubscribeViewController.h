//
//  CXSubscribeViewController.h
//  XWealth
//
//  Created by chx on 15-3-19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSubscribeViewController : XViewController<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *idcardField;
@property (nonatomic, strong) UITextField *moneyField;
@property (nonatomic, strong) UITextView  *moreTxtView;

@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, assign) long  productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSArray *timeStateList;
@property (nonatomic, assign) int curTimeState;

@property (nonatomic, copy) ActionClickBlk fromMySubscribe;

@end
