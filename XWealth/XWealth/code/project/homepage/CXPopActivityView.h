//
//  CXPopActivityView.h
//  XWealth
//
//  Created by chx on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXPopActivityView : UIView

{
    UIControl *_overlayView;
    UIControl *_UpOverlayView;
}

@property (nonatomic, strong) CXPopActivityModel *activityModel;

- (void)show;
- (void)dismiss;

- (id)initWithActivityModel:(CXPopActivityModel*)activityModel;

@property (nonatomic, copy) ActionClickBlk actionBlk;


@end
