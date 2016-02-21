//
//  CXCommentTableView.m
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCommentTableView.h"
#import "CXCommentCell.h"

@implementation CXCommentTableView 

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
        //tableView
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
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
    return [self.sourceDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CommentCellIdentifier = @"CommentCellIdentifier";
    CXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    if (cell == nil) {
        cell = [[CXCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellIdentifier];
    }
    CXCommentModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    cell.commentModel = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXCommentModel *model = [_sourceDatas objectAtIndex:indexPath.row];
    CXCommentFrame *layout = [[CXCommentFrame alloc] initWithDataModel:model];

    return [layout cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 30.0)];
    customView.backgroundColor = kControlBgColor;
    UIImageView *tips = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    tips.image = IMAGE(@"commnet_title");
    [customView addSubview:tips];
    
    
    // create the button object
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.opaque = NO;
    titleLabel.textColor = kTextColor;
    titleLabel.highlightedTextColor = [UIColor whiteColor];
    titleLabel.font = kMiddleTextFont;
    titleLabel.frame = CGRectMake(40.0, 5.0, 300.0, 20.0);
    titleLabel.text = StringCommentTitle;
    
    [customView addSubview:titleLabel];
    
 
    NSString *number = [NSString stringWithFormat:@"%ld 条", [_sourceDatas count]];
    
    CGSize size = [number getSizeWithWidth:200 fontSize:kSmallTextFontSize];
    int x = self.tableView.frame.origin.x + self.tableView.frame.size.width - 10 - size.width;
    
    UILabel * numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.opaque = NO;
    numberLabel.textColor = kAssistTextColor;
    numberLabel.highlightedTextColor = [UIColor whiteColor];
    numberLabel.font = kSmallTextFont;
    numberLabel.frame = CGRectMake(x, 5.0, size.width, 20.0);
    numberLabel.text = number;
    
    [customView addSubview:numberLabel];
    
    return customView;
}

#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    [self.tableView reloadData];
}

#pragma mark - private methods



@end
