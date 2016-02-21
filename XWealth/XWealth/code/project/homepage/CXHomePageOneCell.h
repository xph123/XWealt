//
//  CXHomePageOneCell.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXInformationModel.h"
#import "CXHomePageOneCellFrame.h"
@interface CXHomePageOneCell : UICollectionViewCell
@property (nonatomic, strong) CXInformationModel *informationModel;
@property (nonatomic, strong) CXHomePageOneCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *datelineLabel;
@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *goodsButton;
@property (strong, nonatomic) UIView *lineView;
@end
