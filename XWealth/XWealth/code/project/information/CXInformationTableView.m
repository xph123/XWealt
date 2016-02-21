//
//  CXInformationTableView.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationTableView.h"
#import "CXInformationCellFrame.h"
#import "CXInformationCell.h"
#import "CXInformationTwoCell.h"
#import "CXInformationthreeCell.h"
#import "CXInformationTwoCellFrame.h"
#import "CXInformationThreeCellFrame.h"

@implementation CXInformationTableView

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *InformationCellIdentifier = @"InformationCellIdentifier1";
    CXInformationTwoCell *Informationcell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
    if (Informationcell == nil) {
        Informationcell = [[CXInformationTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
    }
    if (_sourceDatas.count!=0) {
    CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    NSInteger pageTypeNum=[model.pageType integerValue];
    //1：版式一，2：版式二(默认)；3：版式三
    switch (pageTypeNum) {
        case 1:
        {
            static NSString *InformationCellIdentifier = @"InformationCellIdentifier1";
            CXInformationTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
            if (cell == nil) {
                cell = [[CXInformationTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
            }
            if (_sourceDatas.count!=0) {
                
                
                cell.informationModel = model;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        case 3:
        {
            static NSString *InformationCellIdentifier = @"InformationCellIdentifier3";
            CXInformationthreeCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
            if (cell == nil) {
                cell = [[CXInformationthreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
            }
            if (_sourceDatas.count!=0) {
                
                
                cell.informationModel = model;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        default:
        {
            static NSString *InformationCellIdentifier = @"InformationCellIdentifier2";
            CXInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
            if (cell == nil) {
                cell = [[CXInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
            }
            if (_sourceDatas.count!=0) {
                
                
                cell.informationModel = model;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
    }
    }
    return Informationcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
    CXInformationModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        NSInteger pageTypeNum=[model.pageType integerValue];
        //1：版式一，2：版式二(默认)；3：版式三
        switch (pageTypeNum) {
            case 1:
            {
                CXInformationTwoCellFrame *cellFrame = [[CXInformationTwoCellFrame alloc] initWithDataModel:model];
                return [cellFrame cellHeight];
            }
                break;
            case 3:
            {
                CXInformationThreeCellFrame *cellFrame = [[CXInformationThreeCellFrame alloc] initWithDataModel:model];
                return [cellFrame cellHeight];
            }
                break;
            default:
            {
                CXInformationCellFrame *cellFrame = [[CXInformationCellFrame alloc] initWithDataModel:model];
                return [cellFrame cellHeight];
            }
                break;
        }

    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    if (self.isHaveSection)
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
        UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
        titleLable.text = @"今日分享";
        titleLable.font = kMiddleTextFontBold;
        titleLable.textColor = [UIColor grayColor];
        titleLable.numberOfLines = 1;
        [flagView addSubview:titleLable];
        
        return customView;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHaveSection)
    {
        return kFunctionBarHeight;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
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

@end
