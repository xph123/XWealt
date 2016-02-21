//
//  CXHomePageTwoCell.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageTwoCell.h"
#import "UIImageView+AFNetworking.h"
#import "CXProductDetailWebViewController.h"
#import "CXActivityViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXSubscribeViewController.h"

@implementation CXHomePageTwoCell
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void) addData:(NSArray *) data
{
    
    NSMutableArray *imaArr=[[NSMutableArray alloc]init];
    //int imageNum=(int)[arrayImages count]+2;
    
    for (int i=0; i<[data count]; i++) {
        [imaArr addObject:data[i]];
    }
    _arrData = imaArr;
    [self initSubviews];
    
}



- (void)initSubviews
{
    // Do any additional setup after loading the view.
    CXHomePageTwoCellFrame *layer=[[CXHomePageTwoCellFrame alloc]init];
    CGRect textFrame = [layer cellViewRect];
    _scrollView = [[UIScrollView alloc] initWithFrame:textFrame];
    //    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,BannerHeight)];
    [_scrollView setPagingEnabled:YES];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces=NO;
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * [self.arrData count], 0)];
    _scrollView.contentOffset=CGPointMake(0, 0);
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, textFrame.size.height - 26-kDefaultMargin, textFrame.size.width, 20)];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    _pageControl.pageIndicatorTintColor=kControlBgColor;
    _pageControl.currentPageIndicatorTintColor=kPointBlueColor;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [self.arrData count];
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    
    _viewController = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.arrData count]; i++) {
        [_viewController addObject:[NSNull null]];
    }
    
    for (int i = 0; i < [_arrData count]; i++)
    {
        [self loadScrollViewPage:i];
    }
    
}


-(void)loadScrollViewPage:(NSInteger)page
{
    if (page >= self.arrData.count) {
        return;
    }
    
    UIViewController *imageViewController = [self.viewController objectAtIndex:page];
    if ((NSNull *)imageViewController == [NSNull null])
    {
        imageViewController = [[UIViewController alloc] init];
        [self.viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    
    if (imageViewController.view.superview == nil) {
        
        CXProductModel* model = [self.arrData objectAtIndex:page];
        imageViewController.view.backgroundColor=kControlBgColor;
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
        int backHeight=frame.size.height;
        UIImageView *backView=[[UIImageView alloc]initWithFrame:CGRectMake(kLargeMargin, kDefaultMargin, self.scrollView.frame.size.width-2*kLargeMargin, backHeight-2*kDefaultMargin)];
        //        backView.backgroundColor=[UIColor whiteColor];
        backView.image=[UIImage imageNamed:@"home_product_back"];
        backView.layer.cornerRadius=5.0f;
        backView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickpagecontrol)];
        [backView addGestureRecognizer:tapGesture];
        [imageViewController.view addSubview:backView];
        
        //        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 2)];
        //        line.backgroundColor=kOrangeColor;
        //        [backView addSubview:line];
        
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(kDefaultMargin, 2, backView.frame.size.width-2*kDefaultMargin, kTwoLineLabelHeight)];
        titleLable.font = kMiddleTextFont;
        titleLable.textColor = kTitleTextColor;
        titleLable.numberOfLines = 1;
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.backgroundColor = [UIColor clearColor];\
        [backView addSubview:titleLable];
        
        UIImageView *centerLine=[[UIImageView alloc]initWithFrame:CGRectMake(kDefaultMargin, titleLable.frame.size.height+titleLable.frame.origin.y, backView.frame.size.width-2*kDefaultMargin, 0.5)];
        centerLine.backgroundColor=kLineColor2;
        [backView addSubview:centerLine];
        
        UILabel *preProfitLable = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin,  titleLable.frame.size.height+titleLable.frame.origin.y, 55, kLabelHeight)];
        preProfitLable.font = kSmallTextFont;
        preProfitLable.textColor = kTextColor;
        preProfitLable.numberOfLines = 1;
        preProfitLable.textAlignment = NSTextAlignmentLeft;
        preProfitLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:preProfitLable];
        
        UILabel *preProfitValueLable = [[UILabel alloc] initWithFrame:CGRectMake(preProfitLable.frame.size.width+preProfitLable.frame.origin.x,  titleLable.frame.size.height+titleLable.frame.origin.y, 100, kLabelHeight)];
        preProfitValueLable.font = kMiddleTextFont;
        preProfitValueLable.textColor = kTextColor;
        preProfitValueLable.numberOfLines = 1;
        preProfitValueLable.textAlignment = NSTextAlignmentLeft;
        preProfitValueLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:preProfitValueLable];
        
        UILabel *stateLable = [[UILabel alloc] initWithFrame:CGRectMake((backView.frame.size.width-kDefaultMargin)/2,  titleLable.frame.size.height+titleLable.frame.origin.y, (backView.frame.size.width-kDefaultMargin)/2, kLabelHeight)];
        stateLable.font = kMiddleTextFont;
        stateLable.textColor = kProductRedColor;
        stateLable.numberOfLines = 1;
        stateLable.textAlignment = NSTextAlignmentRight;
        stateLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:stateLable];
        
        
        UIImageView *roundImage=[[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/4, preProfitLable.frame.size.height+preProfitLable.frame.origin.y, backView.frame.size.width/2, backView.frame.size.width/2)];
        roundImage.image=[UIImage imageNamed:@"product_round_back"];
        [backView addSubview:roundImage];
        
        UILabel *deadlineLable=[[UILabel alloc]initWithFrame:CGRectMake(0, kMiddleMargin, roundImage.frame.size.width, kLabelHeight)];
        deadlineLable.font = kMiddleTextFont;
        deadlineLable.textColor = kTextColor;
        deadlineLable.numberOfLines = 1;
        deadlineLable.textAlignment = NSTextAlignmentCenter;
        deadlineLable.backgroundColor = [UIColor clearColor];
        [roundImage addSubview:deadlineLable];
        
        
        UILabel *scheduleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, roundImage.frame.size.height/2, roundImage.frame.size.width, kLabelHeight)];
        scheduleLable.font = kLargeTextFont;
        scheduleLable.textColor = [UIColor whiteColor];
        scheduleLable.numberOfLines = 1;
        scheduleLable.textAlignment = NSTextAlignmentCenter;
        scheduleLable.backgroundColor = [UIColor clearColor];
        [roundImage addSubview:scheduleLable];
        
        UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(kDefaultMargin, roundImage.frame.size.height+roundImage.frame.origin.y+kDefaultMargin, 60, kLabelHeight)];
        commentLable.font = kSmallTextFont;
        commentLable.textColor = kTextColor;
        commentLable.numberOfLines = 1;
        commentLable.textAlignment = NSTextAlignmentCenter;
        commentLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:commentLable];
        
        int commentValueLableHeight=kLabelHeight;
        CGSize size = [model.comment getSizeWithWidth: backView.frame.size.width-commentLable.frame.origin.x-commentLable.frame.size.width-kDefaultMargin fontSize:kSmallTextFontSize];
        
        if (size.height > kLabelHeight-2)
        {
            commentValueLableHeight = kTwoLineLabelHeight;
        }
        
        
        UILabel *commentValueLable=[[UILabel alloc]initWithFrame:CGRectMake(commentLable.frame.origin.x+commentLable.frame.size.width, roundImage.frame.size.height+roundImage.frame.origin.y+kDefaultMargin, backView.frame.size.width-commentLable.frame.origin.x-commentLable.frame.size.width-kDefaultMargin, commentValueLableHeight)];
        
        commentValueLable.font = kSmallTextFont;
        commentValueLable.textColor = kProductRedColor;
        commentValueLable.numberOfLines = 2;
        commentValueLable.textAlignment = NSTextAlignmentLeft;
        commentValueLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:commentValueLable];
        
        UIButton *scheduleButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/4, commentValueLable.frame.origin.y+kTwoLineLabelHeight+kMiddleMargin, backView.frame.size.width/2, backView.frame.size.width/2/3.5)];
        scheduleButton.layer.masksToBounds = YES;
        scheduleButton.layer.cornerRadius = kRadius;
        //_scheduleButton.layer.borderColor = kLineColor.CGColor;
        //    _scheduleButton.layer.borderWidth = 1;
        [scheduleButton setBackgroundColor:kProductRedColor];
        [scheduleButton setTitle: StringWindSubscribe forState: UIControlStateNormal];
        scheduleButton.titleLabel.font = kMiddleTextFont;
        [scheduleButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [scheduleButton addTarget:self action:@selector(scheduleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview: scheduleButton];
        
        [self.scrollView addSubview:imageViewController.view];
        //        [imageViewController didMoveToParentViewController:self];
        
        
        
        
        NSString *profit = @"浮收";
        if (![model.fullProfit isEmpty])
        {
            profit = model.fullProfit;
        }
        else
        {
            if (![model.profit isEmpty])
            {
                profit = [NSString stringWithFormat:@"%@%%", model.profit];
            }
        }
        
        titleLable.text=model.title;
        preProfitLable.text=@"年化收益:";
        NSString *profitStr=profit;
        NSRange profitRangecash = [profitStr rangeOfString:profit];
        NSMutableAttributedString *profitMutableStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
        [profitMutableStr addAttribute:NSForegroundColorAttributeName value:kProductRedColor range:profitRangecash];
        preProfitValueLable.attributedText = profitMutableStr;
        
        stateLable.text=@"火爆进款中..";
        
        if (![model.fullDeadline isEmpty]) {
            deadlineLable.text = model.fullDeadline;
        }
        else
        {
            int deadlineInt=[model.deadline intValue];
            if (deadlineInt >= 12)
            {
                if (deadlineInt % 12 == 0)
                {
                    deadlineLable.text = [NSString stringWithFormat:@"%d年", deadlineInt / 12];
                }
                else
                {
                    deadlineLable.text = [NSString stringWithFormat:@"%d月", deadlineInt];
                }
            }
            else
            {
                deadlineLable.text = [NSString stringWithFormat:@"%d月", deadlineInt];
            }
        }
        
        scheduleLable.text=[NSString stringWithFormat:@"%0.1f%%",(CGFloat)model.receipts * 100 / model.scale];
        
        
        commentLable.text=@"专家点评";
        commentValueLable.text=model.comment;
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[_scrollTimer fire];
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    
    NSInteger page = floor((self.scrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    self.pageControl.currentPage = page;
    
}


- (void)changePage
{
    NSInteger page = self.pageControl.currentPage+1;
    
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = self.scrollView.bounds.origin.y;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
}

- (void) clickpagecontrol
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    CXProductSimplyModel* model = [self.arrData objectAtIndex: self.pageControl.currentPage];
    
    CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
    productDetailWebViewController.hidesBottomBarWhenPushed = YES;
    productDetailWebViewController.productId = model.productId;
    productDetailWebViewController.titleName=@"产品详情";
    productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
    [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
}

-(void)scheduleBtnClick
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    CXProductSimplyModel* model = [self.arrData objectAtIndex: self.pageControl.currentPage];
    if (model.state == 2||model.state == 1)
    {
        return;
    }
    

    
    CXSubscribeViewController * subscribeController=[[CXSubscribeViewController alloc] init];
    subscribeController.productId = model.productId;
    subscribeController.productName = model.title;
    [ self.navigationController pushViewController:subscribeController animated:YES];
    
}


@end


