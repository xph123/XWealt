//
//  CXMyBuybackCell.h
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXMyBuybackCellFrame.h"
@interface CXMyBuybackCell : UITableViewCell
@property (nonatomic, strong) CXBuyBackModel  *buyBackModel;
@property (nonatomic, strong) CXMyBuybackCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *deadlineLabel;
@property (nonatomic, strong) UILabel *profitLabel;


@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@end
