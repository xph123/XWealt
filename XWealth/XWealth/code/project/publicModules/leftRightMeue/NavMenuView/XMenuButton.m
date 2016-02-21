//
//  CSMenuButton.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XMenuButton.h"

@implementation XMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin.y -= 2.0;
        self.title = [[UILabel alloc] initWithFrame:frame];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor whiteColor];
        self.title.font = [UIFont boldSystemFontOfSize:17.0];
//        self.title.shadowColor = [UIColor darkGrayColor];
//        self.title.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:self.title];
        
        self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down.png"]];
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

@end
