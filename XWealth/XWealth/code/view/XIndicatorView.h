//
//  XIndicatorView.h
//  Link
//
//  Created by apple on 14-6-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIndicatorView : UIView
{
    NSTimer *_animateTimer;
    NSMutableArray *_sviews;
    NSInteger _currentTag;
}

-(void)startAnimating;
-(void)stopAnimating;

@end
