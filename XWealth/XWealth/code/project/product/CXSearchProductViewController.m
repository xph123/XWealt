//
//  CXSearchProductViewController.m
//  XWealth
//
//  Created by chx on 15-3-19.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSearchProductViewController.h"
#import "CXProductDetailViewController.h"
#import "CXConditionView.h"

@interface CXSearchProductViewController ()
{
NSString *_searchBarValue;
    
NSString *_subscribe;
NSString *_deadline;
NSString *_profit;
    
NSString *_profitStr;
NSString *_subscribeStr;
NSString *_deadlineStr;
UISearchBar *_nameSearchBar;
}

@property (nonatomic, assign) NSInteger curPage;
@end

@implementation CXSearchProductViewController

#pragma mark - view control circle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索产品";
    self.view.backgroundColor = kControlBgColor;
    
    [self initRightBarButton];
    _searchBarValue = @"";
    _subscribe = 0;
    _deadline = 0;
    _profit = 0;
    _curPage = 0;
    
    CGRect searchFrame = self.view.frame;
    searchFrame.origin.y=0;
    searchFrame.origin.y += kViewBeginOriginY;
    searchFrame.size.height = kHeightOfSearchBar;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchFrame];
    searchBar.placeholder= StringProductSearchInfo;
    searchBar.delegate = self;
    searchBar.keyboardType = UISearchBarStyleDefault;
//    [searchBar becomeFirstResponder];
    [self.view addSubview: searchBar];
    _nameSearchBar = searchBar;
    
    CGRect frameView = CGRectMake(0, kHeightOfSearchBar + kDefaultMargin, self.view.bounds.size.width , 180);
    
    CXConditionView *conditionView = [[CXConditionView alloc] initWithFrame:frameView];
//    conditionView.backgroundColor = kColorWhite;
//    [self.view addSubview:conditionView];
    conditionView.delegate=self;
    self.conditionView = conditionView;
    
    CGRect frame = CGRectMake(0, kViewBeginOriginY + kHeightOfSearchBar + kDefaultMargin, self.view.bounds.size.width, kScreenHeight - kViewBeginOriginY - kViewEndSizeHeight - kHeightOfSearchBar - 2 * kDefaultMargin);
    
    _tableView = [[CXProductTableView alloc] initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.tableView.tableHeaderView = conditionView;
    [self.view addSubview: _tableView];
    
    
    self.loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loadMoreBtn.frame = CGRectMake(0, 0, kScreenWidth, 30);
    _loadMoreBtn.backgroundColor = kControlBgColor;
    [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loadMoreBtn setTitleColor:kColorGrayLight forState:UIControlStateNormal];
    [_loadMoreBtn addTarget: self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableView.tableFooterView = _loadMoreBtn;
    _tableView.tableView.contentOffset = CGPointMake(0, 0);
    
    _loadMoreBtn.hidden = YES;

    _productList = [NSMutableArray array];
    
    self.noFriend = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight+kHeightOfSearchBar+kDefaultMargin + 180, kScreenWidth, 24)];
    _noFriend.textColor = kTextColor;
    _noFriend.text = @"抱歉，未找到您搜索的产品!";
    _noFriend.textAlignment = NSTextAlignmentCenter;
    _noFriend.font = [UIFont systemFontOfSize:15];
    _noFriend.hidden = YES;
    [self.view addSubview:_noFriend];
}

- (void)goBack:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initRightBarButton
{
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 60, 30);
    [releaseBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    releaseBtn.titleLabel.font = kMiddleTextFont;
    [releaseBtn setTitle:StringSearch forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    [self.navigationItem setRightBarButtonItems:@[rightBar]];
}


- (void)searchButtonClicked
{
    [self.tableView.tableView reloadData];
    _searchBarValue = _nameSearchBar.text;

     CXCategoryModel *subscribeCategory = [_conditionView.subscribeList objectAtIndex:_subscribeCategory];
    _subscribeStr=_conditionView.subscribeBtn.titleLabel.text;
    _subscribe =[NSString stringWithFormat:@"%ld",subscribeCategory.categoryId];
    
     CXCategoryModel *deadlineCategory = [_conditionView.deadlineList objectAtIndex:_deadlineCategory];
    _deadlineStr=_conditionView.deadlineBtn.titleLabel.text;
    _deadline = [NSString stringWithFormat:@"%ld",deadlineCategory.categoryId];
    
    CXCategoryModel *profitCategory = [_conditionView.profitList objectAtIndex:_profitCategory];
    _profitStr=_conditionView.profitBtn.titleLabel.text;
    _profit = [NSString stringWithFormat:@"%ld",profitCategory.categoryId];
    
    if (![_searchBarValue isEqualToString:@""]
        || ![_profitStr isEqualToString:StringProductUnlimited]
        || ![_subscribeStr isEqualToString:StringProductUnlimited]
        || ![_deadlineStr isEqualToString:StringProductUnlimited]
        ) {
        
        if ([self checkParameter] == 1)
        {
            [self startSearch];
        }
    }
    else
    {
        [self ShowProgressHUB:@"请填写搜索条件！"];
    }
    [_nameSearchBar resignFirstResponder];
}

- (int) checkParameter
{
    if ([_profitStr isEqualToString:StringProductUnlimited]) {
        _profit=@"0";
    }
    if ([_subscribeStr isEqualToString:StringProductUnlimited]) {
        _subscribe=@"0";
    }
    if ([_deadlineStr isEqualToString:StringProductUnlimited]) {
        _deadline=@"0";
    }
    return 1;
}

#pragma mark - UISearchBarDelegate
// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
{
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    _searchBarValue = searchBar.text;
    
    if (![_searchBarValue isEqualToString:@""]) {
        [self startSearch];
    }
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)cancelSelect:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(void)tableViewDidScroll:(UIScrollView *)scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_nameSearchBar resignFirstResponder];
    if (fabs(fabs(_tableView.tableView.contentOffset.y) - _tableView.tableView.contentSize.height + _tableView.frame.size.height) <= 1) {
        if (!_isLoadingMore) {
            [self loadMore];
        }
    }
}

#pragma mark - UIScrollView
//此代理在scrollview滚动时就会调用
//在下拉一段距离到提示松开和松开后提示都应该有变化，变化可以在这里实现
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_nameSearchBar resignFirstResponder];
    if (fabs(fabs(_tableView.tableView.contentOffset.y) - _tableView.tableView.contentSize.height + _tableView.frame.size.height) <= 1) {
        if (!_isLoadingMore) {
            [self loadMore];
        }
    }
}

//松开后判断表格是否在刷新，若在刷新则表格位置偏移，且状态说明文字变化为loading...
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)loadMore
{
    if (_hasMore) {
        _isLoadingMore = YES;
        [_loadMoreBtn setTitle:@"正在加载 . . ." forState:UIControlStateNormal];
        
        if (_productList && _productList.count)
        {
            self.curPage++;
            [self searchProduct:self.curPage];
        }
        else
        {
            self.curPage = BASE_PAGE;
            [self searchProduct:self.curPage];
        }
    }
    
}

#pragma mark - network data

- (void)startSearch
{
    if (!self.HUD) {
        self.HUD = [[MBProgressHUD alloc] initWithView:kCurrentKeyWindow];
        [self.view addSubview:self.HUD];
        self.HUD.labelText = @"搜索中...";
        self.HUD.removeFromSuperViewOnHide = NO;
    }
    [self.HUD show:YES];
    
    _reload = YES;
    _hasMore = YES;
    self.curPage = BASE_PAGE;
    
    [self searchProduct:self.curPage];
}


- (void)searchProduct:(NSInteger) page
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    
    [parametersUtil appendParameterWithName:@"curPage" andLongValue:page];
    if (![_searchBarValue isEqualToString:@""])
    {
        [parametersUtil appendParameterWithName:@"word" andStringValue:_searchBarValue];
    }
    else
    {
        [parametersUtil appendParameterWithName:@"subscribeId" andStringValue:_subscribe];
        [parametersUtil appendParameterWithName:@"deadlineId" andStringValue:_deadline];
        [parametersUtil appendParameterWithName:@"profitId" andStringValue:_profit];
    }
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_SEARCHCOND result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if (self.HUD) {
            [self.HUD hide:YES];
        }
        
        if(!err)
        {
            XLog(@"searchProduct success");
            
            if (_reload) {
                [_productList removeAllObjects];
            }
            
            if (mainPlate.anyModels.count == 0)
            {
                if (_reload) {
                    [_tableView.tableView reloadData];
                    _noFriend.hidden = NO;
                    _loadMoreBtn.hidden = YES;
                }
                else {
                    _hasMore = NO;
                    _noFriend.hidden = YES;
                    _loadMoreBtn.hidden = NO;
                    
                    [_loadMoreBtn setTitle:@"加载完毕" forState:UIControlStateNormal];
                }
                return;
            }
            else
            {
                if (_reload) {
                    _tableView.tableView.contentOffset = CGPointMake(0, 0);
                }
            }
            
            [_productList addObjectsFromArray:mainPlate.anyModels];
            [_tableView configData:_productList];
            
                        
            _noFriend.hidden = YES;
            _loadMoreBtn.hidden = NO;
            
            if (mainPlate.anyModels.count < 10 && mainPlate.anyModels.count > 0) {
                _hasMore = NO;
                [_loadMoreBtn setTitle:@"加载完毕" forState:UIControlStateNormal];
            }
            else{
                _hasMore = YES;
                [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
            }
            
            [_tableView.tableView reloadData];
            
            if (_isLoadingMore) {
                _isLoadingMore = NO;
            }
            if (_reload) {
                _reload = NO;
            }
        }
        else
        {
            XLog(@"searchProduct fail");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = PromptLoadingFail;
            hud.yOffset = -50;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            
            if (_isLoadingMore) {
                _isLoadingMore = NO;
            }
            
        }
    }];
}

#pragma mark - CXProductTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXProductSimplyModel *model = [_productList objectAtIndex:indexPath.row];
    
    __unsafe_unretained CXSearchProductViewController *weak_self = self;
    if (weak_self.selectProductBlk) {
        weak_self.selectProductBlk(model.productId, model.title);
        
        [self goBack:nil];
    }
    else
    {
//        CXProductDetailViewController * detailController=[[CXProductDetailViewController alloc] init];
//        detailController.hidesBottomBarWhenPushed = YES;
//        detailController.productId = model.productId;
//        [ self.navigationController pushViewController:detailController animated:YES];
        
        CXProductDetailWebViewController * productDetailWebViewController=[[CXProductDetailWebViewController alloc] init];
        productDetailWebViewController.hidesBottomBarWhenPushed = YES;
        productDetailWebViewController.productId = model.productId;
        productDetailWebViewController.titleName=@"产品详情";
        productDetailWebViewController.url=[NSString stringWithFormat:@"%@%@%ld", kBaseURLString,GET_PRODUCT_WEBLIST, model.productId];
        [ self.navigationController pushViewController:productDetailWebViewController animated:YES];
    }
}
#pragma mark - CXConditionViewDelegate
-(void)setSubscribeList:(NSArray *)subscribeData andIndex:(int)index
{
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:subscribeData andSelect:index];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=0;
    [self.navigationController pushViewController:modifyControl animated:YES];
}
-(void)setDeadlineList:(NSArray *)deadlineData andIndex:(int)index
{
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:deadlineData andSelect:index];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=1;
    [self.navigationController pushViewController:modifyControl animated:YES];
}
-(void)setProfitList:(NSArray *)profitData andIndex:(int)index
{
    CXSelectTableViewController *modifyControl = [[CXSelectTableViewController alloc] initWithSourceData:profitData andSelect:index];
    modifyControl.delegate = self;
    modifyControl.title = StringProductCategory;
    modifyControl.nameId=2;
    [self.navigationController pushViewController:modifyControl animated:YES];
}
#pragma mark - CXSelectTableViewControllerDelegate
- (void)setSelected:(int)nameId andIndex:(int)index;
{
    if (nameId==0) {
        self.subscribeCategory=index;
        _conditionView.subscribeCategory=index;
        CXCategoryModel *category = [_conditionView.subscribeList objectAtIndex:_conditionView.subscribeCategory];
        NSString *strState = category.name;
        [_conditionView.subscribeBtn setTitle:strState forState:UIControlStateNormal];
        
    }
    else if (nameId==1)
    {
        self.deadlineCategory=index;
        _conditionView.deadlineCategory=index;
        CXCategoryModel *category = [_conditionView.deadlineList objectAtIndex:_conditionView.deadlineCategory];
        NSString *strState = category.name;
        [_conditionView.deadlineBtn setTitle:strState forState:UIControlStateNormal];

    }
    else if (nameId==2)
    {
        self.profitCategory=index;
        _conditionView.profitCategory=index;
        CXCategoryModel *category = [_conditionView.profitList objectAtIndex:_conditionView.profitCategory];
        NSString *strState = category.name;
        [_conditionView.profitBtn setTitle:strState forState:UIControlStateNormal];

    }
     [_productList removeAllObjects];
    [self searchButtonClicked];
}
@end
