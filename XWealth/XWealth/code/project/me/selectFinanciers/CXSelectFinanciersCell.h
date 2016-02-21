//
//  CXSelectFinanciersCell.h
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSelectFinanciersCellFrame.h"

@interface CXSelectFinanciersCell : UITableViewCell
@property (nonatomic, strong) CXFinanciersModel *financiersModel;
@property (nonatomic, strong) CXSelectFinanciersCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *authenticationLabel;// 认证
@property (strong, nonatomic) UILabel *tradeLabel;         //出单

@property (nonatomic, strong) UILabel *specialtyLabel;
@property (nonatomic, strong) UILabel *recordLabel;
@property (nonatomic, strong) UILabel *serviceLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (strong, nonatomic) UIView *lineView;
@end
