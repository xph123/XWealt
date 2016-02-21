//
//  CXLeftRightButton.h
//  XWealth
//
//  Created by gsycf on 15/10/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXLeftRightButton : UIControl
@property (nonatomic, unsafe_unretained) BOOL isActive;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;
-(void)layoutSubviews;
@end
