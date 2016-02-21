//
//  CXMyNewsCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/22.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMyNewsCellFrame : NSObject
- (id)initWithDataModel:(CXNotificationModel *)dataModel;

@property (nonatomic, strong) CXNotificationModel *notificationModel;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;

@property (nonatomic, assign) CGRect imageViewRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect contentRect;

@property (nonatomic, assign) CGRect rightBtnRect;

@property (nonatomic, assign) CGRect lineRect;
@end
