//
//  XChoiceView.m
//  xProject
//
//  Created by yi.chen on 14-4-27.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XChoiceView.h"

#define MCV_TOPVIEW_HEIGHT      42
#define MCV_MODULE_H            4
#define MCV_MODULE_BGCOLOR      [UIColor whiteColor]
#define MCV_MODULE_TEXTCOLOR    [UIColor blackColor]
#define MCV_MODULE_STARTTAG     102121
#define MCV_PROMPT_BUTTON_TAG   121032 //提示按钮 tag
#define MCV_IVSLIDER_IMAGE      @"slider_line.png"

#define AC_LEFTSPACING          9.5

@implementation XChoiceView

@synthesize module      =module_;
@synthesize ivSlider    =ivSlider_;
@synthesize scrollView  =scrollView_;
@synthesize topView     =topView_;

- (id)initWithFrame:(CGRect)frame mouldes:(NSArray *)keys views:(NSDictionary *)vs;
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize selfSize = frame.size;
        //NSUInteger modsCount = keys.count;
        self.modsCount = keys.count;
        
        //改变实战topView的布局 颜色
        CGFloat topViewLeft = AC_LEFTSPACING;//8.5;
        CGFloat topViewY    = 10.5;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topViewLeft, topViewY, selfSize.width-topViewLeft*2, MCV_TOPVIEW_HEIGHT)];
        //topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:IAC_Plate]];
        self.topView = topView;
        [self addSubview:topView_];
        
        UIScrollView *bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,topView.frame.origin.y+topView.frame.size.height+topViewLeft, selfSize.width, selfSize.height-MCV_TOPVIEW_HEIGHT-topView.frame.origin.y-topViewLeft)];
        //PRINTFFRAME(bottomView.frame);
        bottomView.showsHorizontalScrollIndicator = NO;
        bottomView.showsVerticalScrollIndicator = NO;
        bottomView.pagingEnabled = YES;
        bottomView.delegate = self;
        bottomView.backgroundColor = [UIColor clearColor];
        self.scrollView = bottomView;
        [self addSubview:scrollView_];
        
        CGFloat moulde_w = topView.frame.size.width/self.modsCount;
        //CGFloat moulde_h = MCV_TOPVIEW_HEIGHT-MCV_MODULE_H;
        
        NSMutableArray *arrButtons = [[NSMutableArray alloc] initWithCapacity:self.modsCount];
        NSUInteger index = 0;
        CGFloat x = 0;
        CGFloat view_x = 0;
        while (index < self.modsCount) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setFrame:CGRectMake(x, 0, moulde_w-0.8, topView.frame.size.height)];
            //IAC_Plate
            [btn setBackgroundImage:IMAGE(@"choiceview_bg") forState:UIControlStateNormal];
            [btn setTitle:keys[index] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            [btn setTag:(MCV_MODULE_STARTTAG+index)];
            [btn addTarget:self action:@selector(choiceModule:) forControlEvents:UIControlEventTouchUpInside];
            [arrButtons addObject:btn];
            [topView_ addSubview:btn];
            x+=moulde_w;
            
            UIView *view = [vs objectForKey:keys[index]];
            view.frame = CGRectMake(view_x, 0, scrollView_.frame.size.width, scrollView_.frame.size.height);
            view.tag = MCV_MODULE_STARTTAG+index;
            [scrollView_ addSubview:view];
            view_x+=scrollView_.frame.size.width;
            
            if(!kIsIOS7OrLater)
            {
                //如果系统是ios6，则添加清扫手势
                UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSwitchTableView:)];
                swipe.numberOfTouchesRequired = 1;
                if(index==0) swipe.direction = UISwipeGestureRecognizerDirectionLeft;
                else swipe.direction = UISwipeGestureRecognizerDirectionRight;
                [view addGestureRecognizer:swipe];
            }
            
            ++index;
            
            //jet luo landscape show UI
            btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
            /*
             新增
             添加提示按钮
             */
            float btn_w = btn.frame.size.width;
            CGRect promptBtnFrame = CGRectMake(btn_w-40, 8, 16, 16);
            UIButton *btnPrompt = [[UIButton alloc] initWithFrame:promptBtnFrame];
            [btn addSubview:btnPrompt];
            [btnPrompt setBackgroundImage:IMAGE(@"choiceview_plate_prompt") forState:UIControlStateNormal];
            [btnPrompt setTag:MCV_PROMPT_BUTTON_TAG];
            btnPrompt.titleLabel.font = kExtralSmallTextFont;
            [btnPrompt setHidden:YES];
            [btnPrompt setUserInteractionEnabled:NO];
        }
        
        scrollView_.contentSize = CGSizeMake(index*scrollView_.frame.size.width, scrollView_.frame.size.height);
        
        UIImageView *slider = [[UIImageView alloc] initWithFrame:CGRectMake(0, MCV_TOPVIEW_HEIGHT-MCV_MODULE_H, moulde_w, MCV_MODULE_H)];
        [slider setImage:IMAGE( @"choiceview_plate_slider")];
        self.ivSlider = slider;
        [topView addSubview:ivSlider_];
        self.module = arrButtons;
        
        // landscape show UI
        if(!kIsIOS7OrLater)
        {
            //禁用scrollView滚动
            [self.scrollView setScrollEnabled:NO];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.ivSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //给第一个Button添加观察，目的：根据frame的改变判断横屏，竖屏
        [[self.topView viewWithTag:MCV_MODULE_STARTTAG] addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

/*
 根据Button的frame变化动态改变ivSlider的frame
 改变scoreView的ContentSize
 改变scoreView子视图的frame
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isKindOfClass:[UIButton class]])
    {
        if([keyPath isEqualToString:@"frame"])
        {
            //更新ivSlider frame
            CGRect sliderFrame = self.ivSlider.frame;
            sliderFrame.size.width = [self.topView viewWithTag:MCV_MODULE_STARTTAG].frame.size.width;
            sliderFrame.origin.x = sliderFrame.origin.x >= sliderFrame.size.width ? sliderFrame.size.width : 0;
            self.ivSlider.frame = sliderFrame;
            
            
            CGFloat topViewLeft = AC_LEFTSPACING;//8.5;
            CGSize selfSize = self.frame.size;
            //MCV_TOPVIEW_HEIGHT 是 topView的高度
            CGRect scrollViewFrame = CGRectMake(0,self.topView.frame.origin.y+self.topView.frame.size.height+topViewLeft, selfSize.width, selfSize.height-MCV_TOPVIEW_HEIGHT-self.topView.frame.origin.y-topViewLeft);
            self.scrollView.frame = scrollViewFrame;
            
            //这里乘以2, 只有当scrollView仅仅包含2个UIView时有效
            self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width*self.modsCount, scrollViewFrame.size.height);
            
            //2应改为动态
            for(int i=0; i<self.modsCount; i++)
            {
                UIView *view = [self.scrollView viewWithTag:MCV_MODULE_STARTTAG+i];
                CGRect viewFrame = view.frame;
                viewFrame.origin.x = i*scrollViewFrame.size.width;
                viewFrame.origin.y = 0;
                viewFrame.size.width = scrollViewFrame.size.width;
                viewFrame.size.height = scrollViewFrame.size.height;
                view.frame = viewFrame;
            }
            
            //滚动ScrollView
            CGPoint offset = self.scrollView.contentOffset;
            if(sliderFrame.origin.x == 0)
            {
                offset.x = 0;
            } else {
                offset.x = self.scrollView.frame.size.width;
            }
            [self.scrollView setContentOffset:offset animated:NO];
        }
    }
}

- (void)choiceModule:(UIButton *)button
{
    CGRect bFrame = button.frame;
    bFrame.origin.y = self.ivSlider.frame.origin.y;
    bFrame.size.height = self.ivSlider.frame.size.height;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.ivSlider.frame = bFrame;
    }];
    
    CGPoint newOffset = scrollView_.contentOffset;
    newOffset.x = (button.tag-MCV_MODULE_STARTTAG)*scrollView_.frame.size.width;
    [self.scrollView setContentOffset:newOffset animated:YES];
    
    // watson.chen
    [self.delegate moduleChoiceView:button];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

//减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    CGFloat pageWidth = sView.frame.size.width;
    NSInteger page = floor((sView.contentOffset.x-pageWidth/self.modsCount)/pageWidth)+1;
    UIButton *button = (UIButton *)[self.topView viewWithTag:(MCV_MODULE_STARTTAG+page)];
    CGRect bFrame = button.frame;
    bFrame.origin.y = self.ivSlider.frame.origin.y;
    bFrame.size.height = self.ivSlider.frame.size.height;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.ivSlider.frame = bFrame;
    }];
}

//拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /*
     //在滚动时，让滚动条在中间停留2秒
     if(self.ivSlider.center.x != self.topView.center.x)
     {
     [UIView animateWithDuration:0.25 animations:^{
     //self.ivSlider.center = CGPointMake(self.topView.center.x+20, self.ivSlider.center.y);
     self.ivSlider.center = CGPointMake(self.topView.center.x, self.ivSlider.center.y);
     } completion:^(BOOL finished) {
     
     }];
     }
     */
}

#pragma mark -
#pragma mark 显示提示
- (void)showPromptCountToOne:(int)count
{
    [self showPromptCount:count viewTag:MCV_MODULE_STARTTAG];
}
- (void)showPromptCountToTwo:(int)count
{
    [self showPromptCount:count viewTag:(MCV_MODULE_STARTTAG+1)];
}

- (void)showPromptCount:(int)count viewTag:(int)tag
{
    UIButton *promptButton = (UIButton *)[[self.topView viewWithTag:tag] viewWithTag:MCV_PROMPT_BUTTON_TAG];
    promptButton.hidden = count >= 1 ? NO : YES;
    [promptButton performSelector:@selector(setTitle:forState:) withObject:[NSString stringWithFormat:@"%i",count] withObject:UIControlStateNormal];
}

#pragma mark -
#pragma mark 手势
- (void)swipeSwitchTableView:(UISwipeGestureRecognizer *)swipe
{
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        UIButton *button = (UIButton *)[self.topView viewWithTag:MCV_MODULE_STARTTAG+1];
        [self choiceModule:button];
    }
    else if(swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        UIButton *button = (UIButton *)[self.topView viewWithTag:MCV_MODULE_STARTTAG];
        [self choiceModule:button];
    }
}

- (void)dealloc
{
    [[self.topView viewWithTag:MCV_MODULE_STARTTAG] removeObserver:self forKeyPath:@"frame"];
}

@end


