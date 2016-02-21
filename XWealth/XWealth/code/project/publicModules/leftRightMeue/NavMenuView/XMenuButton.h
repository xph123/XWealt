//
//  CSMenuButton.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMenuButton : UIControl

@property (nonatomic, unsafe_unretained) BOOL isActive;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;

@end
