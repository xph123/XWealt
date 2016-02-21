//
//  CXInformationDetailHeaderFrame.h
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXInformationDetailHeaderFrame : NSObject

- (id)initWithDataModel:(CXInformationModel *)dataModel;

@property (nonatomic, strong) CXInformationModel *informationModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect sourceRect;
@property (nonatomic, assign) CGRect authorRect;
@property (nonatomic, assign) CGRect lineRect;

@end
