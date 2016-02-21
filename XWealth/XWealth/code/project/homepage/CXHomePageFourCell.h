//
//  CXHomePageFourCell.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductItemView.h"
#import "CXHomePagefourCellFrame.h"
@interface CXHomePageFourCell : UICollectionViewCell
@property (nonatomic, strong) CXBenefitModel *BenefitModel;
@property (nonatomic, strong) CXHomePagefourCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UIImageView *backIma;

@property (nonatomic, strong) UIImageView *stateImageView;

@property (nonatomic, strong) UIView *upLine;
@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *identificationImage;

@property (nonatomic, strong) UILabel *preProfitLable;
@property (nonatomic, strong) UILabel *preProfitValueLable;
@property (nonatomic, strong) CXProductItemView *deadlineView;
@property (nonatomic, strong) CXProductItemView *moneyView;
@property (nonatomic, strong) CXProductItemView *profitView;





@property (nonatomic, strong) UIImageView *typeView;
@property (nonatomic, strong) UILabel *commentLabel;
@end
