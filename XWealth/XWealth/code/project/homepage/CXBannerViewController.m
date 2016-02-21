//
//  CXBannerViewController.m
//  eLearning
//
//  Created by watson on 14-5-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXBannerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CXProductDetailWebViewController.h"
#import "CXActivityViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXTrustTransferCenterDetailViewController.h"
#import "CXBuybackTrustCenterDetailViewController.h"

@interface CXBannerViewController ()

@end

@implementation CXBannerViewController

- (id) initWithBanners:(NSArray *) arrayImages
{
    self = [super init];
    
    if (self)
    {
        NSMutableArray *imaArr=[[NSMutableArray alloc]init];
        //int imageNum=(int)[arrayImages count]+2;
        
         [imaArr addObject:arrayImages[[arrayImages count]-1]];
        for (int i=0; i<[arrayImages count]; i++) {
            [imaArr addObject:arrayImages[i]];
        }
        [imaArr addObject:arrayImages[0]];
        _arrayImages = imaArr;
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
    _stopNum=0;
    CGRect textFrame = self.view.bounds;
    textFrame.size.height = kBannerHeight;

    _scrollView = [[UIScrollView alloc] initWithFrame:textFrame];
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,BannerHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    _scrollView.pagingEnabled=YES;
    //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) * [self.arrayImages count], kBannerHeight)];
    _scrollView.contentOffset=CGPointMake(self.view.frame.size.width, self.scrollView.bounds.origin.y);
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, textFrame.size.height - 20, textFrame.size.width, 20)];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [self.arrayImages count]-2;
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    
    _viewController = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [self.arrayImages count]; i++) {
        [_viewController addObject:[NSNull null]];
    }
    
    for (int i = 0; i < [_arrayImages count]; i++)
    {
        [self loadScrollViewPage:i];
    }
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_scrollTimer setFireDate:[NSDate distantPast]];
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
    if (page >= self.arrayImages.count) {
        return;
    }
    
    UIViewController *imageViewController = [self.viewController objectAtIndex:page];
    if ((NSNull *)imageViewController == [NSNull null])
    {
        imageViewController = [[UIViewController alloc] init];
        [self.viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    
    if (imageViewController.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        imageViewController.view.frame = frame;
        
        UIButton *img=[[UIButton alloc]initWithFrame:self.scrollView.frame];
        [img addTarget:self action:@selector(clickpagecontrol) forControlEvents:UIControlEventTouchUpInside];
        [imageViewController.view addSubview:img];

        
        UIImageView *bannerImageView; // 最上面的大图
        bannerImageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
        [img addSubview: bannerImageView];
        
        //[self addChildViewController:imageViewController];
        [self.scrollView addSubview:imageViewController.view];
        [imageViewController didMoveToParentViewController:self];
        
        CXBannerModel* model = [self.arrayImages objectAtIndex:page];
        
        [bannerImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"default_image"]];
        
//        [imageViewController.view setBackgroundColor:[UIColor colorWithPatternImage:(UIImage *)[self.arrayImages objectAtIndex:page]]];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_scrollTimer setFireDate:[NSDate distantFuture]];
    [_stopScrollTimer setFireDate:[NSDate distantFuture]];
    _stopNum=0;

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //[_scrollTimer fire];
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    
    NSInteger page = floor((self.scrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    if (page==0) {
        page=_arrayImages.count-2;
        _scrollView.contentOffset=CGPointMake(CGRectGetWidth(self.view.frame) *page, self.scrollView.bounds.origin.y);
    }
    if (page==_arrayImages.count-1) {
        page=1;
        _scrollView.contentOffset=CGPointMake(CGRectGetWidth(self.view.frame) *page, self.scrollView.bounds.origin.y);
    }
    self.pageControl.currentPage = page-1;
//    [self loadScrollViewPage:page-1];
//    [self loadScrollViewPage:page];
//    [self loadScrollViewPage:page+1];
    _stopScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(stopScrollTimerClick) userInfo:nil repeats:YES];
    //[_stopScrollTimer setFireDate:[NSDate distantFuture]];

}


- (void)changePage
{
    NSInteger page = self.pageControl.currentPage+1;

//    [self loadScrollViewPage:page - 1];
//    [self loadScrollViewPage:page];
//    [self loadScrollViewPage:page + 1];
    
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = self.scrollView.bounds.origin.y;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
}

- (void) clickpagecontrol
{
    CXBannerModel* model = [self.arrayImages objectAtIndex: self.pageControl.currentPage+1];
    // 分类，用于识别banner的类型，1 为产品，2 为理财学堂，3为活动 4转让 5受让
    if (model.ptypeId == 2)
    {
        CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
        detailController.courseId = model.productId;
        detailController.hidesBottomBarWhenPushed = YES;
        
        [ self.navigationController pushViewController:detailController animated:YES];
    }
    else if (model.ptypeId == 3)
    {
        CXActivityViewController *activityViewController = [[CXActivityViewController alloc] init];
        activityViewController.titleName=StringPopularActivity;
        activityViewController.url = model.url;
        activityViewController.nameUrl = model.name;
        activityViewController.imageUrl = model.imageUrl;
        activityViewController.infoId = model.productId;
        activityViewController.shareUrl = model.url;
        activityViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityViewController animated:YES];
        
//        CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
//        detailController.informationId = model.productId;
//        detailController.hidesBottomBarWhenPushed = YES;
//        
//        [ self.navigationController pushViewController:detailController animated:YES];
    }
    else if (model.ptypeId == 4)
    {
        CXTrustTransferCenterDetailViewController *trustTransferCenterDetailController=[[CXTrustTransferCenterDetailViewController alloc]init];
        trustTransferCenterDetailController.benefitId=model.productId;
        [self.navigationController pushViewController:trustTransferCenterDetailController animated:YES];
    }
    else if (model.ptypeId == 5)
    {
        CXBuybackTrustCenterDetailViewController *buybackTrustCenterDetailViewController=[[CXBuybackTrustCenterDetailViewController alloc]init];
        buybackTrustCenterDetailViewController.buybackId=model.productId;
        [self.navigationController pushViewController:buybackTrustCenterDetailViewController animated:YES];
    }
    else
    {
//        if (model.productId > 0)
        {
//            CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//            detailController.productId = model.productId;
//            detailController.hidesBottomBarWhenPushed = YES;
//            [ self.navigationController pushViewController:detailController animated:YES];
            CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
            productDetailWebViewController.hidesBottomBarWhenPushed = YES;
            productDetailWebViewController.productId = model.productId;
            productDetailWebViewController.titleName=@"产品详情";
            productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
            [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
        }
//        else if (model.url && model.url.length > 0)
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gaosouyi.com/xintuobao/index.html"]];
//        }
    }

}

- (void) scrollPages
{
    ++self.pageControl.currentPage;
    
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    if (isFromStart)
    {
        self.scrollView.contentOffset=CGPointMake(0, self.scrollView.bounds.origin.y);
        [UIView animateWithDuration:0.1f animations:^{
            [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, self.scrollView.bounds.origin.y) animated:YES];
            self.pageControl.currentPage = 0;
        }];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(pageWidth*(self.pageControl.currentPage+1), self.scrollView.bounds.origin.y) animated:YES];
        
    }
    if (_pageControl.currentPage == _pageControl.numberOfPages - 1)
    {
        isFromStart = YES;
    }
    else
    {
        isFromStart = NO;
    }
}
-(void)stopScrollTimerClick
{
    _stopNum++;
    if (_stopNum==4) {
        _stopNum=0;
        [_scrollTimer setFireDate:[NSDate distantPast]];
        [_stopScrollTimer setFireDate:[NSDate distantFuture]];
    }
}

@end
