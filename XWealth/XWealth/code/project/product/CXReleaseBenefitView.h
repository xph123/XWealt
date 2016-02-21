//
//  CXReleaseBenefitView.h
//  XWealth
//
//  Created by gsycf on 15/8/21.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUDatePicker.h"

@protocol CXReleaseBenefitViewDelegate <NSObject>
-(void)setCategory:(NSArray *)categoryData andIndex:(int)index;

@end
@interface CXReleaseBenefitView : UIView<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) id <CXReleaseBenefitViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView* scrollView;

@property(nonatomic,strong)UITextField *nameField;          //名称
@property (nonatomic, strong) UITextField *deadlineField;   //产品期限----
@property (nonatomic, strong) UITextField *moneyField;      //认购金额---
@property(nonatomic,strong) UITextField *establishDateField;     //成立日期---
@property(nonatomic,strong)UITextField *profitField;        //预期收益

@property(nonatomic,strong) UITextField *userNameField;     //客户姓名
@property(nonatomic,strong)UITextField *phoneField;        //电话号码

@property (nonatomic, strong) UITextView  *introTxtView;     //其他说明
@property (nonatomic, strong) UIButton *phoneBtn;          //电话按钮



@property(nonatomic,assign)float contentHeigth;//总偏移量
@property(nonatomic,assign)float alreadyContentHeigth;//已经偏移量
-(void)hideKeyBoard;

@end
