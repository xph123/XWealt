//
//  CXInformationReadersViewController.m
//  XWealth
//
//  Created by chx on 15-3-17.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationReaderViewController.h"

@interface CXInformationReaderViewController ()

@end

@implementation CXInformationReaderViewController

- (void)loadView
{
    [super loadView];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.origin.y += kDefaultMargin;
    tableVFrame.size.height -= 2 * kDefaultMargin;
    
    _tableView = [[CXUserTableView alloc] initWithFrame:tableVFrame];
    [self.view addSubview: _tableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kControlBgColor;
    self.title = @"阅读记录";
    
    _sourceDatas = [[NSMutableArray alloc] init];
    
    [self loadInformationReadersFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  network data

- (void) loadInformationReadersFromServer
{
    XHttpParameters *parametersUtil = [XHttpParameters parameters];
    [parametersUtil appendParameterWithName:@"informationId" andLongValue:_informationId];
    
    [CXDataCenter queryParams:parametersUtil.parameters strURL:GET_INFORMATION_READER result:^(CXMainPlate *mainPlate, NSError *err) {
        
        if(!err)
        {
            XLog(@"get banner list success");
            
            _sourceDatas = (NSMutableArray * )mainPlate.anyModels;
            [self.tableView configData:_sourceDatas];
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
