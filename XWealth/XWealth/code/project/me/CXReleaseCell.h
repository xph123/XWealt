//
//  CXReleaseCell.h
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXReleaseCellFrame.h"
@interface CXReleaseCell : UITableViewCell

@property (nonatomic, strong) CXProductReleaseModel *releaseModel;
@property (nonatomic, strong) CXReleaseCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;



@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) CXProductItemView *classifyView;
@property (nonatomic, strong) CXProductItemView *scaleView;
@property (nonatomic, strong) CXProductItemView *deadlineView;

@property (nonatomic, strong) UIView *verticalLine1;
@property (nonatomic, strong) UIView *verticalLine2;
@property (nonatomic, strong) UIView *horizoncalLine2;

@property (nonatomic, strong) UILabel *statelabel;
@property (nonatomic, strong) UILabel *datelineLabel;

@end
