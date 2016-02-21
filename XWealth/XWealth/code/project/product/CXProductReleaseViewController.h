//
//  CXProductReleaseViewController.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectTableViewController.h"

@interface CXProductReleaseViewController : XViewController<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@property(nonatomic,strong)UITextField *nameField;          //名称
@property(nonatomic,strong)UITextField *profitField;        //最低收益

@property (nonatomic, strong) UITextView  *descTxtView;     //产品简介
@property (nonatomic, strong) UITextField *scaleField;      //规模
@property (nonatomic, strong) UITextField *deadlineField;   //期限

@property(nonatomic,strong) UIButton *moneyIntoBtn;         //投向
@property (nonatomic, strong) UIButton *categoryBtn;       //类型
@property (nonatomic, strong) UIButton *phoneBtn;          //电话按钮

@property(nonatomic,strong)NSMutableArray *moneyIntoList;   
@property (nonatomic, strong) NSMutableArray *categoryList;
@property (nonatomic, assign) int curCategory;
@property(nonatomic,  assign) int moneyIntoCurCategory;

@property(nonatomic,assign)float contentHeigth;//总偏移量
@property(nonatomic,assign)float alreadyContentHeigth;//已经偏移量
@end
