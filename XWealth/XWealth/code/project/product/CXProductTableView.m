//
//  CXProductView.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductTableView.h"
#import "CXProductCell.h"
#import "CXProductCellFrame.h"

@implementation CXProductTableView

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
        [promptButton setTitle: @"抱歉，没有该分类产品！" forState: UIControlStateNormal];
        promptButton.titleLabel.font = kLargeTextFont;
        [promptButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [promptButton setImage:[UIImage imageNamed:@"error_prompt"] forState:UIControlStateNormal];
        [promptButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        promptButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: promptButton];
        self.promptView = promptButton;
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *productCellIdentifier = @"productCellIdentifier";
        CXProductCell *cell = [[CXProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
        if (cell == nil) {
            cell = [[CXProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
        }
    if (_sourceDatas.count!=0)
    {
        CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        cell.sProductModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
    CXProductSimplyModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    CXProductCellFrame *cellFrame = [[CXProductCellFrame alloc] initWithDataModel:model];
    return [cellFrame cellHeight];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHaveSection)
    {
        return kLabelHeight;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    if (self.isHaveSection)
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kLabelHeight)];
        customView.backgroundColor = kControlBgColor;
        
        UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
        flagView.backgroundColor = [UIColor whiteColor];
        
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, (kLabelHeight-kIconSmallHeight)/2, 3, kIconSmallHeight-1)];
        leftView.backgroundColor = [UIColor redColor];
        [flagView addSubview:leftView];
        
        
        //加框
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = kScreenWidth;
        CGFloat height = kLabelHeight - 0.5;
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return kFunctionBarHeight;
//}

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
