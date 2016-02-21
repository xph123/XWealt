//
//  CXProductBannerViewController.m
//  XWealth
//
//  Created by 12345 on 15-12-15.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductBannerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CXProductDetailWebViewController.h"
#import "CXActivityViewController.h"
#import "CXClassroomDatailViewController.h"

@interface CXProductBannerViewController ()

@end

@implementation CXProductBannerViewController

- (id) initWithBanners:(NSArray *) data
{
    self = [super init];
    
    if (self)
    {
        NSMutableArray *imaArr=[[NSMutableArray alloc]init];
        //int imageNum=(int)[arrayImages count]+2;
        
        [imaArr addObject:data[[data count]-1]];
        for (int i=0; i<[data count]; i++) {
            [imaArr addObject:data[i]];
        }
        [imaArr addObject:data[0]];
        _arrData = imaArr;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    UIView* v=[[UIView alloc] initWithFrame:kScreenBound];
    self.view=v;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect textFrame = self.view.bounds;
    textFrame.size.height = kBannerHeight;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:textFrame];
    //    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,BannerHeight)];
    [_scrollView setPagingEnabled:YES];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) * [self.arrData count], kBannerHeight)];
    _scrollView.contentOffset=CGPointMake(self.view.frame.size.width, self.scrollView.bounds.origin.y);
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, textFrame.size.height - 20, textFrame.size.width, 20)];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [self.arrData count]-2;
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    
    _viewController = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.arrData count]; i++) {
        [_viewController addObject:[NSNull null]];
    }
    
    for (int i = 0; i < [_arrData count]; i++)
    {
        [self loadScrollViewPage:i];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //    [super viewWillAppear:animated];
    //
    //    [_scrollTimer setFireDate:[NSDate distantPast]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //    [super viewWillDisappear:animated];
    //
    //    [_scrollTimer setFireDate:[NSDate distantFuture]];
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
       
        
        imageViewController.view.backgroundColor=kControlBgColor;
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(kLargeMargin, 0, self.scrollView.frame.size.width-2*kLargeMargin, (self.scrollView.frame.size.width-2*kLargeMargin)/1.32)];
        backView.backgroundColor=[UIColor whiteColor];
        backView.layer.cornerRadius=5.0f;
        backView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickpagecontrol)];
        [backView addGestureRecognizer:tapGesture];
        [imageViewController.view addSubview:backView];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 2)];
        line.backgroundColor=kOrangeColor;
        [backView addSubview:line];
        
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(kDefaultMargin, line.frame.size.height, backView.frame.size.width-2*kDefaultMargin, kTwoLineLabelHeight)];
        titleLable.font = kMiddleTextFont;
        titleLable.textColor = kTitleTextColor;
        titleLable.numberOfLines = 1;
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.backgroundColor = [UIColor clearColor];\
        [backView addSubview:titleLable];
        
        UIImageView *centerLine=[[UIImageView alloc]initWithFrame:CGRectMake(kDefaultMargin, titleLable.frame.size.height+titleLable.frame.origin.y, backView.frame.size.width-2*kDefaultMargin, 0.5)];
        centerLine.backgroundColor=kLineColor2;
        [backView addSubview:centerLine];
        
        UILabel *preProfitLable = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin,  titleLable.frame.size.height+titleLable.frame.origin.y, 6*10, kLabelHeight)];
        preProfitLable.font = kSmallTextFont;
        preProfitLable.textColor = kTextColor;
        preProfitLable.numberOfLines = 1;
        preProfitLable.textAlignment = NSTextAlignmentRight;
        preProfitLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:preProfitLable];
        
        UILabel *preProfitValueLable = [[UILabel alloc] initWithFrame:CGRectMake(preProfitLable.frame.size.width+preProfitLable.frame.origin.x+kDefaultMargin,  titleLable.frame.size.height+titleLable.frame.origin.y, 40, kLabelHeight)];
        preProfitValueLable.font = kMiddleTextFont;
        preProfitValueLable.textColor = kTextColor;
        preProfitValueLable.numberOfLines = 1;
        preProfitValueLable.textAlignment = NSTextAlignmentLeft;
        preProfitValueLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:preProfitValueLable];
       
        UILabel *stateLable = [[UILabel alloc] initWithFrame:CGRectMake((backView.frame.size.width-kDefaultMargin)/2,  titleLable.frame.size.height+titleLable.frame.origin.y, (backView.frame.size.width-kDefaultMargin)/2, kLabelHeight)];
        stateLable.font = kMiddleTextFont;
        stateLable.textColor = kOrangeColor;
        stateLable.numberOfLines = 1;
        stateLable.textAlignment = NSTextAlignmentRight;
        stateLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:stateLable];
        
        
        UIImageView *roundImage=[[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/4, preProfitLable.frame.size.height+preProfitLable.frame.origin.y, backView.frame.size.width/2, backView.frame.size.width/2)];
        roundImage.image=[UIImage imageNamed:@"product_round_back"];
        [backView addSubview:roundImage];
        
        UILabel *deadlineLable=[[UILabel alloc]initWithFrame:CGRectMake(0, kDefaultMargin, backView.frame.size.width, kLabelHeight)];
        deadlineLable.font = kSmallTextFont;
        deadlineLable.textColor = kTextColor;
        deadlineLable.numberOfLines = 1;
        deadlineLable.textAlignment = NSTextAlignmentCenter;
        deadlineLable.backgroundColor = [UIColor clearColor];
        [roundImage addSubview:deadlineLable];

        
        UILabel *scheduleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, roundImage.frame.size.height/2, backView.frame.size.width, kLabelHeight)];
        scheduleLable.font = kSmallTextFont;
        scheduleLable.textColor = kOrangeColor;
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
        
        UILabel *commentValueLable=[[UILabel alloc]initWithFrame:CGRectMake(commentLable.frame.origin.x+commentLable.frame.size.width, roundImage.frame.size.height+roundImage.frame.origin.y+kDefaultMargin, backView.frame.size.width-commentLable.frame.origin.x+commentLable.frame.size.width-kDefaultMargin, kTwoLineLabelHeight)];
        commentValueLable.font = kSmallTextFont;
        commentValueLable.textColor = [UIColor whiteColor];
        commentValueLable.numberOfLines = 2;
        commentValueLable.textAlignment = NSTextAlignmentCenter;
        commentValueLable.backgroundColor = [UIColor clearColor];
        [backView addSubview:commentValueLable];
        
        UIButton *scheduleButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/4, commentValueLable.frame.origin.y+commentValueLable.frame.size.height, backView.frame.size.width/2, backView.frame.size.width/3.5)];
        scheduleButton.layer.masksToBounds = YES;
        scheduleButton.layer.cornerRadius = kRadius;
        //_scheduleButton.layer.borderColor = kLineColor.CGColor;
        //    _scheduleButton.layer.borderWidth = 1;
        [scheduleButton setBackgroundColor:kProductRedColor];
        [scheduleButton setTitle: StringProductSchedule forState: UIControlStateNormal];
        scheduleButton.titleLabel.font = kMiddleTextFont;
        [scheduleButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [scheduleButton addTarget:self action:@selector(scheduleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview: scheduleButton];
        
      
         CXProductModel* model = [self.arrData objectAtIndex:page];
        titleLable.text=model.title;
        preProfitLable.text=@"年化收益:";
        NSString *profitStr=[NSString stringWithFormat:@"%.1f%%",[model.profit floatValue]];
        NSRange profitRangecash = [profitStr rangeOfString:[NSString stringWithFormat:@"%0.1f",[model.profit floatValue]]];
        NSMutableAttributedString *profitMutableStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
        [profitMutableStr addAttribute:NSForegroundColorAttributeName value:kOrangeColor range:profitRangecash];
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
                    deadlineLable.text = [NSString stringWithFormat:@"产品期限:%d年", deadlineInt / 12];
                }
                else
                {
                    deadlineLable.text = [NSString stringWithFormat:@"产品期限:%d月", deadlineInt];
                }
            }
            else
            {
                deadlineLable.text = [NSString stringWithFormat:@"产品期限:%d月", deadlineInt];
            }
        }
       
        scheduleLable.text=[NSString stringWithFormat:@"%d%%",model.receipts * 100 / model.scale];

        
        commentLable.text=@"专家点评";
        commentValueLable.text=model.comment;
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[_scrollTimer fire];
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    
    NSInteger page = floor((self.scrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    if (page==0) {
        page=_arrData.count-2;
        _scrollView.contentOffset=CGPointMake(CGRectGetWidth(self.view.frame) *page, self.scrollView.bounds.origin.y);
    }
    if (page==_arrData.count-1) {
        page=1;
        _scrollView.contentOffset=CGPointMake(CGRectGetWidth(self.view.frame) *page, self.scrollView.bounds.origin.y);
    }
    self.pageControl.currentPage = page-1;

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
//    CXBannerModel* model = [self.arrData objectAtIndex: self.pageControl.currentPage+1];
//    // 分类，用于识别banner的类型，1 为产品，2 为理财学堂，3为资讯
//    if (model.ptypeId == 2)
//    {
//        CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
//        detailController.courseId = model.productId;
//        detailController.hidesBottomBarWhenPushed = YES;
//        
//        [ self.navigationController pushViewController:detailController animated:YES];
//    }
//    else if (model.ptypeId == 3)
//    {
//        CXActivityViewController *activityViewController = [[CXActivityViewController alloc] init];
//        activityViewController.titleName=StringPopularActivity;
//        activityViewController.url = model.url;
//        activityViewController.nameUrl = model.name;
//        activityViewController.imageUrl = model.imageUrl;
//        activityViewController.infoId = model.productId;
//        activityViewController.shareUrl = model.url;
//        activityViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:activityViewController animated:YES];
//        
//        //        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
//        //        detailController.informationId = model.productId;
//        //        detailController.hidesBottomBarWhenPushed = YES;
//        //
//        //        [ self.navigationController pushViewController:detailController animated:YES];
//    }
//    else
//    {
//        //        if (model.productId > 0)
//        {
//            //            CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//            //            detailController.productId = model.productId;
//            //            detailController.hidesBottomBarWhenPushed = YES;
//            //            [ self.navigationController pushViewController:detailController animated:YES];
//            CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
//            productDetailWebViewController.hidesBottomBarWhenPushed = YES;
//            productDetailWebViewController.productId = model.productId;
//            productDetailWebViewController.titleName=@"产品详情";
//            productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
//            [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
//        }
//        //        else if (model.url && model.url.length > 0)
//        //        {
//        //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gaosouyi.com/xintuobao/index.html"]];
//        //        }
//    }
    
}

-(void)scheduleBtnClick
{
    
}

@end
