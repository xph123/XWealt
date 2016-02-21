//
//  CXHomePageThreeCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomePageThreeCellFrame : NSObject
- (id)initWithDataModel:(CXProductModel *)dataModel;

@property (nonatomic, strong) CXProductModel *productModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect imageViewRect;
@end
