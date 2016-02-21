//
//  CXServiceProvisionViewController.m
//  xProject
//
//  Created by chx on 15/5/5.
//  Copyright (c) 2015年 ruisk. All rights reserved.
//

#import "CXServiceProvisionViewController.h"

@interface CXServiceProvisionViewController ()

@end

@implementation CXServiceProvisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = StringServiceAndProtocol;
    
    CGRect bound = self.view.frame;
    bound.origin.y=0;
    bound.size.height -= kViewEndSizeHeight;
//    bound.size.height -=  kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin;
//    bound.origin.y = (kIsIOS7OrLater ? kNavAndStatusBarHeight + kDefaultMargin : kDefaultMargin);
    
    UIScrollView* scrollView = [ [UIScrollView alloc ] initWithFrame:bound ];
    scrollView.backgroundColor = kColorWhite;
    [self.view addSubview:scrollView];
    
    CGRect infoRect = bound;
    infoRect.origin.y = 0;
    UIView *infoView = [[UIView alloc] initWithFrame:infoRect];
    infoView.backgroundColor = kColorWhite;
    [scrollView addSubview:infoView];
    
    NSString *strProvision = StringUserServiceProvision;
    CGSize size = [strProvision getSizeWithWidth:kScreenWidth - 2 * kDefaultMargin fontSize:kMiddleTextFontSize];
    
    UILabel *provisionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kScreenWidth - 2 * kDefaultMargin, size.height + 10)];
    provisionLabel.font = kMiddleTextFont;
    provisionLabel.textColor = kTextColor;
    provisionLabel.text =  strProvision;
    provisionLabel.backgroundColor = kColorClear;
    provisionLabel.numberOfLines = 0;
    provisionLabel.textAlignment = NSTextAlignmentLeft;
//    provisionLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:provisionLabel];
    
    infoRect.size.height = size.height + 2 * kDefaultMargin;
    infoView.frame = infoRect;
    scrollView.contentSize = infoView.frame.size;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
