//
//  CXTrackCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/8/25.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTrackCellFrame : NSObject
@property (nonatomic, strong) CXTrackModel *trackModel;
@property (nonatomic, assign) CGFloat cellHeight;
- (id)initWithDataModel:(CXTrackModel *)dataModel;


@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect payerLabelRect;
@property (nonatomic, assign) CGRect statelabelRect;
@property (nonatomic, assign) CGRect datelineLabelRect;

@property (nonatomic, assign) CGRect lineRect;
@property (nonatomic, assign) CGRect remarkLabelRect;

@end
