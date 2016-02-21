//
//  CXFoundViewController.h
//  XWealth
//
//  Created by gsycf on 15/11/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXFoundCell.h"
#import "CXLoginViewController.h"
@interface CXFoundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic, strong)NSArray *oneDatas;
@property(nonatomic, strong)NSArray *twoDatas;
@property(nonatomic, strong)NSArray *thereDatas;
@property(nonatomic, strong)NSArray *fourDatas;

@property(nonatomic, strong)NSArray *oneImageDatas;
@property(nonatomic, strong)NSArray *twoImageDatas;
@property(nonatomic, strong)NSArray *thereImageDatas;
@property(nonatomic, strong)NSArray *fourImageDatas;


@property(nonatomic, strong)UITableView *tableView;
@end
