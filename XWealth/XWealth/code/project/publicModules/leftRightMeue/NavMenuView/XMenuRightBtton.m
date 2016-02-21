//
//  XMenuRightBtton.m
//  XWealth
//
//  Created by gsycf on 15/8/17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "XMenuRightBtton.h"

@implementation XMenuRightBtton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin.y -= 2.0;
        self.title = [[UILabel alloc] initWithFrame:frame];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = kTextColor;
        [self addSubview:self.title];
        
    }
    return self;
}

#pragma mark Handle taps
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
   
    self.isActive = !self.isActive;
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
