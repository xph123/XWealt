//
//  CSMenuTable.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XMenuTable.h"
#import "XMenuCell.h"
#import "CXCategoryModel.h"

@interface XMenuTable () {
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;
@end

@implementation XMenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray arrayWithArray:items];
        
//        self.layer.backgroundColor = [UIColor color:[SIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = self.bounds;
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*44.0f;
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, kScreenWidth, self.table.bounds.size.height)];
//        header.backgroundColor = [UIColor color:[SIMenuConfiguration itemsColor] withAlpha:[SIMenuConfiguration menuAlpha]];
        [self.table addSubview:header];
        
    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    if (!self.table.tableFooterView) {
        [self addFooter];
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.table.frame = endFrame;
        self.table.contentOffset = CGPointMake(0, -7.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.table.contentOffset = CGPointMake(0, -7.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            self.layer.backgroundColor = [UIColor clearColor].CGColor;
            self.table.frame = startFrame;
        } completion:^(BOOL finished) {
            //            [self.table deselectRowAtIndexPath:currentIndexPath animated:NO];
            XMenuCell *cell = (XMenuCell *)[self.table cellForRowAtIndexPath:currentIndexPath];
            [cell setSelected:NO withCompletionBlock:^{
                
            }];
            currentIndexPath = nil;
            [self removeFooter];
            [self.table removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
}

- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return 0.3f*percentage/100.0;
}

- (void)addFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.table.bounds.size.height - (self.items.count * 44.0f))];
    self.table.tableFooterView = footer;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [footer addGestureRecognizer:tap];
}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    XMenuCell *cell = (XMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[XMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CXCategoryModel *model = [self.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndexPath = indexPath;
    
    XMenuCell *cell = (XMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES withCompletionBlock:^{
        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMenuCell *cell = (XMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO withCompletionBlock:^{
        
    }];
}

@end
