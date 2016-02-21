//
//  CXTrackCell.h
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTrackCellFrame.h"
@interface CXTrackCell : UITableViewCell

@property (nonatomic, strong) CXTrackModel *trackModel;
@property (nonatomic, strong) CXTrackCellFrame *layout;

@property (strong, nonatomic) UIImageView *cellView;


@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *externLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *payerLabel;
@property (nonatomic, strong) UILabel *statelabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UILabel *remarkLabel;
@end
