//
//  CXPopularActivityViewController.m
//  XWealth
//
//  Created by gsycf on 15/10/12.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXPopularActivityViewController.h"
#import "CXActivityViewController.h"
@interface CXPopularActivityViewController ()

@end

@implementation CXPopularActivityViewController
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}

- (void)loadView
{
    [super loadView];
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y +=kSmallMargin;
    tableVFrame.size.height -= kViewEndSizeHeight + kSmallMargin;
    
    _tableView = [[CXPopularActivityTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    _tableView.isHaveSection = false;
    [self.view addSubview: _tableView];
    
    
    
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"活动暂时没有开放，敬请留意！", nil);
    self.tableView.tableView.tableFooterView = _loadMoreView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    
    _sourceDatas = [[NSMutableArray alloc] init];
    
    self.navigationItem.title=StringPopularActivity;
    
    self.curPage = BASE_PAGE;
    [self loadInformationWithCategoryFromPage:self.curPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -  network data
- (void) loadInformationWithCategoryFromPage:(NSInteger)page
{
    if (page == BASE_PAGE)
    {
        if (self.sourceDatas && self.sourceDatas.count > 0)
        {
            [self.sourceDatas removeAllObjects];
        }
    }
    
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    NSString *category=@"10";
   [parametersUtil appendParameterWithName:@"category" andIntValue:[category intValue]];
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATIONS result:^(CXMainPlate *mainPlate, NSError *err) {
        if(!err)
        {
            XLog(@"get banner list success");
            
            [_sourceDatas addObjectsFromArray:mainPlate.anyModels];
            [self.tableView configDataHaveHeaderView:_sourceDatas];
            
            [_loadMoreView updateWithCurrentLoadCount:mainPlate.anyModels.count
                                       totalLoadCount:_sourceDatas.count
                                             pageSize:@"10"];
        }
        else
        {
            [self.tableView.tableView reloadData];
            _loadMoreView.state = LoadMoreStateFail;
            XLog(@"get banner list fail");
            
        }
    }];
}



#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
    CXActivityViewController* detailController=[[CXActivityViewController alloc] init];
    detailController.titleName=StringPopularActivity;
    detailController.url=model.url;
    detailController.nameUrl=model.name;
    if ([model.imageUrl isEqualToString:@""]||model.imageUrl==nil) {
        detailController.imageUrl=model.imageUrl;
    }
    else
    {
        detailController.imageUrl=[kBaseURLString stringByAppendingString:model.imageUrl];
    }
    detailController.infoId = model.informationId;
     detailController.shareUrl = model.url;
    detailController.hidesBottomBarWhenPushed = YES;
    
    [ self.navigationController pushViewController:detailController animated:YES];
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
            [self loadInformationWithCategoryFromPage:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self loadInformationWithCategoryFromPage:self.curPage];
        }
    }
}
- (void)updateDelegateView
{
    
}


@end
