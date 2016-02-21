//
//  CXBuybackTrustCenterDetailTableView.m
//  XWealth
//
//  Created by gsycf on 15/11/2.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterDetailTableView.h"
#import "CXInformationModel.h"
#import "CXBuybackTrustCenterDetailCellFrame.h"
#import "CXBuybackTrustCenterDetailCell.h"
@implementation CXBuybackTrustCenterDetailTableView

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
        textFrame.origin.x += kDefaultMargin;
        textFrame.size.width -= 2 * kDefaultMargin;
        textFrame.size.height = kLabelHeight;
        
        UIButton * promptButton = [[UIButton alloc] initWithFrame:textFrame];
        [promptButton setBackgroundColor:kColorClear];
        [promptButton setTitle: @"资料不存在！" forState: UIControlStateNormal];
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
    CXBuybackTrustCenterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
    if (cell == nil) {
        cell = [[CXBuybackTrustCenterDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
    }
    if (_sourceDatas.count!=0&_sourceDatas!=nil) {
        CXBuybackRecordModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        cell.buybackRecordModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXBuybackRecordModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXBuybackTrustCenterDetailCellFrame *cellFrame = [[CXBuybackTrustCenterDetailCellFrame alloc] initWithDataModel:model];
        return [cellFrame cellHeight];
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
        flagView.backgroundColor=[UIColor blueColor];
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
        rect.size.width=kLabelWidth;
        UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
        titleLable.text = @"认购记录";
        titleLable.font = kMiddleTextFontBold;
        titleLable.textColor = kTitleTextColor;
        titleLable.numberOfLines = 1;
        [flagView addSubview:titleLable];
        
        if (_sourceDatas.count>0&&_sourceDatas!=nil) {
            rect.origin.x=kScreenWidth-kDefaultMargin-kLabelWidth;
            UILabel *countLable = [[UILabel alloc]initWithFrame:rect];
            countLable.text = [NSString stringWithFormat:@"%ld 条",self.countNum];
            countLable.font = kMiddleTextFontBold;
            countLable.textAlignment=NSTextAlignmentRight;
            countLable.textColor = [UIColor grayColor];
            countLable.numberOfLines = 1;
            [flagView addSubview:countLable];
        }
        
        
        
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<_sourceDatas.count) {
        CXBenefitRecordModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        if (model.userId==kAppDelegate.currentUserModel.userId) {
            return YES;
        }
        
    }
    return NO;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.delegate deleteItemAtIndex:indexPath.row];
    }
}


#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    if ([self.sourceDatas count] == 0)
    {
        self.promptView.hidden = NO;
    }
    else
    {
        self.promptView.hidden = YES;
        
        [self.tableView reloadData];
    }
}
- (void) configDataHaveHeaderView:(NSArray *)sourceDatas countNum:(NSInteger)count
{
    _sourceDatas = sourceDatas;
    self.countNum=count;
    // 有headerview 显示headerview ，不显示没有任务提醒
    self.promptView.hidden = YES;
    self.tableView.hidden = NO;
    
    [self.tableView reloadData];
    
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.delegate tableViewDidScroll:scrollView];
//}

@end
