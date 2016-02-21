//
//  CXGroupInfoView.h
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXGroupInfoViewDelegate <NSObject>

- (void) changeGroupLogo;
- (void) changeGroupName;
- (void) changeGroupDesc;

@end

@interface CXGroupInfoView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionList1;
@property (strong, nonatomic) NSArray *sectionList2;
@property (nonatomic, strong) CXGroupModel *groupModel;
@property (nonatomic, strong) CXUserModel *managerModel;
@property (nonatomic, strong) id<CXGroupInfoViewDelegate> infoDelegate;

- (void)configData:(CXGroupModel *)groupModel andManager:(CXUserModel*)managerModel;

@end
