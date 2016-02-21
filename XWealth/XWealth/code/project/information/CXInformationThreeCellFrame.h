//
//  CXInformationThreeCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/10/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXInformationModel.h"
@interface CXInformationThreeCellFrame : NSObject
- (id)initWithDataModel:(CXInformationModel *)dataModel;

@property (nonatomic, strong) CXInformationModel *informationModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewOne;
@property (nonatomic, assign) CGRect imageViewTwo;
@property (nonatomic, assign) CGRect imageViewThree;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect commentsRect;
@property (nonatomic, assign) CGRect goodsRect;
@property (nonatomic, assign) CGRect lineRect;
@end
