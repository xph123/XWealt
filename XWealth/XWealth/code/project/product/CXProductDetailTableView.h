//
//  CXProductDetailTableView.h
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXProductDetailTableView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) CXProductModel *productModel;
@property (nonatomic, strong) NSArray *sourceData;
@property (nonatomic, strong) NSArray *sectionData;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isExternInfoShow;
@property (nonatomic ,assign) BOOL isDownloadShow;

@property(nonatomic, strong)UINavigationController *navigationController;

@property (nonatomic, copy) ActionClickBlk contractBtnBlk;
@property (nonatomic, copy) ActionClickBlk instructionsBtnBlk;
@property (nonatomic, copy) ActionClickBlk dataBtnBlk;
@property (nonatomic, copy) ActionClickBlk reportBtnBlk;

- (void)configData:(NSArray *)sourceDatas andSectionData:(NSArray*)sectionData andProduct:(CXProductModel *)productModel;
@end
