//
//  CXMeViewController.h
//
//  我的主界面
//  Created by chx on 14-9-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMeHeaderView.h"
#import "CXBannerModel.h"
#import "UDCustomNavigation.h"
typedef NS_ENUM(NSInteger, ChangeImageType) {
    ChangeHeaderBgImageType  = 0,
    ChangeHeadImageType  = 1
};

@interface CXMeViewController : XViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CXMeHeaderView *headView;

@property (nonatomic, strong) NSArray *oneDatas;    //我是理财师数据
@property (nonatomic, strong) NSArray *twoDatas;    //我的专属理财师的数据
@property (nonatomic, strong) NSArray *thereDatas;   //我的现金券的数据
@property (nonatomic, strong) NSArray *fourDatas;   //多个的数据
@property (nonatomic, strong) NSArray *fiveDatas;   //使用指南
@property (nonatomic, strong) NSArray *sixDatas;   //设置


//@property (nonatomic, strong) NSArray *systemDatas;

@property (nonatomic, strong) NSArray *oneImageDatas;
@property (nonatomic, strong) NSArray *twoImageDatas;
@property (nonatomic, strong) NSArray *thereImageDatas;
@property (nonatomic, strong) NSArray *fourImageDatas;
@property (nonatomic, strong) NSArray *fiveImageDatas;
@property (nonatomic, strong) NSArray *sixImageDatas;

@property (nonatomic, strong) CXXtbAccountModel *accountModel;

@property (nonatomic, assign) ChangeImageType changeImagetype;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end
