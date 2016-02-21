//
//  CXTrustTransferCenterRecommendViewController.m
//  XWealth
//
//  Created by gsycf on 15/11/6.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterRecommendViewController.h"
#import "CXProductTransferViewController.h"
#import "CXTrustTransferCenterDetailViewController.h"
@interface CXTrustTransferCenterRecommendViewController ()
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger delIndex;
@end



@implementation CXTrustTransferCenterRecommendViewController

- (void) dealloc
{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        _sourceDatas = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kControlBgColor;
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kDefaultMargin+kViewBeginOriginY;
    tableVFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin ;
    
    _tableView = [[CXTrustTransferCenterTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"推荐";
    [self initRightBarButton];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.curPage = BASE_PAGE;
    [self.tableView configData:_sourceDatas];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI mark
- (void) initRightBarButton
{
    UIButton *sendTradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendTradeBtn.frame=CGRectMake(0, 0, 60, 30);
    sendTradeBtn.titleLabel.font=kMiddleTextFontBold;
    [sendTradeBtn setTitle:StringRelease forState:UIControlStateNormal];
    sendTradeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    sendTradeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    [sendTradeBtn addTarget:self action:@selector(sendSubscribe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:sendTradeBtn];
    [self.navigationItem setRightBarButtonItem:rightBar];
    
}
#pragma mark - private methods

- (void) sendSubscribe
{
    CXProductTransferViewController *productTransferView=[[CXProductTransferViewController alloc]init];
    [self.navigationController pushViewController:productTransferView animated:YES];
}



#pragma mark - CXTrustTransferCenterTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXBenefitModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    CXTrustTransferCenterDetailViewController *trustTransferCenterDetailController=[[CXTrustTransferCenterDetailViewController alloc]init];
    trustTransferCenterDetailController.benefitId=model.releaseId;
    trustTransferCenterDetailController.productId=model.productId;
    [self.navigationController pushViewController:trustTransferCenterDetailController animated:YES];
}



#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}


- (void)updateDelegateView
{
    
}

@end
