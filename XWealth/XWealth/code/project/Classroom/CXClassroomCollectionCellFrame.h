//
//  CXClassroomCollectionCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXClassroomCollectionCellFrame : NSObject
- (id)initWithDataModel:(CXCourseModel *)dataModel;

@property (nonatomic, strong) CXCourseModel *courseModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect commentsRect;
@property (nonatomic, assign) CGRect goodsRect;
@end
