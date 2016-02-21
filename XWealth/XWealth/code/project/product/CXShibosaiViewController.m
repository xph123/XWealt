//
//  CXShibosaiViewController.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXShibosaiViewController.h"

@interface CXShibosaiViewController ()

@end

@implementation CXShibosaiViewController

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
    self.title = @"阳光私募";
    
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
    [parametersUtil appendParameterWithName:@"category" andIntValue:3];
    
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

#pragma mark - CXInformationTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    NSIndexPath *indexPath = (NSIndexPath*)data;
    CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    
    //    CXInformationDetailViewController* detailController=[[CXInformationDetailViewController alloc] init];
    //    detailController.url = @"http://www.baidu.com";// model.url;
    //    detailController.hidesBottomBarWhenPushed = YES;
    //
    //    [ self.navigationController pushViewController:detailController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
