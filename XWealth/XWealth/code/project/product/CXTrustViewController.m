//
//  CXTrustViewController.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXTrustViewController.h"
#import "CXProductDetailWebViewController.h"

@interface CXTrustViewController ()

@end

@implementation CXTrustViewController

- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kButtomBarHeight + kDefaultMargin : kButtomBarHeight + kDefaultMargin;
    tableVFrame.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight : 0);
    tableVFrame.origin.y += kDefaultMargin;
    
    _tableView = [[CXProductTableView alloc] initWithFrame:tableVFrame];
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"信托";
    
    _sourceDatas = [[NSMutableArray alloc] init];

    [self loadTrustFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  network data

- (void) loadTrustFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"category" andIntValue:1];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_PRODUCT_LIST result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
            [self.tableView configDataHaveHeaderView:_sourceDatas];
        }
        else
        {
            XLog(@"get banner list fail");
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
-(void)tableViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
