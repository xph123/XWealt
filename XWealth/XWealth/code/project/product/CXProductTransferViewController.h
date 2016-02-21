//
//  CXProductTransferViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUDatePicker.h"
#import "CXSelectTableViewController.h"
#import "CXBuybackTrustCenterRecommendViewController.h"
@interface CXProductTransferViewController : XViewController<UINavigationControllerDelegate,UITextViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate,CXSelectTableViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIScrollView* scrollView;

@property(nonatomic,strong)UITextField *nameField;          //名称
@property (nonatomic, strong) UITextField *deadlineField;   //产品期限----
@property (nonatomic, strong) UITextField *moneyField;      //认购金额---
@property(nonatomic,strong) UITextField *establishDateField;     //成立日期---
@property(nonatomic,strong)UITextField *profitField;        //预期收益

@property(nonatomic,strong) UIButton *payTypeBtn;         //付息方式
@property(nonatomic,strong) UITextField *preTransDateField;     //预期转让日期---
@property(nonatomic,strong) UIButton  *acceptDisCountBtn;                     //收益权是否接受折扣


@property(nonatomic,strong) UITextField *userNameField;     //客户姓名
@property(nonatomic,strong)UITextField *phoneField;        //电话号码
@property(nonatomic,strong) UIButton *moneyIntoBtn;         //投向
@property(nonatomic,strong) UIButton *categoryBtn;         //产品类型
@property (nonatomic, strong) UITextView  *introTxtView;     //其他说明
@property (nonatomic, strong) UIButton *phoneBtn;          //电话按钮

@property (nonatomic, assign) long productId;

@property(nonatomic,strong)NSMutableArray *moneyIntoList;
@property (nonatomic, strong) NSMutableArray *categoryList;
@property (nonatomic, strong) NSMutableArray *payTypeList;

@property (nonatomic, assign) int curCategory;
@property(nonatomic,  assign) int moneyIntoCurCategory;
@property(nonatomic,  assign) int payTypeCategory;

@property(nonatomic,assign)float contentHeigth;//总偏移量
@property(nonatomic,assign)float alreadyContentHeigth;//已经偏移量

@property(nonatomic,strong)NSMutableArray *sourceDatas;

@end
