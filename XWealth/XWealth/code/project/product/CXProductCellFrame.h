//
//  CXProductCellFrame.h
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXProductCellFrame : NSObject

- (id)initWithDataModel:(CXProductSimplyModel *)dataModel;
@property (nonatomic, strong) CXProductSimplyModel *sProductModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect stateImageViewRect;
@property (nonatomic, assign) CGRect titlelabelRect;
//@property (nonatomic, assign) CGRect bankLabelRect;

@property (nonatomic, assign) CGRect categoryViewRect;
@property (nonatomic, assign) CGRect deadlineViewRect;
@property (nonatomic, assign) CGRect profitViewRect;

//@property (nonatomic, assign) CGRect moneyToLabelRect;

@property (nonatomic, assign) CGRect verticalLine1Rect;
@property (nonatomic, assign) CGRect verticalLine2Rect;

//@property (nonatomic, assign) CGRect horizoncalLine1Rect;
@property (nonatomic, assign) CGRect horizoncalLine2Rect;

@property (nonatomic, assign) CGRect commentLabelRect;

@property (nonatomic, assign) CGRect ProgressImageRect;

//@property (nonatomic, assign) CGRect lineViewRect;


@end
