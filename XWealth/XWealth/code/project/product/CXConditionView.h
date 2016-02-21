//
//  CXConditionView.h
//  XWealth
//
//  Created by chx on 15-3-23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXConditionViewDelegate <NSObject>
-(void)setSubscribeList:(NSArray *)subscribeData andIndex:(int)index;
-(void)setDeadlineList:(NSArray *)deadlineData andIndex:(int)index;
-(void)setProfitList:(NSArray *)profitData andIndex:(int)index;
@end
@interface CXConditionView : UIView<UINavigationControllerDelegate>//UIView<UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)id <CXConditionViewDelegate> delegate;

@property (nonatomic, strong) UIButton *subscribeBtn;
@property (nonatomic, strong) UIButton *deadlineBtn;
@property (nonatomic, strong) UIButton *profitBtn;

@property(nonatomic,strong)   NSMutableArray *subscribeList;
@property (nonatomic, strong) NSMutableArray *deadlineList;
@property (nonatomic, strong) NSMutableArray *profitList;

@property (nonatomic, assign) int subscribeCategory;
@property(nonatomic,  assign) int deadlineCategory;
@property(nonatomic,  assign) int profitCategory;

@property (nonatomic, strong) NSMutableArray *subscribeArr;
@property (nonatomic, strong) NSMutableArray *deadlineArr;
@property (nonatomic, strong) NSMutableArray *profitArr;



//@property (nonatomic, strong) UIButton *categoryBtn;
//@property (nonatomic, strong) NSArray *categoryList;
//@property (nonatomic, strong) UITableView *timeStateTableView;
//@property (nonatomic, assign) int curCategory;


@end
