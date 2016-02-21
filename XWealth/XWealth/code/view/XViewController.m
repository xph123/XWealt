//
//  XViewController.m
//  Link
//
//  Created by yi.chen on 14-5-29.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XViewController.h"
#import "Constants.h"

@interface XViewController ()

@end

@implementation XViewController

- (void)dealloc
{
    XLog(@"%s",__FUNCTION__);
//    [_dataCenter cancelRequest];
//    _dataCenter.delegate = nil;
//    _dataCenter = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
//        _dataCenter = [[XDataCenter alloc] init];
//        _dataCenter.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (self.navigationController.viewControllers.count == 1) {
//        XLog(@"根控制器");
//    }
//    else if (self.navigationController.viewControllers.count > 1){
//        XLog(@"非根控制器");
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backBtn.frame = CGRectMake(0, 0, 30, 30);
//        [backBtn setBackgroundImage:IMAGE(@"nav_back") forState:UIControlStateNormal];
//        [backBtn setBackgroundImage:IMAGE(@"nav_back_press") forState:UIControlStateHighlighted];
//        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -12;
//        self.navigationItem.leftBarButtonItems = @[negativeSeperator,backItem];
//    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardDidShow
{
    //DLog(@"keyboardDidShow");
}

- (void)keyboardDidHide
{
    //DLog(@"keyboardDidHide");
}

- (void)didReceiveMemoryWarning
{
    XLog(@"%s",__FUNCTION__);
    [super didReceiveMemoryWarning];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
//        BOOL isLoaded = [self isViewLoaded];
//        if (isLoaded && self.view.window == nil) {
//            [self.view removeFromSuperview];
//            self.view = nil;
//        }
//    }

    // Dispose of any resources that can be recreated.
}

- (void) ShowProgressHUB:(NSString*)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg; //StringPrompt;
//    hud.detailsLabelText = msg;
    hud.yOffset = -50;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void) ShowProgressHUB:(NSString*)title andMsg:(NSString*)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kCurrentKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = msg;
    hud.yOffset = -50;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

//- (void)XDataCenter:(XDataCenter*)_dataCenter loadingFinishedWithDataString:(NSString *)dataString userInfo:(NSDictionary *)userInfo
//{
//
//}
//
//- (void)XDataCenterLoadDataFailed:(XDataCenter*)_dataCenter withUserInfo:(NSDictionary *)userInfo
//{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
