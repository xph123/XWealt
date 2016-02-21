//
//  CXSearchClassroomViewController.m
//  XWealth
//
//  Created by gsycf on 15/8/26.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSearchClassroomViewController.h"
#import "CXClassroomDatailViewController.h"
#import "CXConditionView.h"

@interface CXSearchClassroomViewController ()
{
    NSString *_searchBarValue;
    UISearchBar *_nameSearchBar;
}
@end

@implementation CXSearchClassroomViewController
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

    self.title = @"搜索资料";
    self.view.backgroundColor = kControlBgColor;
    
    _searchBarValue = @"";
    
    CGRect searchFrame = self.view.frame;
    searchFrame.origin.y=0;
    searchFrame.origin.y += kViewBeginOriginY;
    searchFrame.size.height = kHeightOfSearchBar;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame: searchFrame];
    searchBar.placeholder= StringInformationSearchInfo;
    searchBar.delegate = self;
    searchBar.keyboardType = UISearchBarStyleDefault;
    [searchBar becomeFirstResponder];
    [self.view addSubview: searchBar];
    _nameSearchBar = searchBar;
    
    
    CGRect frame = CGRectMake(0, kViewBeginOriginY + kHeightOfSearchBar, self.view.bounds.size.width, kScreenHeight - kViewBeginOriginY - kViewEndSizeHeight - kHeightOfSearchBar );
    
    _collectionView=[[CXClassroomListCollectionView alloc]initWithFrame:frame];
    _collectionView.delegate=self;
    //_collectionView.isHaveSection=true;
    [self.view addSubview:_collectionView];
    
    
    self.loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loadMoreBtn.frame = CGRectMake(0, 0, kScreenWidth, 30);
    _loadMoreBtn.backgroundColor = kControlBgColor;
    [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
    _loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loadMoreBtn setTitleColor:kColorGrayLight forState:UIControlStateNormal];
    [_loadMoreBtn addTarget: self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    _collectionView.collectionfootView = _loadMoreBtn;
    _collectionView.collectionView.contentOffset = CGPointMake(0, 0);
    
    _loadMoreBtn.hidden = YES;
    
    _informationList = [NSMutableArray array];
    
    self.noFriend = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight+kHeightOfSearchBar + kDefaultMargin, kScreenWidth, 24)];
    _noFriend.textColor = kTextColor;
    _noFriend.text = @"抱歉，未找到您搜索的信息!";
    _noFriend.textAlignment = NSTextAlignmentCenter;
    _noFriend.font = [UIFont systemFontOfSize:15];
    _noFriend.hidden = YES;
    [self.view addSubview:_noFriend];
    
    
    self.loadMoreView = [[PullUpLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _loadMoreView.delegate = self;
    _loadMoreView.state = LoadMoreStateIsLoading;
    _loadMoreView.noData = NSLocalizedString(@"该分类下没有资讯!", nil);
    _collectionView.collectionfootView = _loadMoreView;
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
    if (fabs(fabs(_collectionView.collectionView.contentOffset.y) - _collectionView.collectionView.contentSize.height + _collectionView.frame.size.height) <= 1) {
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
    if (fabs(fabs(_collectionView.collectionView.contentOffset.y) - _collectionView.collectionView.contentSize.height + _collectionView.frame.size.height) <= 1) {
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
        
        [self searchInformation];
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
    _currentPage = 1;
    
    [self searchInformation];
}


- (void)searchInformation
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"word" andStringValue:_searchBarValue];
    [parametersUtil appendParameterWithName:@"page" andIntValue:_currentPage];
    [parametersUtil appendParameterWithName:@"pageSize" andIntValue:kPageSize];

    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_COURSE_SEARCH result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if (self.HUD) {
            [self.HUD hide:YES];
        }
        
        if(!err)
        {
            XLog(@"get friend list success");
            
            if (_reload) {
                [_informationList removeAllObjects];
            }
            
            if (mainPlate.anyModels.count == 0)
            {
                if (_reload) {
                    [self.collectionView.collectionView reloadData];
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
                    _collectionView.collectionView.contentOffset = CGPointMake(0, 0);
                }
            }
            
            [_informationList addObjectsFromArray:mainPlate.anyModels];
            [_collectionView configData:_informationList];
            
            
            _noFriend.hidden = YES;
            _loadMoreBtn.hidden = NO;
            
            if (mainPlate.anyModels.count < 10 && mainPlate.anyModels.count > 0) {
                _hasMore = NO;
                [_loadMoreBtn setTitle:@"加载完毕" forState:UIControlStateNormal];
            }
            else{
                _hasMore = YES;
                self.currentPage += 1;
                [_loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
            }
            
            [_collectionView.collectionView reloadData];
            
            if (_isLoadingMore) {
                _isLoadingMore = NO;
            }
            if (_reload) {
                _reload = NO;
            }
        }
        else
        {
            XLog(@"get friend list fail");
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

#pragma mark - CXClassroomListCollectionViewDelegate

- (void)didSelectItemAtIndex:(id)data
{

        NSIndexPath *indexPath = (NSIndexPath*)data;
        CXLawModel *model = [_informationList objectAtIndex:indexPath.row];
        CXClassroomDatailViewController* detailController=[[CXClassroomDatailViewController alloc] init];
        detailController.courseId = model.classId;
        detailController.hidesBottomBarWhenPushed = YES;
        [ self.navigationController pushViewController:detailController animated:YES];

}
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
}
//#pragma mark - PullUpLoadMoreViewDelegate
//
//- (void)loadMore
//{
////    if (_loadMoreView.state != LoadMoreStateComplete) {
////        _loadMoreView.state = LoadMoreStateIsLoading;
////        
////        if (_sourceDatas && _sourceDatas.count > 0)
////        {
////            self.curPage ++;
////            [self loadInformationWithCategoryFromServer:_leftIndex andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
////        }
////        else
////        {
////            self.curPage = BASE_PAGE;
////            [self loadInformationWithCategoryFromServer:_leftIndex andIndex:self.rightCategoryModel.categoryId andPage:self.curPage];
////        }
////    }
//}
//- (void)updateDelegateView
//{
//    
//}
@end
