//
//  CXmyAccountItemView.h
//  XWealth
//
//  Created by gsycf on 15/9/22.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXmyAccountItemView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *value;

- (void) setViewFrame:(CGRect)frame;
@end
