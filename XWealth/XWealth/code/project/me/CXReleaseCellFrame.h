//
//  CXReleaseCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/9/24.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXReleaseCellFrame : NSObject
- (id)initWithDataModel:(CXProductReleaseModel *)releaseModel;
@property (nonatomic, strong) CXProductReleaseModel *releaseModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat titlelabelHight;

@end
