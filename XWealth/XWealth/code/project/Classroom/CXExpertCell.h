//
//  CXExpertCell.h
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXExpertCellFrame.h"
@interface CXExpertCell : UITableViewCell
@property (nonatomic, strong) CXExpertModel *expertModel;
@property (nonatomic, strong) CXExpertCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *namelable;
@property (nonatomic, strong) UILabel *titlelabel;
@property (strong, nonatomic) UIView *lineView;
@end
