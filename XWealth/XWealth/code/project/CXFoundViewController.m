//
//  CXFoundViewController.m
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXFoundViewController.h"
#import "CXTrustTransferCenterViewController.h"
#import "CXBuybackTrustCenterViewController.h"
#import "CXXintuobaoViewController.h"
#import "CXClassroomViewController.h"
#import "CXInformationViewController.h"
#import "CXPopularActivityViewController.h"
#import "CXMyTrackViewController.h"
#import "CXSecondhandMarketViewController.h"
@interface CXFoundViewController ()

@end

@implementation CXFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=kControlBgColor;
    [self initLeftBarButton];
    
    _oneDatas=[[NSArray alloc]initWithObjects:StringTwoMarket,nil];
    _twoDatas=[[NSArray alloc]initWithObjects:StringInformation,StringClassroom, nil];
    _thereDatas=[[NSArray alloc]initWithObjects:StringMyTrack, nil];
    _fourDatas=[[NSArray alloc]initWithObjects:StringPopularActivity, nil];
    
    _oneImageDatas=[[NSArray alloc]initWithObjects:
                    @"found_secondar",nil];
    _twoImageDatas=[[NSArray alloc]initWithObjects:
                    @"found_information",
                    @"found_classroom",nil];
    _thereImageDatas=[[NSArray alloc]initWithObjects:@"found_myTrack", nil];
    _fourImageDatas=[[NSArray alloc]initWithObjects:@"found_popularActivity", nil];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.origin.y=0;
    tableVFrame.size.height -=  kTabBarHeight;
    self.tableView=[[UITableView alloc]initWithFrame:tableVFrame style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=kControlBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kMiddleMargin)];
    headView.backgroundColor=kControlBgColor;
    self.tableView.tableHeaderView=headView;
}
- (void) initLeftBarButton
{
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(0, 0, 20, 20);
    [logoImage setImage:IMAGE(@"nav_logo")];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:logoImage];
    [self.navigationItem setLeftBarButtonItems:@[leftBar]];
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofRows = 0;
    switch (section) {
        case 0:
        {
            numberofRows=self.oneDatas.count;
        }
            break;
        case 1:
        {
             numberofRows=self.twoDatas.count;
        }
            break;
        case 2:
        {
             numberofRows=self.thereDatas.count;
        }
            break;
        case 3:
        {
             numberofRows=self.fourDatas.count;
        }
            break;
        default:
            break;
    }
    return numberofRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXFoundCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[CXFoundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                cell.uplineBool=NO;
            }
            if (indexPath.row==_oneDatas.count-1) {
                
                cell.downlineBool=NO;
            }
            [cell setTitle:_oneDatas[indexPath.row] andImage:_oneImageDatas[indexPath.row]];

 
        }
            break;
        case 1:
        {
            if (indexPath.row==0) {
                cell.uplineBool=NO;
            }
            if (indexPath.row==_twoDatas.count-1) {
                
                cell.downlineBool=NO;
            }

             [cell setTitle:_twoDatas[indexPath.row] andImage:_twoImageDatas[indexPath.row]];

        }
            break;
        case 2:
        {
            if (indexPath.row==0) {
                cell.uplineBool=NO;
            }
            if (indexPath.row==_thereDatas.count-1) {
                
                cell.downlineBool=NO;
            }

             [cell setTitle:_thereDatas[indexPath.row] andImage:_thereImageDatas[indexPath.row]];

        }
            break;
        case 3:
        {
            if (indexPath.row==0) {
                cell.uplineBool=NO;
            }
            if (indexPath.row==_fourDatas.count-1) {
                
                cell.downlineBool=NO;
            }

             [cell setTitle:_fourDatas[indexPath.row] andImage:_fourImageDatas[indexPath.row]];

        }
            break;
        default:
            break;
    }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat  height=0;
    if (section>0) {
        height = kDefaultMargin;
    }
    
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExtMenuHeight;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kDefaultMargin)];
    headerView.backgroundColor=kControlBgColor;
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                //二手信托
                CXSecondhandMarketViewController* secondhandMarketViewController=[[CXSecondhandMarketViewController alloc] init];
                secondhandMarketViewController.hidesBottomBarWhenPushed = YES;
                [ self.navigationController pushViewController:secondhandMarketViewController animated:YES];



                
            }
                break;
//            case 1:
//            {   //信托转让
//                CXTrustTransferCenterViewController* TrustTransferCenterController=[[CXTrustTransferCenterViewController alloc] init];
//                TrustTransferCenterController.hidesBottomBarWhenPushed = YES;
//                [ self.navigationController pushViewController:TrustTransferCenterController animated:YES];
//                
//            }
//                break;
//            case 2:
//            {
//                if (kAppDelegate.hasLogined == NO)
//                {
//                    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
//                    loginViewController.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:loginViewController animated:YES];
//                    return;
//                }
//                CXXintuobaoViewController* trustController=[[CXXintuobaoViewController alloc] init];
//                trustController.hidesBottomBarWhenPushed = YES;
//                [ self.navigationController pushViewController:trustController animated:YES];
//            }
//                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                CXInformationViewController* InformationViewController=[[CXInformationViewController alloc] init];
                InformationViewController.hidesBottomBarWhenPushed = YES;
                [ self.navigationController pushViewController:InformationViewController animated:YES];

            }
                break;
            case 1:
            {
                CXClassroomViewController* ClassroomViewController=[[CXClassroomViewController alloc] init];
                ClassroomViewController.hidesBottomBarWhenPushed = YES;
                [ self.navigationController pushViewController:ClassroomViewController animated:YES];

            }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
            {
                if (kAppDelegate.hasLogined == NO)
                {
                    
                    CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
                    loginViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:loginViewController animated:YES];
                    return;
                }

                //理财轨迹
                CXMyTrackViewController *myTrackcontroller=[[CXMyTrackViewController alloc]init];
                myTrackcontroller.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:myTrackcontroller animated:YES];

                           }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            //热门活动
            CXPopularActivityViewController *popularActivityControl = [[CXPopularActivityViewController alloc] init];
            popularActivityControl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:popularActivityControl animated:YES];

        }
        
    }

}

@end
