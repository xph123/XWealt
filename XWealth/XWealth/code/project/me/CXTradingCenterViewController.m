//
//  CXTradingCenterViewController.m
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTradingCenterViewController.h"
#import "CXMySubscribeViewController.h"
#import "CXMyReleaseViewController.h"
#import "CXMyBenefitReleaseViewController.h"
#import "CXMyBuybackViewController.h"

@interface CXTradingCenterViewController ()

@end

@implementation CXTradingCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringTradingCenter;
    self.view.backgroundColor=kControlBgColor;
    _tableDatas=[[NSArray alloc]initWithObjects:
                 StringMySubscribe,
                 StringMyRelease,
                 StringMyBenefitTransfer,
                 StringMyBuyBack,
//                 StringMyAgreement,
                 nil];
    _tableImageDatas=[[NSArray alloc]initWithObjects:
                    @"mySubscribe",
                    @"myRelease",
                    @"myBenefit",
                    @"myBuyback",
//                    @"myBenefit",
                      nil];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.size.height -=  kTabBarHeight;
    self.tableView=[[UITableView alloc]initWithFrame:tableVFrame style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=kControlBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kDefaultMargin)];
    headView.backgroundColor=kControlBgColor;
    self.tableView.tableHeaderView=headView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofRows = 0;
    numberofRows=self.tableDatas.count;
    return numberofRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXFoundCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[CXFoundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.downlineBool=NO;
    [cell setTitle:_tableDatas[indexPath.row] andImage:_tableImageDatas[indexPath.row]];
            
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight+kDefaultMargin;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        switch (indexPath.row) {
            case 0:
            {
                //我的预约
                CXMySubscribeViewController *subscribeControl = [[CXMySubscribeViewController alloc] init];
                subscribeControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:subscribeControl animated:YES];
                
            }
                break;
            case 1:
            {   //我的发布
                CXMyReleaseViewController *releaseControl = [[CXMyReleaseViewController alloc] init];
                releaseControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:releaseControl animated:YES];
            }
                break;
            case 2:
            {
                CXMyBenefitReleaseViewController *releaseControl = [[CXMyBenefitReleaseViewController alloc] init];
                releaseControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:releaseControl animated:YES];

            }
                break;
            case 3:
            {
                CXMyBuybackViewController *releaseControl = [[CXMyBuybackViewController alloc] init];
                releaseControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:releaseControl animated:YES];
                
            }
                break;
            case 4:
            {
                CXMyBenefitReleaseViewController *releaseControl = [[CXMyBenefitReleaseViewController alloc] init];
                releaseControl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:releaseControl animated:YES];
                
            }
                break;
            default:
                break;
        }
    
}


@end
