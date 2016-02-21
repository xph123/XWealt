//
//  CXMyCollectionCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/10/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMyCollectionCellFrame : NSObject
- (id)initWithDataModel:(CXInformationModel *)dataModel;

@property (nonatomic, strong) CXInformationModel *informationModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect commentsRect;
@property (nonatomic, assign) CGRect goodsRect;
@property (nonatomic, assign) CGRect lineRect;
@end
