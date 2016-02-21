//
//  CXProjectSelectView.m
//  XWealth
//
//  Created by chx on 15/7/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProjectSelectView.h"
#import "CXPullFunctionsCell.h"

@interface CXProjectSelectView ()
{
    NSIndexPath *currentIndexPath;
}

@end

@implementation CXProjectSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithProjects:(NSArray *)projectList
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _projectList = projectList;
        
        CGFloat x = 0;
        self.frame = CGRectMake(x, kNavAndStatusBarHeight - 10, kScreenWidth, ProjectGridCellHeight * [self numberOfRows] + 10 + 3 * 25);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = kRadius;
        
        CGRect bgFrame = self.frame;
        bgFrame.origin.y = 0;
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:bgFrame];
        bgImg.image  =IMAGE(@"category_bg");
        [self addSubview:bgImg];
        
        [self initSubButtonView];
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = kColorClear;
//        _overlayView.backgroundColor = kColorBlack;
//        _overlayView.alpha = 0.5;
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) initSubButtonView
{
    CGFloat margeH = (self.frame.size.width-140)/4;
    CGFloat margeV = 25;
    CGFloat y = 0;
    CGFloat width = ProjectGridCellWidth;
    CGFloat height = ProjectGridCellHeight;
    
    //创建按钮
    for (int i =0; i < _projectList.count; i++)
    {
        CXCategoryModel *model = (CXCategoryModel *)_projectList[i];
        
        CGRect btnFrame = CGRectMake(margeH + (width + margeH) * (i%3),
                                     y + (i/3) * (height + margeV) + 10 + margeV,
                                     width,
                                     height);
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:btnFrame];
        [imgView sd_setImageWithURL:[NSURL URLWithString: model.logoUrl] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
        imgView.backgroundColor = kColorClear;
        [self addSubview:imgView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame: btnFrame];
        button.tag = 100+i;
        button.layer.masksToBounds = YES;
        button.backgroundColor = kColorClear;
        [button addTarget:self action:@selector(projectItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
}

-(void)projectItemClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    [_overlayView removeFromSuperview];
    
    if (_delegate && _delegate != nil)
    {
        if ([_delegate respondsToSelector:@selector(projectSelectView:didSelectIndex:)])
        {
            [_delegate projectSelectView:self didSelectIndex:button.tag - 100];
        }
    }
    
    [self.delegate didBackgroundTap];
}

- (NSInteger) numberOfRows
{
    NSInteger rows = (self.projectList.count / ProjectGridColumns);
    if ((self.projectList.count % ProjectGridColumns) > 0)
    {
        rows += 1;
    }
    
    return rows;
}


#pragma mark - show & hide
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(.6, .6);
    self.alpha = 0;
    self.center = CGPointMake(self.center.x, self.center.y-20);
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1;
        self.center = CGPointMake(self.center.x, self.center.y+20);
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.alpha = 0.0;
        self.center = CGPointMake(self.center.x, self.center.y-20);
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            _overlayView = nil;
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    [self fadeIn];
}

- (void)dismiss
{
    [self.delegate didBackgroundTap];
    [self fadeOut];
}

@end
