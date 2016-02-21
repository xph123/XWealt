//
//  CXMyNewsDetailCellFrame.h
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMyNewsDetailCellFrame : NSObject

- (id)initWithDataModel:(CXNotificationModel *)notificationModel;
@property (nonatomic, strong) CXNotificationModel *notificationModel;
@property (nonatomic, assign) CGRect iconRect;
@property (nonatomic, assign) CGRect timeRect;

@property (nonatomic, assign) CGRect nameLableRect;
@property (nonatomic, assign) CGRect rightImageRect;
@property (nonatomic, assign) CGRect lineViewRect;
@property (nonatomic, assign) CGRect contentLableRect;



@property (nonatomic, assign) CGRect firstBtnRect;
@property (nonatomic, assign) CGRect secondBtnRect;
@property (nonatomic, assign) CGRect contentBackViewRect;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect cellViewRect;



@property (nonatomic, assign) BOOL showTime;

@end
