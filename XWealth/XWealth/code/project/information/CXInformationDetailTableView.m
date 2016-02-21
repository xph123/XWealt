//
//  CXInformationDetailTableView.m
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationDetailTableView.h"
#import "CXInformationDetailHeaderCell.h"
#import "CXInformationDetailHeaderFrame.h"

@implementation CXInformationDetailTableView

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
        CGRect tableVFrame = self.bounds;
        //tableView
        self.tableView = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kColorWhite;
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString *InformationCellIdentifier = @"InformationCellIdentifier";
        CXInformationDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellIdentifier];
        if (cell == nil) {
            cell = [[CXInformationDetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InformationCellIdentifier];
        }
        
        cell.informationModel = _informationModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSString *imgInformationCellIdentifier = @"ImgInformationCellIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:imgInformationCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgInformationCellIdentifier];
        }
        
        cell.backgroundColor = kColorWhite;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kScreenWidth - 2 * kDefaultMargin, [self imageViewHeight])];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullInformationUrl: self.informationModel.imageUrl]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
        [cell addSubview:imageView];
        
        //设置Cell选中时的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 2)
    {
        NSString *textInformationCellIdentifier = @"TextInformationCellIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:textInformationCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textInformationCellIdentifier];
        }
        
        cell.backgroundColor = kColorWhite;
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, kScreenWidth - 2 * kDefaultMargin, [self contentViewHeight])];
        contentLabel.font = kMiddleTextFont;
        contentLabel.textColor = kTextColor;
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.text = _informationModel.content;
        [cell addSubview:contentLabel];
        
        //设置Cell选中时的背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return Nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.row == 0)
    {
        CXInformationDetailHeaderFrame *cellFrame = [[CXInformationDetailHeaderFrame alloc] initWithDataModel:_informationModel];
        height = [cellFrame cellHeight];
    }
    else if (indexPath.row == 1)
    {
        height = [self imageViewHeight];
    }
    else
    {
        height = [self contentViewHeight];
    }
    
    return height;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    CXTaskModel *model = [[_sourceDatas objectAtIndex:section] objectAtIndex:0];
//    return model.planDate;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - data



#pragma mark - private methods

- (CGFloat) imageViewHeight
{
    CGFloat height = 0;
    
    if (self.informationModel.imageUrl.length > 0)
    {
        if (self.informationModel.imgWidth != 0)
        {
            height = self.informationModel.imgHeight * (kScreenWidth - 2 * kDefaultMargin) / self.informationModel.imgWidth;
            height += 2 * kDefaultMargin;
        }
    }
    
    return height;
}


- (CGFloat) contentViewHeight
{
    CGFloat height = 0;
    
    if (self.informationModel.content.length > 0)
    {
        height = [_informationModel.content getSizeWithWidth:(kScreenWidth - 2 * kDefaultMargin) fontSize:kMiddleTextFontSize].height + 5;
        height += 2 * kDefaultMargin;
    }
    
    return height;
}


@end
