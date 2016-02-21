//
//  CXProductDetailTableView.m
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductDetailTableView.h"
#import "CXProductDetailCell.h"
#import "CXProductDetailCellFrame.h"
#import "CXLoginViewController.h"

#define DOWNLOAD_VIEW_HEIGHT    (kButtonHeight * 2 + kDefaultMargin * 3)

@implementation CXProductDetailTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isDownloadShow = NO;
        self.isExternInfoShow = NO;
        
        CGRect tableVFrame = self.bounds;
        //tableView
        self.tableView = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kControlBgColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if (section == 2)
    {
        if (self.isDownloadShow == YES)
        {
            count = 1;
        }
        else
        {
            count = 0;
        }
        
    }
    else if (section == 1)
    {
        if (self.isExternInfoShow == YES)
        {
            NSArray *array = [self.sourceData objectAtIndex:section];
            count = [array count];
        }
        else
        {
            count = 0;
        }
    }
    else
    {
        NSArray *array = [self.sourceData objectAtIndex:section];
        count = [array count];
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        NSString *downloadCellIdentifier = @"downloadCellIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:downloadCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:downloadCellIdentifier];
        }
        
        cell.backgroundColor = kControlBgColor;
        
        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DOWNLOAD_VIEW_HEIGHT)];
        cellView.backgroundColor = kColorWhite;
        
        CGFloat btnWidth = (kScreenWidth - 2 * kDefaultMargin - 30)/2;
        //  第一行
        NSString *contractStr = StringContract;
        if ([self.productModel.contract isEmpty])
        {
            contractStr = [contractStr stringByAppendingString:@"（尚无）"];
        }
            
        UIButton * contractButton = [[UIButton alloc] initWithFrame:CGRectMake(10+kDefaultMargin, kDefaultMargin, btnWidth, kButtonHeight)];
        contractButton.layer.masksToBounds = YES;
        contractButton.layer.cornerRadius = kRadius;
        contractButton.layer.borderColor = kLineColor.CGColor;
        contractButton.layer.borderWidth = 1;
        [contractButton setBackgroundColor:[UIColor clearColor]];
        [contractButton setTitle: contractStr forState: UIControlStateNormal];
        contractButton.titleLabel.font = kMiddleTextFont;
        [contractButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [contractButton addTarget:self action:@selector(contractBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview: contractButton];
 
        
        NSString *instructionsStr = StringSpecification;
        if ([self.productModel.specification isEmpty])
        {
            instructionsStr = [instructionsStr stringByAppendingString:@"（尚无）"];
        }
        UIButton * instructionsBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + btnWidth+kDefaultMargin, kDefaultMargin, btnWidth, kButtonHeight)];
        instructionsBtn.layer.masksToBounds = YES;
        instructionsBtn.layer.cornerRadius = kRadius;
        instructionsBtn.layer.borderColor = kLineColor.CGColor;
        instructionsBtn.layer.borderWidth = 1;
        [instructionsBtn setBackgroundColor:[UIColor clearColor]];
        [instructionsBtn setTitle: instructionsStr forState: UIControlStateNormal];
        instructionsBtn.titleLabel.font = kMiddleTextFont;
        [instructionsBtn setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [instructionsBtn addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview: instructionsBtn];
        
        // 第二行
        NSString *dataStr = StringMaterial;
        if ([self.productModel.material isEmpty])
        {
            dataStr = [dataStr stringByAppendingString:@"（尚无）"];
        }
        UIButton * dataButton = [[UIButton alloc] initWithFrame:CGRectMake(10+kDefaultMargin, kDefaultMargin * 2 + kButtonHeight, btnWidth, kButtonHeight)];
        dataButton.layer.masksToBounds = YES;
        dataButton.layer.cornerRadius = kRadius;
        dataButton.layer.borderColor = kLineColor.CGColor;
        dataButton.layer.borderWidth = 1;
        [dataButton setBackgroundColor:[UIColor clearColor]];
        [dataButton setTitle: dataStr forState: UIControlStateNormal];
        dataButton.titleLabel.font = kMiddleTextFont;
        [dataButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [dataButton addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview: dataButton];
        
        NSString *surveyStr = StringSurvey;
        if ([self.productModel.survey isEmpty])
        {
            surveyStr = [surveyStr stringByAppendingString:@"（尚无）"];
        }
        UIButton * reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + btnWidth+kDefaultMargin, kDefaultMargin * 2 + kButtonHeight, btnWidth, kButtonHeight)];
        reportBtn.layer.masksToBounds = YES;
        reportBtn.layer.cornerRadius = kRadius;
        reportBtn.layer.borderColor = kLineColor.CGColor;
        reportBtn.layer.borderWidth = 1;
        [reportBtn setBackgroundColor:[UIColor clearColor]];
        [reportBtn setTitle: surveyStr forState: UIControlStateNormal];
        reportBtn.titleLabel.font = kMiddleTextFont;
        [reportBtn setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [reportBtn addTarget:self action:@selector(reportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview: reportBtn];

        [cell addSubview:cellView];
        
        //设置Cell选中时的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    else
    {
        NSString *ProductDetailCellIdentifier = @"ProductDetailCellIdentifier";
        CXProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductDetailCellIdentifier];
        if(!cell)
        {
            cell = [[CXProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailCellIdentifier];
        }
        
        
        CXTitleValueModel * model1 = [[_sourceData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        
        [cell setValue1:model1 andValue2:nil];
        
        //设置Cell选中时的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 2)
    {
        height = DOWNLOAD_VIEW_HEIGHT;
    }
    else
    {
        CXTitleValueModel * model1 = [[_sourceData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        CXProductDetailCellFrame *layout = [[CXProductDetailCellFrame alloc] initWithDataModel:model1 andValue2:nil andCol:1];
        height = [layout cellHeight];
    }
    
    return height;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [_sectionData objectAtIndex:section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight + kDefaultMargin)];
    customView.backgroundColor = kControlBgColor;

    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
    flagView.backgroundColor = [UIColor whiteColor];

    //加框
    CGFloat x = 0;
    CGFloat y = kDefaultMargin;
    CGFloat width = kScreenWidth ;
    CGFloat height = kFunctionBarHeight - 1;
    CGRect rect = CGRectMake(x, y, width, height);
    flagView.frame = rect;
    [customView addSubview:flagView];

    rect.origin.x = kDefaultMargin;
    rect.origin.y = 0;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
    titleLable.text = [_sectionData objectAtIndex:section];
    titleLable.font = kLargeTextFont;
    titleLable.textColor = [UIColor grayColor];
    titleLable.numberOfLines = 1;
    [flagView addSubview:titleLable];
    
    if (section == 1)
    {
        // 功能按钮
        UIImageView *functionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - kIconMiddleWidth, 0, kIconMiddleWidth, height)];
        functionImageView.contentMode = UIViewContentModeCenter;
        functionImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(externFunctionButtonClickAction:)];
    
        if (self.isExternInfoShow == NO)
        {
            [functionImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
        }
        else
        {
            [functionImageView setImage:[UIImage imageNamed:@"icon_drop_up"]];
        }
        
        [functionImageView addGestureRecognizer:singleTap];
        [flagView addSubview: functionImageView];
        
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = rect;
        actionBtn.backgroundColor = kColorClear;
        [actionBtn addTarget:self action:@selector(externFunctionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [flagView addSubview:actionBtn];

    }
    else if (section == 2)
    {
        // 功能按钮
        UIImageView *functionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - kIconMiddleWidth, 0, kIconMiddleWidth, height)];
        functionImageView.contentMode = UIViewContentModeCenter;
        functionImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downloadFunctionButtonClickAction:)];
        
        if (self.isDownloadShow == NO)
        {
            [functionImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
        }
        else
        {
            [functionImageView setImage:[UIImage imageNamed:@"icon_drop_up"]];
        }
 
        [functionImageView addGestureRecognizer:singleTap];
        [flagView addSubview: functionImageView];
        
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = rect;
        actionBtn.backgroundColor = kColorClear;
        [actionBtn addTarget:self action:@selector(downloadFunctionButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [flagView addSubview:actionBtn];
    }

    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kFunctionBarHeight + kDefaultMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - data

- (void)configData:(NSArray *)sourceDatas andSectionData:(NSArray*)sectionData andProduct:(CXProductModel *)productModel
{
    _sectionData = sectionData;
    _sourceData = sourceDatas;
    _productModel = productModel;
    
    [self.tableView reloadData];
    
}

#pragma mark - private functions

- (void) externFunctionButtonClickAction:(id)sender
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }

//    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
//    NSLog(@"%d",[singleTap view].tag);

    self.isExternInfoShow = !self.isExternInfoShow;
    [self.tableView reloadData];
}

- (void) downloadFunctionButtonClickAction:(id)sender
{
    if (kAppDelegate.hasLogined == NO)
    {
        CXLoginViewController *loginViewController = [[CXLoginViewController alloc] init];
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }

    
    self.isDownloadShow = !self.isDownloadShow;
    [self.tableView reloadData];
    
    
    if (self.isDownloadShow == YES)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView  scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
    }

}

- (void)contractBtnClick:(UIButton *)button
{
    if (self.contractBtnBlk) {
        self.contractBtnBlk();
    }
}

- (void)instructionsBtnClick:(UIButton *)button
{
    if (self.instructionsBtnBlk) {
        self.instructionsBtnBlk();
    }
}


- (void)dataBtnClick:(UIButton *)button
{
    if (self.dataBtnBlk) {
        self.dataBtnBlk();
    }
}


- (void)reportBtnClick:(UIButton *)button
{
    if (self.reportBtnBlk) {
        self.reportBtnBlk();
    }
}


@end
