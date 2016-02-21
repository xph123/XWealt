//
//  XSlideSwitchView.m
//  Link
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XSlideSwitchView.h"
#import "UIColor+UIImage.h"
#import "Constants.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kFontSizeOfTabButton = 14.0f;
static const CGFloat kHeightOfShadowImage = 3.0f;

#define kColorOfShadowImage    UIColorFromRGB(0xb9b3ad)         // kGetColor(185, 179, 173)   //#b9b3ad
#define kColorOfTabNormalTextImage   UIColorFromRGB(0xaba49d)  // kGetColor(171, 164, 157)   //#aba49d   正常时tab文字颜色
#define kColorOfTabSelectTextImage   UIColorFromRGB(0x232222)  // kGetColor(35, 34, 34)      //#232222   选中时tab文字颜色
#define kColorOfTabBackgroundImage   UIColorFromRGB(0xece8e4)  // kGetColor(236, 232, 228)   //#ece8e4   tab背景图片颜色

@implementation XSlideSwitchView

#pragma mark - 初始化参数

- (void)initValues
{
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _topScrollView.scrollsToTop = NO;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _rootScrollView.scrollsToTop = NO;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _isBuildUI = NO;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,_rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView-1, _rootScrollView.bounds.size.width, 1)];
    line.backgroundColor = kLineColor;
    [_topScrollView addSubview:line];
    
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    _shadowImageView = [[UIImageView alloc] initWithImage:[kColorOfShadowImage translateIntoImage]];
    [_topScrollView addSubview:_shadowImageView];
    
    //每个tab偏移量
    CGFloat xOffset = 0;
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset, 0, self.bounds.size.width/[_viewArray count], kHeightOfTopScrollView)];
        //计算下一个tab的x偏移量
        xOffset += self.bounds.size.width/[_viewArray count];
        
        [button setTag:i+100];
        if (i == 0) {
            _shadowImageView.frame = CGRectMake(0, kHeightOfTopScrollView - kHeightOfShadowImage, self.bounds.size.width/[_viewArray count], kHeightOfShadowImage);
            button.selected = YES;
        }
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:kColorOfTabNormalTextImage forState:UIControlStateNormal];
        [button setTitleColor:kColorOfTabSelectTextImage forState:UIControlStateSelected];
        [button setBackgroundImage:[kColorOfTabBackgroundImage translateIntoImage] forState:UIControlStateNormal];
        //[button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        if ([_viewArray count] == 4) {    //只有主视图的[_viewArray count] =＝ 4
            if (i == 2) {
                UIImageView *tips = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 18, 18)];
                tips.image = IMAGE(@"msg_not_read");
                tips.hidden = YES;
                [button addSubview:tips];
                self.msgTips = tips;
                
                UILabel *notReadNum = [[UILabel alloc] initWithFrame:CGRectMake(2, 3, 14, 11)];
                notReadNum.font = [UIFont boldSystemFontOfSize:11];
                notReadNum.textAlignment = NSTextAlignmentCenter;
                notReadNum.textColor = kColorWhite;
                notReadNum.backgroundColor = [UIColor clearColor];
                notReadNum.hidden = YES;
                [self.msgTips addSubview:notReadNum];
                self.msgNotReadNum = notReadNum;
            }
            if (i == 3) {
                NSInteger addFriendNum = 0;
                if ([kAppDelegate.db open]) {
                    FMResultSet *rs=[kAppDelegate.db executeQuery:@"SELECT * FROM AddFriend WHERE status = ?",@"0"];
                    while ([rs next]) {
                        addFriendNum++;
                    }
                    [rs close];
                    [kAppDelegate.db close];
                }
                
                UIImageView *tips = [[UIImageView alloc] initWithFrame:CGRectMake(55, 0, 18, 18)];
                tips.image = IMAGE(@"msg_not_read");
                tips.hidden = YES;
                [button addSubview:tips];
                self.friendTips = tips;
                
                UILabel *notReadNum = [[UILabel alloc] initWithFrame:CGRectMake(2, 3, 14, 11)];
                notReadNum.font = [UIFont boldSystemFontOfSize:11];
                notReadNum.textAlignment = NSTextAlignmentCenter;
                notReadNum.textColor = kColorWhite;
                notReadNum.backgroundColor = [UIColor clearColor];
                notReadNum.hidden = YES;
                [self.friendTips addSubview:notReadNum];
                self.friendNotReadNum = notReadNum;
                
                if (addFriendNum == 0) {
                    _friendTips.hidden = YES;
                    _friendNotReadNum.hidden = YES;
                }
                else {
                    _friendTips.hidden = NO;
                    _friendNotReadNum.hidden = NO;
                    _friendNotReadNum.text = [NSString stringWithFormat:@"%d",addFriendNum];
                }
            }
        }
        [_topScrollView addSubview:button];
    }
    
    [_topScrollView bringSubviewToFront:_shadowImageView];
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(kScreenWidth, kHeightOfTopScrollView);
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */

- (void)setDefauletViewFromIndex:(NSInteger)index
{
    UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:index + 99];
    [self selectNameButton:lastButton];
}


- (void)selectNameButton:(UIButton *)sender
{
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, kHeightOfTopScrollView - kHeightOfShadowImage, sender.frame.size.width, kHeightOfShadowImage)];
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
                }
                _isRootScroll = NO;
                
                for (int i = 0; i < [_viewArray count]; i++) {
                    [_topScrollView viewWithTag:i+100].userInteractionEnabled = YES;
                }
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
    }
    //重复点击选中按钮
    else {
        for (int i = 0; i < [_viewArray count]; i++) {
            [_topScrollView viewWithTag:i+100].userInteractionEnabled = YES;
        }
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
        for (int i = 0; i < [_viewArray count]; i++) {
            [_topScrollView viewWithTag:i+100].userInteractionEnabled = NO;
        }
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        if (tag == _userSelectedChannelID) {
            _isRootScroll = NO;
        }
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

@end
