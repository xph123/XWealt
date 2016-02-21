//
//  CSGridViewController.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XGridView.h"
#import "XGridViewCell.h"

@interface XGridView ()
{
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) UIGridView *table;

@end

@implementation XGridView

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        _projectList = items;
        //        self.layer.backgroundColor = [UIColor color:[SIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = self.bounds;
        startFrame = endFrame;
        startFrame.origin.y -= [self numberOfRows] *ProjectGridCellHeight;
        
//        self.table = [[UIGridView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table = [[UIGridView alloc] init];
        self.table.frame = startFrame;
        self.table.uiGridViewDelegate = self;
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
//            CSMenuCell *cell = (CSMenuCell *)[self.table cellForRowAtIndexPath:currentIndexPath];
//            [cell setSelected:NO withCompletionBlock:^{
//                
//            }];
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
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.table.bounds.size.height - ([self numberOfRows] * ProjectGridCellHeight))];
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

- (int) numberOfRows
{
    int rows = (self.projectList.count / ProjectGridColumns);
    if ((self.projectList.count % ProjectGridColumns) > 0)
    {
        rows += 1;
    }

    return rows;
}


- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	return ProjectGridCellWidth;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	return ProjectGridCellHeight;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 3;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return [_projectList count];
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	XGridViewCell *cell = (XGridViewCell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
		cell = [[XGridViewCell alloc] init];
	}
	
	[cell setProjectModel:[_projectList objectAtIndex:rowIndex * 3 + columnIndex] andSelected:0];
	
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
	NSLog(@"%d, %d clicked", rowIndex, colIndex);
    [self.menuDelegate gridView:grid didSelectRowAt:rowIndex AndColumnAt:colIndex];
}

- (void) reloadData
{
    [self.table reloadData];
};

@end
