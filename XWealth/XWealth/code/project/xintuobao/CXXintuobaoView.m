//
//  CXXintuobaoView.m
//  XWealth
//
//  Created by chx on 15/9/6.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXintuobaoView.h"
#import "CXXintuobaoCell.h"

@implementation CXXintuobaoView

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
        _Arrow=NO;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_hotSaleDatas count];
    }
    else
    {
        return [_earlyDatas count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productCellIdentifier = @"productCellIdentifier";
    CXXintuobaoCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
    if (cell == nil) {
        cell = [[CXXintuobaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        if (_hotSaleDatas.count!=0)
        {
            CXXintuoBaoModel *model = [_hotSaleDatas objectAtIndex:indexPath.row];
            cell.productModel = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else
    {
        if (_hotSaleDatas.count!=0)
        {
            CXXintuoBaoModel *model = [_earlyDatas objectAtIndex:indexPath.row];
            cell.productModel = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (_hotSaleDatas.count!=0) {
            CXXintuoBaoModel *model = [_hotSaleDatas objectAtIndex:indexPath.row];
            CXXintuobaoCellFrame *cellFrame = [[CXXintuobaoCellFrame alloc] initWithDataModel:model];
            return [cellFrame cellHeight];
        }
    }
    else
    {
        if (_earlyDatas.count!=0) {
            CXXintuoBaoModel *model = [_earlyDatas objectAtIndex:indexPath.row];
            CXXintuobaoCellFrame *cellFrame = [[CXXintuobaoCellFrame alloc] initWithDataModel:model];
            return [cellFrame cellHeight];
        }
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight)];
    customView.backgroundColor = kControlBgColor;

    //加框
    CGFloat x = -1;
    CGFloat y = 0;
    CGFloat width = kScreenWidth+2;
    CGFloat height = kFunctionBarHeight;
    CGRect rect = CGRectMake(x, y, width, height);

    
    CGFloat linex = 0;
    CGFloat liney = kFunctionBarHeight;
    CGFloat lineWidth = kScreenWidth;
    CGFloat lineHeight = 0.5;
    CGRect lineRect = CGRectMake(linex, liney, lineWidth, lineHeight);
    if (section == 0)
    {
        UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
        titleLable.text = @"正在热售";
        titleLable.font = kLargeTextFont;
        titleLable.textColor = kColorRed;
        titleLable.numberOfLines = 1;
        titleLable.textAlignment = NSTextAlignmentCenter;
        [customView addSubview:titleLable];
        
        UIView *line=[[UIView alloc]initWithFrame:lineRect];
        line.backgroundColor=kLineColor2;
        [customView addSubview:line];
    }
    else
    {
        UIButton *earlyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        earlyBtn.frame = rect;
        earlyBtn.layer.masksToBounds = YES;
        earlyBtn.layer.borderColor = kLineColor2.CGColor;
        earlyBtn.layer.borderWidth = 0.5;
        [earlyBtn setBackgroundColor:[UIColor clearColor]];
        [earlyBtn setTitle: @"往期回顾" forState: UIControlStateNormal];
        earlyBtn.titleLabel.font = kLargeTextFont;
        [earlyBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        if (_Arrow==NO) {
             [earlyBtn setImage:[UIImage imageNamed:@"showmore"] forState:UIControlStateNormal];
        }
       else
       {
           [earlyBtn setImage:[UIImage imageNamed:@"hidemore"] forState:UIControlStateNormal];
       }
        [earlyBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        earlyBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [earlyBtn addTarget:self action:@selector(showEarlyDatas:) forControlEvents:UIControlEventTouchUpInside];
        [customView addSubview: earlyBtn];

    }
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kFunctionBarHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
}


#pragma mark - data

- (void) configData:(NSArray *)hotSaleDatas
{
    _hotSaleDatas = hotSaleDatas;
    
    if ([self.hotSaleDatas count] == 0)
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

- (void) configEarlyData:(NSArray *)earlyDatas
{
    _earlyDatas = earlyDatas;
    [self.tableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate tableViewDidScroll:scrollView];
}

- (void) showEarlyDatas:(UIButton*)button
{
    [self.delegate showEarlyDatas];
}


@end
