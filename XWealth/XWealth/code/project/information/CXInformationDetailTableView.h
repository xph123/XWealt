//
//  CXInformationDetailTableView.h
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXInformationDetailTableView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CXInformationModel *informationModel;

@end
