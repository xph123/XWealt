//
//  CXHomePageThreeCell.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXHomePageThreeCellFrame.h"
@interface CXHomePageThreeCell : UICollectionViewCell
@property (nonatomic, strong) CXProductModel *productModel;
@property (nonatomic, strong) CXHomePageThreeCellFrame *layout;

@property (strong, nonatomic) UIView *cellView;
@property (nonatomic ,strong)UIImageView *imgView;
@end
