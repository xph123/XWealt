//
//  CXProductBuyBackViewController.h
//  XWealth
//
//  Created by 12345 on 15-10-16.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectTableViewController.h"
#import "CXTrustTransferCenterRecommendViewController.h"
@interface CXProductBuyBackViewController : XViewController<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate,CXSelectTableViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;


@property(nonatomic,strong)UITextField *userNameField;          //用户名字
@property(nonatomic,strong)UITextField *phoneField;          //电话号码

@property (nonatomic, strong) UITextField *deadlineField;   //投资期限（月）
@property(nonatomic,strong)UITextField *moneyField;        //投资金额（万）
@property(nonatomic,strong)UITextField *profitField;        //收益要求


@property(nonatomic,strong) UIButton *moneyIntoBtn;         //投向
@property (nonatomic, strong) UIButton *categoryBtn;       //类型分类(信托、资管等的ID)
@property (nonatomic, strong) UITextView  *descTxtView;     //其他说明
@property (nonatomic, strong) UIButton *phoneBtn;          //电话按钮

@property(nonatomic,strong)NSMutableArray *moneyIntoList;
@property (nonatomic, strong) NSMutableArray *categoryList;
@property (nonatomic, assign) int curCategory;
@property(nonatomic,  assign) int moneyIntoCurCategory;

@property(nonatomic,assign)float contentHeigth;//总偏移量
@property(nonatomic,assign)float alreadyContentHeigth;//已经偏移量
@property(nonatomic,strong)NSMutableArray *sourceDatas;
@end
