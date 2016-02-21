//
//  CXMyRecommentCell.h
//  XWealth
//
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXMyRecommentCell : UITableViewCell

@property (nonatomic, strong) CXRecommentModel *recommentModel;

@property (strong, nonatomic) UIView *cellView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIButton *recommentBtn;

@property (strong, nonatomic) ActionClickBlk recommentBtnBlk;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect phoneRect;
@property (nonatomic, assign) CGRect recommentBtnRect;
@property (nonatomic, assign) CGRect lineRect;

@end
