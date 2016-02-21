//
//  CXTrustTransferDetailOperatorView.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXTrustTransferDetailOperatorView : UIView
@property (nonatomic, strong)UIButton *dataButton;
@property (nonatomic ,strong)UIButton *SubscribeButton;

@property (nonatomic, copy)ActionClickBlk dataBlk;
@property (nonatomic, copy)ActionClickBlk subscribeBlk;
@end
