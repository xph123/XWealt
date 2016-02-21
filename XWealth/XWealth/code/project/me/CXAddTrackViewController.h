//
//  CXAddTrackViewController.h
//  XWealth
//
//  Created by 12345 on 15-8-23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectTableViewController.h"
#import "UUDatePicker.h"

@interface CXAddTrackViewController : XViewController<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property(nonatomic,strong)UITextField *nameField;          //名称

@property (nonatomic, strong) UITextField *payDateField;      //认购时间
@property (nonatomic, strong) UITextField *amountField;   //购买金额
@property(nonatomic,strong)UITextField *lockAreaField;        //封闭期限
@property(nonatomic,strong)UITextField *profitField;        //收益
@property(nonatomic,strong)UITextField *payerField;        //购买人（选填）
@property (nonatomic, strong) UIButton *categoryBtn;       //类型
@property (nonatomic, strong) UITextView  *descTxtView;     //产品简介
@property(nonatomic,strong) UIButton *payTypeBtn;         //付息方式

@property (nonatomic, strong) NSMutableArray *payTypeList;
@property (nonatomic, strong) NSMutableArray *categoryList;

@property(nonatomic,assign)float contentHeigth;//总偏移量
@property(nonatomic,assign)float alreadyContentHeigth;//已经偏移量

@property (nonatomic, assign) int curCategory;
@property(nonatomic,  assign) int payTypeCategory;

@end
