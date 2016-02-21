//
//  CXClassroomExpertCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXClassroomExpertCellFrame : NSObject
- (id)initWithDataModel:(CXExpertModel *)expertModel;

@property (nonatomic, strong) CXExpertModel *expertModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect lineRect;
@end
