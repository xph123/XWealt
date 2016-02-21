//
//  XIndicatorView.m
//  Link
//
//  Created by apple on 14-6-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XIndicatorView.h"

@implementation XIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sviews = [NSMutableArray array];
        for (int i=0; i<8; ++i) {//row
            NSString *ivName = [NSString stringWithFormat:@"loading%d@2x.png",i+1];
            UIImageView *sview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ivName]];
            sview.frame = CGRectMake(0, 0, 40, 40);
            sview.center = CGPointMake(160, 220);
            sview.tag = 100+i;
            sview.alpha = i==0?1:0;
            [_sviews addObject:sview];
            [self addSubview:sview];
            
        }
        _currentTag = 100;
        self.backgroundColor = [UIColor clearColor];
        _animateTimer = nil;
    }
    return self;
}

-(void)startAnimating
{
    if (_animateTimer==nil) {
        _animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(next) userInfo:nil repeats:YES];
    }
    self.hidden = NO;
}

-(void)stopAnimating
{
    [_animateTimer invalidate];
    _animateTimer = nil;
    self.hidden = YES;
}


-(void)next
{
    _currentTag++;
    if (_currentTag == 108) {
        [self viewWithTag:_currentTag-1].alpha = 0;
        _currentTag = 100;
        [self viewWithTag:_currentTag].alpha = 1;
    }
    else{
        [self viewWithTag:_currentTag-1].alpha = 0;
        [self viewWithTag:_currentTag].alpha = 1;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
