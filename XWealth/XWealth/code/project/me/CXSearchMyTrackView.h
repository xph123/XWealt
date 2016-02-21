//
//  CXSearchMyTrackView.h
//  XWealth
//
//  Created by gsycf on 15/12/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXSearchMyTrackViewDelegate <NSObject>
-(void)setSubscribeList:(NSArray *)subscribeData andIndex:(int)index;
-(void)setDeadlineList:(NSArray *)deadlineData andIndex:(int)index;
-(void)setProfitList:(NSArray *)profitData andIndex:(int)index;
@end
@interface CXSearchMyTrackView : UIView<UINavigationControllerDelegate>//UIView<UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)id <CXSearchMyTrackViewDelegate> delegate;

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


@end
