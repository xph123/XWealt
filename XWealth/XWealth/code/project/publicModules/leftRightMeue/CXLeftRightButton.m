//
//  CXLeftRightButton.m
//  XWealth
//
//  Created by gsycf on 15/10/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXLeftRightButton.h"

@implementation CXLeftRightButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin.y -= 2.0;
        self.title = [[UILabel alloc] initWithFrame:frame];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font=kMenuTextFont;
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = kTextColor;
        [self addSubview:self.title];
        self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minArrow_down.png"]];
        self.arrow.frame=CGRectMake(0, 0, 9, 6);
        [self addSubview:self.arrow];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.title sizeToFit];
    self.title.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height-2.0)/2);
    self.arrow.center = CGPointMake(CGRectGetMaxX(self.title.frame) + 13.0, self.frame.size.height / 2);
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
