//
//  CXMyAttentionViewController.m
//  XWealth
//
//  Created by chx on 15/6/19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyAttentionViewController.h"
#import "CXProductDetailWebViewController.h"

@interface CXMyAttentionViewController ()
@property (nonatomic, assign) NSInteger curPage;

@end

@implementation CXMyAttentionViewController

- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y +=kViewBeginOriginY +kDefaultMargin ;
    tableVFrame.size.height -=  kViewBeginOriginY + kViewEndSizeHeight + kDefaultMargin*2;
    
    
    _tableView = [[CXProductTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"您还未关注产品，产品详情中可以关注感兴趣的产品!", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"我的关注";
    
    self.curPage = BASE_PAGE;
    _sourceDatas = [[NSMutableArray alloc] init];
    
    //[self loadMyAttentionFromServer:self.curPage];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
      [self loadMyAttentionFromServer:self.curPage];
}
#pragma mark -  network data

- (void) loadMyAttentionFromServer:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }

    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LISTATTENTION result:^(CXMainPlate *mainPlate, NSError *err) {
 
        if(!err)
        {
            XLog(@"loadMyAttentionFromServer success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];

        }
        else
        {
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"loadMyAttentionFromServer fail");
        }
    }];
}

#pragma mark - CXProductTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
//    CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//    detailController.hidesBottomBarWhenPushed = YES;
//    detailController.productId = model.productId;
//    [ self.navigationController pushViewController:detailController animated:YES];
    CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
    productDetailWebViewController.hidesBottomBarWhenPushed = YES;
    productDetailWebViewController.productId = model.productId;
    productDetailWebViewController.titleName=@"产品详情";
    productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
    [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}

#pragma mark - PullUpLoadMoreViewDelegate
- (void)loadMore
{
    if (_loadMoreView.state != LoadMoreStateComplete) {
        _loadMoreView.state = LoadMoreStateIsLoading;
        
        if (_sourceDatas && _sourceDatas.count > 0)
        {
            self.curPage ++;
            [self loadMyAttentionFromServer:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadMyAttentionFromServer:self.curPage];
        }
    }
}

- (void)updateDelegateView
{
}



@end
