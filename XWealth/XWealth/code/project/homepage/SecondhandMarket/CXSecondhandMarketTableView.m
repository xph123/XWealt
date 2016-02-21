//
//  CXSecondhandMarketTableView.m
//  XWealth
//
//  Created by gsycf on 15/12/17.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSecondhandMarketTableView.h"
#import "CXBuybackTrustCenterCell.h"
#import "CXBuybackTrustCenterCellFrame.h"
#import "CXTrustTransferCenterCell.h"
#import "CXTrustTransferCenterCellFrame.h"
#import "CXXintuobaoCell.h"
#import "CXXintuobaoCellFrame.h"
#import "CXSecondhandMarketBannerCell.h"
#import "CXSecondhandMarketBannerCellFrame.h"
#import "CXBuybackTrustCenterViewController.h"
#import "CXTrustTransferCenterViewController.h"
#import "CXXintuobaoViewController.h"
@implementation CXSecondhandMarketTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.isHaveSection=NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect textFrame = self.bounds;
        textFrame.origin.x += kDefaultMargin;
        textFrame.size.width -= 2 * kDefaultMargin;
        textFrame.size.height = kLabelHeight;
        
        UIButton * promptButton = [[UIButton alloc] initWithFrame:textFrame];
        [promptButton setBackgroundColor:kColorClear];
        [promptButton setTitle: @"抱歉，没有资讯！" forState: UIControlStateNormal];
        promptButton.titleLabel.font = kLargeTextFont;
        [promptButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [promptButton setImage:[UIImage imageNamed:@"error_prompt"] forState:UIControlStateNormal];
        [promptButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        promptButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: promptButton];
        self.promptView = promptButton;
        
        CGRect tableVFrame = self.bounds;
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
    return [_sourceDatas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return 1;
    }
    return [_sourceDatas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *nilCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nilCell == nil) {
        nilCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_sourceDatas!=nil&&_sourceDatas.count>0) {
        switch (indexPath.section) {
            case 0:
            {
                NSString *releaseCellIdentifier = @"buyBackCellIdentifier";
                CXBuybackTrustCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:releaseCellIdentifier];
                if (cell == nil) {
                    cell = [[CXBuybackTrustCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:releaseCellIdentifier];
                }
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    cell.buyBackModel = [self.sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
            }
                break;
            case 1:
            {
                NSString *releaseCellIdentifier = @"trustTransferCellIdentifier";
                CXTrustTransferCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:releaseCellIdentifier];
                if (cell == nil) {
                    cell = [[CXTrustTransferCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:releaseCellIdentifier];
                }
               if ([_sourceDatas[indexPath.section] count]!=0){
                    cell.BenefitModel = [self.sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
                
                
            }
                break;
            case 2:
            {
                NSString *productCellIdentifier = @"productCellIdentifier";
                CXSecondhandMarketBannerCell *cell = [[CXSecondhandMarketBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    if ([_sourceDatas[indexPath.section] count]!=[cell.arrData count]) {
                        cell.navigationController=self.navigationController;
                        [cell addData:_sourceDatas[indexPath.section]];
                        return cell;
                    }
                    else
                    {
                        for (int i=0; i<[_sourceDatas[indexPath.section] count]; i++) {
                            if (_sourceDatas[indexPath.section][i]!=cell.arrData[i]) {
                                [cell.scrollView removeFromSuperview];
                                [cell.pageControl removeFromSuperview];
                                cell.navigationController=self.navigationController;
                                [cell addData:_sourceDatas[indexPath.section]];
                                return cell;
                            }
                        }
                    }
                }
                return cell;

                
            }
                break;
            case 3:
            {
                static NSString *productCellIdentifier = @"xintuobaoCell";
                CXXintuobaoCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
                if (cell == nil) {
                    cell = [[CXXintuobaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                }
                if ([_sourceDatas[indexPath.section] count]!=0)
                {
                    CXXintuoBaoModel *model = [self.sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.productModel = model;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                    return cell;
                
            }
                break;
            default:
                break;
        }
    }
    return nilCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas!=nil&&_sourceDatas.count>0) {
    if ([_sourceDatas[indexPath.section] count]!=0) {
        switch (indexPath.section) {
            case 0:
            {
                CXBuyBackModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXBuybackTrustCenterCellFrame *cellFrame = [[CXBuybackTrustCenterCellFrame alloc] initWithDataModel:model];
                CGFloat cellHight=[cellFrame cellHeight]+kDefaultMargin;
                return cellHight;

            }
                break;
            case 1:
            {
                CXBenefitModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXTrustTransferCenterCellFrame *cellFrame = [[CXTrustTransferCenterCellFrame alloc] initWithDataModel:model];
                return [cellFrame cellHeight]+kDefaultMargin;
            }
                break;
            case 2:
            {
                CXSecondhandMarketBannerCellFrame *cellFrame = [[CXSecondhandMarketBannerCellFrame alloc]init];
                return [cellFrame cellHeight];

            }
                break;
            case 3:
            {
                CXXintuoBaoModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXXintuobaoCellFrame *cellFrame = [[CXXintuobaoCellFrame alloc] initWithDataModel:model];
                return [cellFrame cellHeight];

            }
                break;
                default:
                break;
        }
        
    }
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    if (self.isHaveSection)
    {
        if (_sourceDatas!=nil&&_sourceDatas.count>0) {
        switch (section) {
            case 0:
            {
                if ([self.sourceDatas[section] count]>0&&self.sourceDatas[section]!=nil)
                {
                    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight+kDefaultMargin+kDefaultMargin)];
                    customView.backgroundColor = kControlBgColor;
                    
                    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
                    flagView.backgroundColor = [UIColor whiteColor];
                    
                    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, 13, 3, kIconSmallHeight-1)];
                    leftView.backgroundColor = [UIColor redColor];
                    [flagView addSubview:leftView];
                    
                    
                    //加框
                    CGFloat x = 0;
                    CGFloat y = kDefaultMargin;
                    CGFloat width = kScreenWidth;
                    CGFloat height = kFunctionBarHeight - 0.5;
                    CGRect rect = CGRectMake(x, y, width, height);
                    flagView.frame = rect;
                    [customView addSubview:flagView];
                    
                    
                    rect.origin.x=kMiddleMargin;
                    rect.origin.y=0;
                    rect.size.width=kLabelWidth;
                    UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
                    titleLable.text = @"求购专区";
                    titleLable.font = kMiddleTextFontBold;
                    titleLable.textColor = [UIColor grayColor];
                    titleLable.numberOfLines = 1;
                    [flagView addSubview:titleLable];
                    
                    UIImageView *titleLogo=[[UIImageView alloc]initWithFrame:CGRectMake(kMiddleMargin+[titleLable.text length]*15, 12, 15, 15)];
                    titleLogo.image=[UIImage imageNamed:@"Secondhand_cell_logo"];
                    [flagView addSubview:titleLogo];
                    
                    rect.origin.x=kScreenWidth-kLabelWidth-kDefaultMargin;
                    UILabel *moreLable=[[UILabel alloc]initWithFrame:rect];
                    moreLable.text=@"更多>";
                    moreLable.textColor=kAssistTextColor;
                    moreLable.textAlignment=NSTextAlignmentRight;
                    moreLable.font=kSmallTextFont;
                    UITapGestureRecognizer *moreTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buybackTrustClick)];
                    [moreLable addGestureRecognizer:moreTap];
                    moreLable.userInteractionEnabled=YES;
                    [flagView addSubview:moreLable];
                    
                    return customView;
                }
            }
                break;
            case 1:
            {
                if ([self.sourceDatas[section] count]>0&&self.sourceDatas[section]!=nil)
                {
                    
                    
                    
                    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight+kDefaultMargin)];
                    customView.backgroundColor = kControlBgColor;
                    
                    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
                    flagView.backgroundColor = [UIColor whiteColor];
                    //加框
                    CGFloat x = 0;
                    CGFloat y = 0;
                    CGFloat width = kScreenWidth;
                    CGFloat height = kFunctionBarHeight - 0.5;
                    CGRect rect = CGRectMake(x, y, width, height);
                    flagView.frame = rect;
                    [customView addSubview:flagView];
                    
                    
                    
                    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, 13, 3, kIconSmallHeight-1)];
                    leftView.backgroundColor = [UIColor redColor];
                    [flagView addSubview:leftView];
                    
                    
                    
                    
                    
                    rect.origin.x=kMiddleMargin;
                    rect.origin.y=0;
                    
                    UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
                    titleLable.text = @"百万专区";
                    titleLable.font = kMiddleTextFontBold;
                    titleLable.textColor = [UIColor grayColor];
                    titleLable.numberOfLines = 1;
                    [flagView addSubview:titleLable];
                    
                    rect.size.width=kLabelWidth;
                    UIImageView *titleLogo=[[UIImageView alloc]initWithFrame:CGRectMake(kMiddleMargin+[titleLable.text length]*15, 12, 15, 15)];
                    titleLogo.image=[UIImage imageNamed:@"Secondhand_cell_logo"];
                    [flagView addSubview:titleLogo];
                   
                    rect.origin.x=kScreenWidth-kLabelWidth-kDefaultMargin;
                    UILabel *moreLable=[[UILabel alloc]initWithFrame:rect];
                    moreLable.text=@"更多>";
                    moreLable.textColor=kAssistTextColor;
                    moreLable.textAlignment=NSTextAlignmentRight;
                    moreLable.font=kSmallTextFont;
                    UITapGestureRecognizer *moreTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(trustTransferClick)];
                    [moreLable addGestureRecognizer:moreTap];
                    moreLable.userInteractionEnabled=YES;
                    [flagView addSubview:moreLable];

                    
                    return customView;
                }
            }
                break;
            case 2:
            {
                if ([self.sourceDatas[section] count]>0&&self.sourceDatas[section]!=nil)
                {
                    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight)];
                    customView.backgroundColor = kControlBgColor;
                    
                    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
                    flagView.backgroundColor = [UIColor whiteColor];
                    
                    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, 13, 3, kIconSmallHeight-1)];
                    leftView.backgroundColor = [UIColor redColor];
                    [flagView addSubview:leftView];
                    
                    
                    //加框
                    CGFloat x = 0;
                    CGFloat y = 0;
                    CGFloat width = kScreenWidth;
                    CGFloat height = kFunctionBarHeight - 0.5;
                    CGRect rect = CGRectMake(x, y, width, height);
                    flagView.frame = rect;
                    [customView addSubview:flagView];
                    
                    
                    rect.origin.x=kMiddleMargin;
                    rect.origin.y=0;
                  
                    UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
                    titleLable.text = @"二十至百万专区";
                    titleLable.font = kMiddleTextFontBold;
                    titleLable.textColor = [UIColor grayColor];
                    titleLable.numberOfLines = 1;
                    [flagView addSubview:titleLable];
                    
                      rect.size.width=kLabelWidth;
                    UIImageView *titleLogo=[[UIImageView alloc]initWithFrame:CGRectMake(kMiddleMargin+[titleLable.text length]*15, 12, 15, 15)];
                    titleLogo.image=[UIImage imageNamed:@"Secondhand_cell_logo"];
                    [flagView addSubview:titleLogo];
                    
                    rect.origin.x=kScreenWidth-kLabelWidth-kDefaultMargin;
                    UILabel *moreLable=[[UILabel alloc]initWithFrame:rect];
                    moreLable.text=@"更多>";
                    moreLable.textColor=kAssistTextColor;
                    moreLable.textAlignment=NSTextAlignmentRight;
                    moreLable.font=kSmallTextFont;
                    UITapGestureRecognizer *moreTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productClick)];
                    [moreLable addGestureRecognizer:moreTap];
                    moreLable.userInteractionEnabled=YES;
                    [flagView addSubview:moreLable];

                    
                    return customView;
                }
            }
                break;
            case 3:
            {
                if ([self.sourceDatas[section] count]>0&&self.sourceDatas[section]!=nil)
                {
                    
                    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight+kDefaultMargin)];
                    customView.backgroundColor = kControlBgColor;
                    
                    UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
                    flagView.backgroundColor = [UIColor whiteColor];
                    
                    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, 13, 3, kIconSmallHeight-1)];
                    leftView.backgroundColor = [UIColor redColor];
                    [flagView addSubview:leftView];
                    
                    
                    //加框
                    CGFloat x = 0;
                    CGFloat y = 0;
                    CGFloat width = kScreenWidth;
                    CGFloat height = kFunctionBarHeight - 0.5;
                    CGRect rect = CGRectMake(x, y, width, height);
                    flagView.frame = rect;
                    [customView addSubview:flagView];
                    
                    
                    rect.origin.x=kMiddleMargin;
                    rect.origin.y=0;
                    UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
                    titleLable.text = @"十元专区";
                    titleLable.font = kMiddleTextFontBold;
                    titleLable.textColor = [UIColor grayColor];
                    titleLable.numberOfLines = 1;
                    [flagView addSubview:titleLable];
                    
                      rect.size.width=kLabelWidth;
                    UIImageView *titleLogo=[[UIImageView alloc]initWithFrame:CGRectMake(kMiddleMargin+[titleLable.text length]*15, 12, 15, 15)];
                    titleLogo.image=[UIImage imageNamed:@"Secondhand_cell_logo"];
                    [flagView addSubview:titleLogo];
                    
                    rect.origin.x=kScreenWidth-kLabelWidth-kDefaultMargin;
                    UILabel *moreLable=[[UILabel alloc]initWithFrame:rect];
                    moreLable.text=@"更多>";
                    moreLable.textColor=kAssistTextColor;
                    moreLable.textAlignment=NSTextAlignmentRight;
                    moreLable.font=kSmallTextFont;
                    UITapGestureRecognizer *moreTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xintuobaoClick)];
                    [moreLable addGestureRecognizer:moreTap];
                    moreLable.userInteractionEnabled=YES;
                    [flagView addSubview:moreLable];

                    
                    return customView;
                }
            }
                break;
            default:
                break;
        }
        
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_sourceDatas!=nil&&_sourceDatas.count>0) {
    if (self.isHaveSection)
    {
        if ([self.sourceDatas[section] count]>0&&self.sourceDatas[section]!=nil) {
            if (section==0) {
                return kFunctionBarHeight+kDefaultMargin*2;
            }
            else if (section==3)
            {
                return kFunctionBarHeight+kSmallMargin;
            }
                return kFunctionBarHeight+kDefaultMargin;
        }
    }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
    }
    else
    {
        [self.delegate didSelectItemAtIndex:indexPath];
    }
}


#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    if ([self.sourceDatas count] == 0)
    {
        self.promptView.hidden = NO;
        self.tableView.hidden = YES;
    }
    else
    {
        self.promptView.hidden = YES;
        self.tableView.hidden = NO;
        
        [self.tableView reloadData];
    }
}

- (void) configDataHaveHeaderView:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    // 有headerview 显示headerview ，不显示没有任务提醒
    self.promptView.hidden = YES;
    self.tableView.hidden = NO;
    
    [self.tableView reloadData];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate tableViewDidScroll:scrollView];
}
#pragma mark -privaClick
-(void)buybackTrustClick
{
    __unsafe_unretained CXSecondhandMarketTableView *weak_self = self;
    if (weak_self.firstBtnBlk) {
        weak_self.firstBtnBlk();
    }
}
-(void)trustTransferClick
{
    __unsafe_unretained CXSecondhandMarketTableView *weak_self = self;
    if (weak_self.secondBtnBlk) {
        weak_self.secondBtnBlk();
    }
}
-(void)productClick
{
    __unsafe_unretained CXSecondhandMarketTableView *weak_self = self;
    if (weak_self.thirdBtnBlk) {
        weak_self.thirdBtnBlk();
    }
}
-(void)xintuobaoClick
{
    __unsafe_unretained CXSecondhandMarketTableView *weak_self = self;
    if (weak_self.fourBtnBlk) {
        weak_self.fourBtnBlk();
    }
}
@end
